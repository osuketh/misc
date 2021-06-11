use crate::service::data_source::DataSourceSvc;
use crate::types::data_source::*;
use actix_web::{get, post, web, HttpResponse, Responder};
use serde::{Deserialize, Serialize};
use sqlx::PgPool;

#[derive(Debug, Serialize, Deserialize)]
pub(crate) struct DataSourcePostRequest {
    db_type: DBType,
    db_name: DBName,
    user_name: UserName,
    password: Password,
    host: Host,
    port: Port,
}

async fn create_data_source(
    req: web::Json<DataSourcePostRequest>,
    db_pool: web::Data<PgPool>,
) -> impl Responder {
    let res = DataSourceSvc::create(db_pool.get_ref()).await?;
    HttpResponse::Ok().json(res)
}
