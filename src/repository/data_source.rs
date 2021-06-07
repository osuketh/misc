use crate::error::Result;
use crate::types::data_source::*;
use serde::{Deserialize, Serialize};
use sqlx::types::{chrono::NaiveDateTime, uuid::Uuid};
use sqlx::PgPool;

#[derive(sqlx::FromRow, Debug)]
pub(crate) struct DataSource {
    id: Uuid,
    tenant_id: Uuid,
    db_type: DBType,
    db_name: String,
    user_name: String,
    host: String,
    port: i32,
}

impl DataSource {
    pub(crate) async fn create(pool: &PgPool, data_source: DataSource) -> Result<Self> {
        const STATEMENT: &str = r#"
            INSERT INTO data_source (
                id,
                tenant_id,
                db_type,
                db_name,
                user_name,
                password,
                host,
                deleted_at,
                registered_at,
                modified_at,
                created_at,
                updated_at
            ) VALUES (
                $1
            ) RETURNING *;
        "#;

        let mut tx = pool.begin().await?;
        let record = sqlx::query(STATEMENT)
            .bind(data_source.db_type)
            .fetch_one(&mut tx)
            .await?;

        tx.commit().await?;
        Ok(record)
    }

    pub(crate) fn get_by_tenant_id(tenant_id: Uuid) {}
}
