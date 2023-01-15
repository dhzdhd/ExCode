use askama::Template;
use axum::{
    extract::{Path, State},
    http::{HeaderValue, StatusCode},
    response::{Html, IntoResponse, Response},
    routing::{get, post},
    Router,
};
use mongodb::{
    options::{ClientOptions, ResolverConfig},
    Client, Collection,
};
use serde::{Deserialize, Serialize};
use shuttle_secrets::SecretStore;
use sync_wrapper::SyncWrapper;
use tower_http::cors::CorsLayer;
use uuid::Uuid;

async fn index() -> &'static str {
    "Pastebin service

    GET /:id
    POST
    GET /raw/:id
    "
}

#[derive(Template)]
#[template(path = "hello.html")]
struct DocTemplate {
    id: String,
    lang: String,
    content: String,
}

struct HtmlTemplate<T>(T);

impl<T> IntoResponse for HtmlTemplate<T>
where
    T: Template,
{
    fn into_response(self) -> Response {
        match self.0.render() {
            Ok(html) => Html(html).into_response(),
            Err(err) => (
                StatusCode::INTERNAL_SERVER_ERROR,
                format!("Failed to render template. Error: {}", err),
            )
                .into_response(),
        }
    }
}

#[derive(Debug, Serialize, Deserialize)]
struct PasteSchema {
    uuid: String,
    lang: String,
    content: String,
}

impl PasteSchema {
    fn new(lang: String, content: String) -> Self {
        Self {
            uuid: Uuid::new_v4().to_string(),
            lang,
            content,
        }
    }
}

async fn create_paste(State(collection): State<Collection<PasteSchema>>) {
    let result = collection
        .insert_one(
            PasteSchema::new("py".to_string(), "print(\"Hi\")".to_string()),
            None,
        )
        .await;

    match result {
        Ok(res) => (),
        Err(err) => (),
    }
}

async fn get_paste(
    Path(id): Path<String>,
    State(state): State<Collection<PasteSchema>>,
) -> impl IntoResponse {
    let template = DocTemplate {
        id: id.to_string(),
        lang: "py".to_string(),
        content: "print(\"Hello World\")".to_string(),
    };

    HtmlTemplate(template)
}

async fn get_raw_paste(Path(id): Path<String>) {}

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
