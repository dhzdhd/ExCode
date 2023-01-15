use axum::Json;
use mongodb::bson::Uuid;
use serde::{Deserialize, Serialize};
use serde_json::Value;

#[derive(Deserialize, Serialize)]
pub struct Error<'a> {
    message: &'a str,
}

impl<'a> Error<'a> {
    pub fn new(message: &'a str) -> Self {
        Self { message }
    }

    pub fn to_json(&self) -> Json<Value> {
        Json(serde_json::to_value(self).unwrap())
    }
}

#[derive(Debug, Serialize, Deserialize)]
pub struct PasteSchema {
    uuid: String,
    lang: String,
    content: String,
}

impl PasteSchema {
    pub fn new(lang: String, content: String) -> Self {
        Self {
            uuid: Uuid::new().to_string(),
            lang,
            content,
        }
    }

    pub fn to_json(&self) -> Json<Value> {
        Json(serde_json::to_value(self).unwrap())
    }
}
