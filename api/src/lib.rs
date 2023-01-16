mod models;
mod templates;

use askama::Template;
use axum::{
    extract::{Path, State},
    http::{HeaderValue, StatusCode},
    response::{Html, IntoResponse},
    routing::{get, post},
    Json, Router,
};
use mongodb::{
    bson::doc,
    options::{ClientOptions, FindOneOptions, ResolverConfig},
    Client, Collection,
};
use serde_json::Value;
use shuttle_secrets::SecretStore;
use sync_wrapper::SyncWrapper;
use tower_http::cors::CorsLayer;

use models::{Error, PasteExtractor, PasteSchema};
use templates::{ErrorTemplate, PasteTemplate};

async fn index() -> &'static str {
    "Pastebin service

    POST /
    GET /:id
    GET /raw/:id
    "
}

async fn create_paste(
    State(collection): State<Collection<PasteSchema>>,
    Json(payload): Json<PasteExtractor>,
) -> Json<Value> {
    let schema = PasteSchema::new(payload.lang, payload.content);

    let result = collection.insert_one(&schema, None).await;

    match result {
        Ok(_) => schema.to_json(),
        Err(err) => Error::new(err.to_string().as_str()).to_json(),
    }
}

async fn get_paste(
    Path(uuid): Path<String>,
    State(collection): State<Collection<PasteSchema>>,
) -> impl IntoResponse {
    let result = collection
        .find_one(doc! {"uuid": &uuid}, FindOneOptions::default())
        .await;

    let res = match result {
        Ok(res) => match res {
            Some(paste) => PasteTemplate::new(paste.uuid, paste.lang, paste.content).render(),
            None => ErrorTemplate::new("No paste found for the given ID".to_string()).render(),
        },
        Err(err) => ErrorTemplate::new(err.to_string()).render(),
    };

    match res {
        Ok(html) => Html(html).into_response(),
        Err(err) => (
            StatusCode::INTERNAL_SERVER_ERROR,
            format!("Failed to render template. Error: {}", err),
        )
            .into_response(),
    }
}

async fn get_raw_paste(
    Path(uuid): Path<String>,
    State(collection): State<Collection<PasteSchema>>,
) -> Json<Value> {
    let result = collection
        .find_one(doc! {"uuid": &uuid}, FindOneOptions::default())
        .await;

    match result {
        Ok(res) => match res {
            Some(paste) => paste.to_json(),
            None => Error::new("No paste found for the given ID").to_json(),
        },
        Err(err) => Error::new(err.to_string().as_str()).to_json(),
    }
}

#[shuttle_service::main]
async fn axum(
    #[shuttle_secrets::Secrets] secret_store: SecretStore,
) -> shuttle_service::ShuttleAxum {
    let mut client_options = ClientOptions::parse_with_resolver_config(
        secret_store.get("MONGO_URL").unwrap(),
        ResolverConfig::cloudflare(),
    )
    .await
    .expect("Incorrect MongoDB URL");

    client_options.app_name = Some(String::from("excode"));
    let client = Client::with_options(client_options).expect("Failed to initialise MongoDB client");
    let collection = client
        .database("excode")
        .collection::<PasteSchema>("pastes");

    let router = Router::new()
        .route("/", get(index))
        .route("/", post(create_paste))
        .route("/:id", get(get_paste))
        .route("/raw/:id", get(get_raw_paste))
        .with_state(collection)
        .layer(
            CorsLayer::new().allow_origin([
                "http://127.0.0.1:8000".parse::<HeaderValue>().unwrap(),
                "https://dhzdhd.github.io/ExCode/"
                    .parse::<HeaderValue>()
                    .unwrap(),
            ]),
        );
    let sync_wrapper = SyncWrapper::new(router);

    Ok(sync_wrapper)
}
