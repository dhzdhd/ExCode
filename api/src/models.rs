use axum::{http::StatusCode, response::IntoResponse, response::Response, Json};
use mongodb::bson::Uuid;
use serde::{Deserialize, Serialize};
use serde_json::json;

#[derive(Deserialize, Serialize)]
pub enum Error {
    EmptyLanguage,
    EmptyContent,
    DatabaseError(String),
}

impl IntoResponse for Error {
    fn into_response(self) -> Response {
        let (status, message) = match self {
            Error::EmptyLanguage => (
                StatusCode::UNPROCESSABLE_ENTITY,
                "The language field is empty".to_string(),
            ),
            Error::EmptyContent => (
                StatusCode::UNPROCESSABLE_ENTITY,
                "The content field is empty".to_string(),
            ),
            Error::DatabaseError(err) => (StatusCode::UNPROCESSABLE_ENTITY, err),
        };

        let body = Json(json!({ "message": message }));
        (status, body).into_response()
    }
}

#[derive(Debug, Serialize, Deserialize)]
pub struct PasteSchema {
    pub uuid: String,
    pub lang: String,
    pub content: String,
}

impl PasteSchema {
    pub fn new(lang: String, content: String) -> Self {
        Self {
            uuid: Uuid::new().to_string().replace("-", ""),
            lang,
            content,
        }
    }
}

#[derive(Serialize, Deserialize)]
pub struct PasteExtractor {
    pub lang: String,
    pub content: String,
}
