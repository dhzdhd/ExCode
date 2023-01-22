mod models;
mod templates;

use askama::Template;
use axum::{
    extract::{Path, State},
    http::StatusCode,
    response::{Html, IntoResponse},
    routing::get,
    Json, Router,
};
use mongodb::{
    bson::doc,
    options::{ClientOptions, FindOneOptions, ResolverConfig},
    Client, Collection,
};
use shuttle_secrets::SecretStore;
use sync_wrapper::SyncWrapper;
use tower_http::cors::CorsLayer;

use models::{Error, PasteExtractor, PasteSchema};
use templates::{EditTemplate, ErrorTemplate, HtmlTemplate, PasteTemplate};

async fn index() -> &'static str {
    "Pastebin service

    GET /
    POST /
    GET /:id
    GET /json/:id
    GET /raw/:id
    "
}

async fn get_editor() -> impl IntoResponse {
    HtmlTemplate(EditTemplate)
}

async fn create_paste(
    State(collection): State<Collection<PasteSchema>>,
    Json(payload): Json<PasteExtractor>,
) -> Result<Json<PasteSchema>, Error> {
    if payload.lang.trim().is_empty() {
        return Err(Error::EmptyLanguage);
    }
    if payload.content.trim().is_empty() {
        return Err(Error::EmptyContent);
    }

    let schema = PasteSchema::new(payload.lang, payload.content);

    let result = collection.insert_one(&schema, None).await;

    match result {
        Ok(_) => Ok(schema.into()),
        Err(err) => Err(Error::DatabaseError(err.to_string())),
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

async fn get_json_paste(
    Path(uuid): Path<String>,
    State(collection): State<Collection<PasteSchema>>,
) -> Result<Json<PasteSchema>, Error> {
    let result = collection
        .find_one(doc! {"uuid": &uuid}, FindOneOptions::default())
        .await;

    match result {
        Ok(res) => match res {
            Some(paste) => Ok(paste.into()),
            None => Err(Error::DatabaseError(String::from(
                "No paste found for the given ID",
            ))),
        },
        Err(err) => Err(Error::DatabaseError(err.to_string())),
    }
}

async fn get_raw_paste(
    Path(uuid): Path<String>,
    State(collection): State<Collection<PasteSchema>>,
) -> Result<String, Error> {
    let result = collection
        .find_one(doc! {"uuid": &uuid}, FindOneOptions::default())
        .await;

    match result {
        Ok(res) => match res {
            Some(paste) => Ok(paste.content),
            None => Err(Error::DatabaseError(String::from(
                "No paste found for the given ID",
            ))),
        },
        Err(err) => Err(Error::DatabaseError(err.to_string())),
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
        .route("/", get(get_editor).post(create_paste))
        .route("/about", get(index))
        .route("/info", get(index))
        .route("/help", get(index))
        .route("/:id", get(get_paste))
        .route("/json/:id", get(get_json_paste))
        .route("/raw/:id", get(get_raw_paste))
        .with_state(collection)
        .layer(CorsLayer::permissive());
    let sync_wrapper = SyncWrapper::new(router);

    Ok(sync_wrapper)
}
