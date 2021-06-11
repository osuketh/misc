-- migrate:up

CREATE TYPE db_type_enum AS ENUM ('mysql');

CREATE TABLE data_source (
    id varchar(36) NOT NULL,
    tenant_id varchar(36) NOT NULL,
    db_type db_type_enum NOT NULL,
    db_name varchar(256) NOT NULL,
    user_name varchar(256) NOT NULL,
    password varchar(255) NOT NULL,
    host varchar(256) NOT NULL,
    port integer NOT NULL,
    deleted_at timestamp NULL DEFAULT NULL,
    registered_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

COMMENT ON COLUMN fdw_db.db_type IS 'DB種類';

COMMENT ON COLUMN fdw_db.db_name IS 'DB名';

COMMENT ON COLUMN fdw_db.user_name IS 'DBユーザー名';

COMMENT ON COLUMN fdw_db.password IS 'DBパスワード';

COMMENT ON COLUMN fdw_db.host IS 'DBホスト名';

COMMENT ON COLUMN fdw_db.port IS 'DBポート番号';

CREATE FUNCTION set_update_time() RETURNS opaque AS '
  begin
    new.updated_at := ''now'';
    return new;
  end;
' LANGUAGE 'plpgsql';

create trigger update_tri before
update
    on fdw_db for each row execute procedure set_update_time();

CREATE EXTENSION IF NOT EXISTS mysql_fdw;

CREATE SERVER mpi_mysql FOREIGN DATA WRAPPER mysql_fdw OPTIONS (host 'mysql', port '3306');

CREATE USER MAPPING FOR public SERVER mpi_mysql OPTIONS (password 'password', username 'root');

CREATE SCHEMA mysql_fdw;

SET
    search_path TO mysql_fdw,
    public;

IMPORT FOREIGN SCHEMA anonify
FROM
    SERVER mpi_mysql INTO mysql_fdw;

CREATE EXTENSION IF NOT EXISTS anon CASCADE;

SELECT
    anon.init();

SECURITY LABEL FOR anon ON COLUMN employees.email IS 'MASKED WITH FUNCTION anon.partial_email(email)';

SELECT
    anon.start_dynamic_masking('mysql_fdw');

CREATE ROLE masked_user LOGIN PASSWORD 'password';

SECURITY LABEL FOR anon ON ROLE masked_user IS 'MASKED';

GRANT
SELECT
    ON ALL TABLES IN SCHEMA mask TO masked_user;

-- migrate:down
DROP EXTENSION mysql_fdw;

DROP EXTENSION anon CASCADE;

REASSIGN OWNED BY masked_user TO postgres;

DROP OWNED BY masked_user;

DROP ROLE masked_user;