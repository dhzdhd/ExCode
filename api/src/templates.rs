use askama::Template;
use axum::{
    http::StatusCode,
    response::{Html, IntoResponse, Response},
};

#[derive(Template)]
#[template(path = "paste.html")]
pub struct PasteTemplate {
    pub id: String,
    pub lang: String,
    pub content: String,
}

impl PasteTemplate {
    pub fn new(id: String, lang: String, content: String) -> Self {
        Self { id, lang, content }
    }
}

#[derive(Template)]
#[template(path = "error.html")]
pub struct ErrorTemplate {
    pub error: String,
}

impl ErrorTemplate {
    pub fn new(error: String) -> Self {
        Self { error }
    }
}

struct HtmlTemplate<T: Template>(T);

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
