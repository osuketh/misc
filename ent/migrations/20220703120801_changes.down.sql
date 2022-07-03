-- reverse: create "groups" table
DROP TABLE `groups`;
-- reverse: create "users" table
DROP TABLE `users`;
-- reverse: create "todos" table
DROP TABLE `todos`;
-- reverse: modify "schema_migrations" table
ALTER TABLE `schema_migrations` MODIFY COLUMN `version` bigint NOT NULL, COLLATE utf8mb4_0900_ai_ci;
