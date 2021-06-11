// TODO: type converting checks against primitives
// we can use `#[serde(try_from = "FromType")]` syntax
use serde::{Deserialize, Serialize};
use sqlx::types::{chrono::NaiveDateTime, uuid::Uuid};

#[derive(sqlx::Type, Debug, Serialize, Deserialize)]
#[sqlx(type_name = "db_type_enum")]
#[sqlx(rename_all = "lowercase")]
pub(crate) enum DBType {
    Mysql,
}

#[derive(Debug, Serialize, Deserialize)]
pub(crate) struct DBName(String);

#[derive(Debug, Serialize, Deserialize)]
pub(crate) struct UserName(String);

#[derive(Debug, Serialize, Deserialize)]
pub(crate) struct Password(String);

#[derive(Debug, Serialize, Deserialize)]
pub(crate) struct Host(String);

#[derive(Debug, Serialize, Deserialize)]
pub(crate) struct Port(u16);

#[derive(Debug)]
pub(crate) struct DataSourceRecord {
    db_type: DBType,
    db_name: DBName,
    user_name: UserName,
    password: Password,
    host: Host,
    port: Port,
    deleted_at: NaiveDateTime,
    registered_at: NaiveDateTime,
    modified_at: NaiveDateTime,
    created_at: NaiveDateTime,
    updated_at: NaiveDateTime,
}

