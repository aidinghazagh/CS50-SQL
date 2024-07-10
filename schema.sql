CREATE TABLE `users` (
    `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(64) NOT NULL,
    `email` VARCHAR(64) UNIQUE,
    `password` VARCHAR(64) NOT NULL,
    `behavior` TINYINT NOT NULL,
    INDEX (`email`),
    INDEX (`behavior`)
);

CREATE TABLE `countries` (
    `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(64) NOT NULL UNIQUE,
    INDEX (`name`)
);

CREATE TABLE `languages` (
    `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(64) NOT NULL UNIQUE,
    `country_id` INT,
    UNIQUE KEY `unique_name_country` (`name`, `country_id`),
    FOREIGN KEY (`country_id`) REFERENCES `countries`(`id`),
    INDEX (`country_id`),
    INDEX (`name`)
);

CREATE TABLE `slangs` (
    `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(64),
    `description` VARCHAR(1024),
    `pronunciation` VARCHAR(64),
    `score` INT,
    `user_id` INT,
    `language_id` INT,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`),
    INDEX (`user_id`),
    INDEX (`language_id`),
    INDEX (`score`),
);

CREATE TABLE `categories` (
    `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(64) NOT NULL UNIQUE,
    INDEX (`name`)
);

CREATE TABLE `slang_category_ids` (
    `category_id` INT,
    `slang_id` INT,
    PRIMARY KEY (`category_id`, `slang_id`),
    FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`),
    FOREIGN KEY (`slang_id`) REFERENCES `slangs`(`id`),
    INDEX (`category_id`),
    INDEX (`slang_id`)
);
