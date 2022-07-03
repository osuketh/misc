-- modify "schema_migrations" table
ALTER TABLE `schema_migrations` COLLATE utf8mb4_bin, MODIFY COLUMN `version` varchar(255) NOT NULL;
-- create "todos" table
CREATE TABLE `todos` (`id` bigint NOT NULL AUTO_INCREMENT, `text` varchar(255) NOT NULL, `created_at` timestamp NULL, `status` enum('IN_PROGRESS','COMPLETED') NOT NULL, `priority` bigint NOT NULL, `todo_parent` bigint NULL, PRIMARY KEY (`id`), CONSTRAINT `todos_todos_child_todos` FOREIGN KEY (`todo_parent`) REFERENCES `todos` (`id`) ON DELETE SET NULL) CHARSET utf8mb4 COLLATE utf8mb4_bin;
-- create "users" table
CREATE TABLE `users` (`id` varchar(36) NOT NULL, `name` varchar(255) NOT NULL, `email` varchar(255) NOT NULL, `role` enum('admin','user') NOT NULL, `deleted_at` timestamp NULL, `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, PRIMARY KEY (`id`), UNIQUE INDEX `email` (`email`), INDEX `user_name` (`name`)) CHARSET utf8mb4 COLLATE utf8mb4_bin ENGINE = INNODB;
-- create "groups" table
CREATE TABLE `groups` (`id` varchar(255) NOT NULL, `name` varchar(255) NOT NULL, `user_id` varchar(36) NULL, PRIMARY KEY (`id`), CONSTRAINT `groups_users_groups` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL) CHARSET utf8mb4 COLLATE utf8mb4_bin;
