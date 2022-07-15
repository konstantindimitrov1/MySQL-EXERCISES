USE `hospital`;

SELECT 
    `id`, `first_name`, `last_name`, `job_title`
FROM
    `employees`
ORDER BY `id` ASC;
    
SELECT 
    `id`,
    CONCAT(`first_name`, ' ', `last_name`) AS 'full_name',
    `job_title`,
    `salary`
FROM
    `employees`
WHERE
    `salary` > 1000.00
ORDER BY `id` ASC;
    
UPDATE `employees`
	SET `salary` = `salary` * 1.1
    WHERE `job_title` = 'Therapist';
    
SELECT `salary`
	FROM `employees`
	ORDER BY `salary` ASC;
    
SELECT * FROM `employees`
	ORDER BY `salary` DESC
    LIMIT 1;
    
SELECT * FROM `employees`
	WHERE (`department_id` = 4 AND `salary` >= 1600.0)
    ORDER BY `id`;
    
DELETE FROM `employees`
	WHERE `department_id` IN (2, 1);

SELECT *
	FROM `employees`
	ORDER BY `id` ASC;
    