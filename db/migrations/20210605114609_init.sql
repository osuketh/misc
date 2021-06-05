-- migrate:up

CREATE EXTENSION IF NOT EXISTS mysql_fdw;
CREATE EXTENSION IF NOT EXISTS anon CASCADE;
SELECT anon.init();

CREATE TABLE departments (
    id serial PRIMARY KEY,
    name text NOT NULL
);

CREATE TABLE employees (
    id serial PRIMARY KEY,
    last_name text NOT NULL,
    first_name text NOT NULL,
    email text NOT NULL,
    salary int NOT NULL,
    department_id int NOT NULL REFERENCES departments (id),
    birth date NOT NULL
);

INSERT INTO departments (name) VALUES
    ('営業部'),
    ('技術部');

INSERT INTO employees (last_name, first_name, email, salary, department_id, birth) VALUES
    ('佐藤', '太郎', 'sato@example.com', 300000, 1, '1987-01-02'),
    ('鈴木', '次郎', 'suzuki@example.com', 300000, 2, '1988-03-04'),
    ('高橋', '三郎', 'takahashi@example.com', 350000, 1, '1989-05-06'),
    ('田中', '花子', 'tanaka@example.com', 350000, 2, '1990-07-08'),
    ('伊藤', '雪子', 'ito@example.com', 400000, 1, '1991-09-10'),
    ('渡辺', '月子', 'watanabe@example.com', 400000, 2, '1992-11-12');

SECURITY LABEL FOR anon ON COLUMN employees.email IS 'MASKED WITH FUNCTION anon.partial_email(email)';
SELECT anon.start_dynamic_masking();

CREATE ROLE masked_user LOGIN PASSWORD 'password';
SECURITY LABEL FOR anon ON ROLE masked_user IS 'MASKED';
GRANT SELECT ON ALL TABLES IN SCHEMA mask TO masked_user;

-- migrate:down
DROP TABLE `departments`;
DROP TABLE `employees`;
