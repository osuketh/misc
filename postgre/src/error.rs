use thiserror::Error;

/// The result type in this crate
pub type Result<T> = std::result::Result<T, DpmError>;

#[derive(Error, Debug)]
pub enum DpmError {
    #[error("Anyhow error: {0}")]
    AnyhowError(#[from] anyhow::Error),
    #[error("Sqlx error: {0}")]
    SqlxError(#[from] sqlx::Error),
}
