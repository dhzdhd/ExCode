use askama::Template;
use axum::{
    extract::{Path, State},
    http::{HeaderValue, StatusCode},
    response::{Html, IntoResponse, Response},
    routing::{get, post},
    Router,
};
use shuttle_service::Context;
use sqlx::{Executor, PgPool};
use sync_wrapper::SyncWrapper;
use tower_http::cors::CorsLayer;
use uuid::Uuid;

async fn index() -> &'static str {
    "Pastebin service

    GET /:id
    POST /:id
    GET /raw/:id
    POST /raw/:id
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

async fn create_paste(Path(id): Path<String>) {}

async fn get_paste(Path(id): Path<String>, State(state): State<PgPool>) -> impl IntoResponse {
    let template = DocTemplate {
        id: id.to_string(),
        lang: "py".to_string(),
        content: "print(\"Hello World\")".to_string(),
    };

    HtmlTemplate(template)
}

#[shuttle_service::main]
async fn axum(#[shuttle_shared_db::Postgres] pool: PgPool) -> shuttle_service::ShuttleAxum {
    pool.execute(include_str!("../schema/schema.sql"))
        .await
        .context("Failed to run migrations")?;

    let router = Router::new()
        .route("/", get(index))
        .route("/:id", get(get_paste))
        .route("/:id", post(create_paste))
        .with_state(pool)
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
