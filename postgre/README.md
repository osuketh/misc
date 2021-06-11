# pm1

### tools

* DB migration tool: https://github.com/amacneil/dbmate
* PostgreSQL Anonymizer: https://postgresql-anonymizer.readthedocs.io/en/latest/
* MySQL FDW: https://github.com/EnterpriseDB/mysql_fdw

### Usage

```bash
docker-compose up -d
source ./.env

dbmate -d "schema/posgre/migrations" new init
dbmate -d "schema/mysql/migrations" new init

DATABASE_URL="postgres://${PG_USER}:${PG_PASSWORD}@0.0.0.0:5432/${PG_NAME}?sslmode=disable" dbmate -d "schema/posgre/migrations" up
DATABASE_URL="mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@0.0.0.0:3306/${MYSQL_NAME}" dbmate -d "schema/mysql/migrations" up
```

#### Demo anonymizer

```bash
psql ${PG_NAME} -h localhost -p 5432 -U postgres
SELECT * FROM employees;

\c - masked_user;
SELECT * FROM employees;
```
