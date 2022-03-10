CREATE TABLE `todos` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `text` longtext NOT NULL,
    `created_at` timestamp NULL,
    `status` enum('IN_PROGRESS', 'COMPLETED') NOT NULL DEFAULT '"IN_PROGRESS"',
    `priority` bigint NOT NULL DEFAULT 0,
    `todo_parent` bigint NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `todos_todos_parent` FOREIGN KEY (`todo_parent`) REFERENCES `todos` (`id`) ON DELETE
    SET
        NULL
) CHARSET utf8mb4 COLLATE utf8mb4_bin;