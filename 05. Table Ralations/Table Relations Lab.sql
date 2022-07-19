USE `camp`;

CREATE TABLE `mountains` (
    `id` INT UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `peaks` (
    `id` INT UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `mountain_id` INT UNSIGNED UNIQUE,
    CONSTRAINT `fk_peaks_mountains` FOREIGN KEY (`mountain_id`)
        REFERENCES `mountains` (`id`)
);

CREATE TABLE `authors` (
    `id` INT UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `books` (
    `id` INT UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `author_id` INT UNSIGNED,
    CONSTRAINT `fk_books_authors` FOREIGN KEY (`author_id`)
        REFERENCES `authors` (`id`)
        ON DELETE CASCADE
);

INSERT INTO `authors` (`name`) VALUES ("Ivan"), ("Pesho"), ("Gosho");
INSERT INTO `books` (`name`, `author_id`) VALUES ("Book 1", 1), ("Book 2", 2), ("Book 3", 1);
DELETE FROM `authors` WHERE `id`=1;
SELECT * FROM `authors`;
SELECT * FROM `books`;

SELECT 
    `driver_id`,
    `vehicle_type`,
    CONCAT(`c`.`first_name`, ' ', `c`.`last_name`) AS `driver_name`
FROM
    `vehicles` AS `v`
        JOIN
    `campers` AS `c` ON `v`.`driver_id` = `c`.`id`;
    
SELECT 
    `starting_point` AS 'route_starting_point',
    `end_point` AS 'route_ending_point',
    `leader_id`,
    CONCAT(`c`.`first_name`, ' ', `c`.`last_name`) AS `leader_name`
FROM
    `routes` AS `r`
        JOIN
    `campers` AS `c` ON `r`.`leader_id` = `c`.`id`;

CREATE DATABASE `company`;
USE `company`;

CREATE TABLE `projects` (
    `id` INT(11) UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `client_id` INT(11) UNSIGNED,
    `project_lead_id` INT(11) UNSIGNED
);

CREATE TABLE `clients` (
    `id` INT(11) UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `client_name` VARCHAR(100) NOT NULL,
    `project_id` INT(11) UNSIGNED
);

CREATE TABLE `employees` (
    `id` INT(11) UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL,
    `project_id` INT(11) UNSIGNED
);

ALTER TABLE `projects`
	ADD CONSTRAINT `fk_projects_clients` 
		FOREIGN KEY (`client_id`)
        REFERENCES `clients` (`id`),
    ADD CONSTRAINT `fk_projects_employees` 
		FOREIGN KEY (`project_lead_id`)
        REFERENCES `employees` (`id`);

ALTER TABLE `clients`
    ADD CONSTRAINT `fk_clients_projects` 
		FOREIGN KEY (`project_id`)
        REFERENCES `projects` (`id`);

ALTER TABLE `employees`
    ADD CONSTRAINT `fk_employees_projects` 
		FOREIGN KEY (`project_id`)
        REFERENCES `projects` (`id`);