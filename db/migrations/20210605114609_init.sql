-- migrate:up

CREATE EXTENSION IF NOT EXISTS mysql_fdw;
CREATE EXTENSION IF NOT EXISTS anon CASCADE;
SELECT anon.init();

SECURITY LABEL FOR anon ON COLUMN employees.email IS 'MASKED WITH FUNCTION anon.partial_email(email)';
SELECT anon.start_dynamic_masking();

CREATE ROLE masked_user LOGIN PASSWORD 'password';
SECURITY LABEL FOR anon ON ROLE masked_user IS 'MASKED';
GRANT SELECT ON ALL TABLES IN SCHEMA mask TO masked_user;

-- migrate:down
DROP EXTENSION mysql_fdw;
DROP EXTENSION anon CASCADE;
