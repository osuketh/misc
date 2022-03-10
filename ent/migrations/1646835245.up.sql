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

CREATE TABLE 'users'
(
    `id` varchar(36) COLLATE utf8mb4_bin NOT NULL COMMENT 'ID',
    `name` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '名前',
    `email` varchar(255) COLLATE utf8mb4_bin NOT NULL,
    `role` enum('admin', 'user') COLLATE utf8mb4_bin NOT NULL DEFAULT 'user' COMMENT '権限',
    `deleted_at` timestamp NULL DEFAULT NULL,
    `registered_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_email` (`email`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_bin COMMENT = 'ユーザー';
