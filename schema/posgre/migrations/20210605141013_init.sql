-- migrate:up
CREATE EXTENSION IF NOT EXISTS mysql_fdw;
CREATE SERVER mpi_mysql FOREIGN DATA WRAPPER mysql_fdw OPTIONS (
    host 'mysql',
    port '3306'
);
CREATE USER MAPPING FOR public SERVER mpi_mysql OPTIONS (
    password 'password',
    username 'root'
);
CREATE SCHEMA mysql_fdw;
SET search_path TO mysql_fdw, public;
IMPORT FOREIGN SCHEMA anonify FROM SERVER mpi_mysql INTO mysql_fdw;


CREATE EXTENSION IF NOT EXISTS anon CASCADE;
SELECT anon.init();
SECURITY LABEL FOR anon ON COLUMN employees.email IS 'MASKED WITH FUNCTION anon.partial_email(email)';
SELECT anon.start_dynamic_masking('mysql_fdw');
CREATE ROLE masked_user2 LOGIN PASSWORD 'password';
SECURITY LABEL FOR anon ON ROLE masked_user IS 'MASKED';
GRANT SELECT ON ALL TABLES IN SCHEMA mask TO masked_user;

-- migrate:down
DROP EXTENSION mysql_fdw;
DROP EXTENSION anon CASCADE;
DROP ROLE masked_user;