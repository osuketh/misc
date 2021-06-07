#![deny(missing_debug_implementations)]

use actix_web::{App, HttpServer};
use anyhow::Result;
use dotenv::dotenv;
use listenfd::ListenFd;
use log::info;
use sqlx::PgPool;
use std::env;

mod routes;

#[actix_web::main]
async fn main() -> Result<()> {
    dotenv().ok();
    // To enabled hot reloading: systemfd --no-pid -s http::5000 -- cargo watch -x run
    let mut listenfd = ListenFd::from_env();
    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL is not set in .env file");
    let db_pool = PgPool::connect(&database_url).await?;

    let mut server =
        HttpServer::new(move || App::new().data(db_pool.clone()).configure(routes::init));
    server = match listenfd.take_tcp_listener(0)? {
        Some(listener) => server.listen(listener)?,
        None => {
            let host = env::var("HOST").expect("HOST is not set in .env file");
            let port = env::var("PORT").expect("PORT is not set in .env file");
            server.bind(format!("{}:{}", host, port))?
        }
    };

    info!("Starting server");
    server.run().await?;

    Ok(())
}
