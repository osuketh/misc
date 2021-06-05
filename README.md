# pm1

### tools

* DB migration tool: https://github.com/amacneil/dbmate
* PostgreSQL Anonymizer: https://postgresql-anonymizer.readthedocs.io/en/latest/
* MySQL FDW: https://github.com/EnterpriseDB/mysql_fdw

### Usage

```bash
docker-compose up -d
source ./.env
export DATABASE_URL=postgres://${PG_USER}:${PG_PASSWORD}@0.0.0.0:5432/${PG_NAME}?sslmode=disable

dbmate new init
dbmate up
```

#### Demo anonymizer

```bash
psql ${PG_NAME} -h localhost -p 5432 -U postgres
SELECT * FROM employees;

\c - masked_user;
SELECT * FROM employees;
```
