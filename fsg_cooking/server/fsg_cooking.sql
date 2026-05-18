-- fsg_cooking Database Schema
-- Run this manually if Config.Database.AutoExecuteSQL is false

CREATE TABLE IF NOT EXISTS `fsg_cooking_props` (
    `id`         INT AUTO_INCREMENT PRIMARY KEY,
    `prop_id`    VARCHAR(100)  NOT NULL UNIQUE,
    `model`      VARCHAR(100)  NOT NULL,
    `x`          FLOAT         NOT NULL,
    `y`          FLOAT         NOT NULL,
    `z`          FLOAT         NOT NULL,
    `rot_x`      FLOAT         NOT NULL DEFAULT 0,
    `rot_y`      FLOAT         NOT NULL DEFAULT 0,
    `rot_z`      FLOAT         NOT NULL DEFAULT 0,
    `owner`      VARCHAR(100)  DEFAULT NULL,
    `created_at` TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
