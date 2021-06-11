use sqlx::PgPool;
use crate::repository::data_source::DataSource;

#[derive(Debug)]

pub(crate) struct DataSourceSvc {
    db_pool: PgPool,
}

impl DataSourceSvc {
    pub(crate) fn create(pool: &PgPool) {
        // TODO: Fetch all and checks


    }
}
