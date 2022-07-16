USE `soft_uni`;

SELECT 
    `first_name`, `last_name`
FROM
    `employees`
WHERE
    `first_name` REGEXP '^Sa'
ORDER BY `employee_id`;
 
SELECT 
    `first_name`, `last_name`
FROM
    `employees`
WHERE
    `last_name` LIKE '%ei%'
ORDER BY `employee_id`;

SELECT 
    `first_name`
FROM
    `employees`
WHERE
    `department_id` IN (3, 10)
        AND YEAR(`hire_date`) >= 1995
        AND YEAR(`hire_date`) <= 2005
ORDER BY `employee_id`;

SELECT 
    `first_name`, `last_name`
FROM
    `employees`
WHERE
    `job_title` NOT LIKE '%engineer%'
ORDER BY `employee_id`;

SELECT 
    `name`
FROM
    `towns`
WHERE
    CHAR_LENGTH(`name`) BETWEEN 5 AND 6
ORDER BY `name`;

SELECT 
    *
FROM
    `towns`
WHERE
    `name` REGEXP '^[MmKkBbEe]'
ORDER BY `name`;

SELECT 
    *
FROM
    `towns`
WHERE
    `name` REGEXP '^[^RrBbDd]'
ORDER BY `name`;

CREATE VIEW `v_employees_hired_after_2000` AS
    SELECT 
        `first_name`, `last_name`
    FROM
        `employees`
    WHERE
        YEAR(`hire_date`) > 2000;
        
SELECT 
    `first_name`, `last_name`
FROM
    `employees`
WHERE
    CHAR_LENGTH(`last_name`) = 5;
    
USE `geography`;

SELECT 
    `country_name`, `iso_code`
FROM
    `countries`
WHERE
    (CHAR_LENGTH(`country_name`) - CHAR_LENGTH(REPLACE(LOWER(`country_name`), 'a', ''))) >= 3
ORDER BY `iso_code`;

SELECT 
    `country_name`, `iso_code`
FROM
    `countries`
WHERE
    `country_name` LIKE '%a%a%a%'
ORDER BY `iso_code`;

SELECT 
    `peak_name`,
    `river_name`,
    LOWER(CONCAT(`peak_name`, SUBSTRING(`river_name`, 2))) AS 'mix'
FROM
    `peaks`,
    `rivers`
WHERE
    LOWER(RIGHT(`peak_name`, 1)) = LOWER(LEFT(`river_name`, 1))
ORDER BY `mix`;

USE `diablo`;

SELECT 
    `name`, DATE_FORMAT(`start`, '%Y-%m-%d') AS 'start'
FROM
    `games`
WHERE
    YEAR(`start`) BETWEEN 2011 AND 2012
ORDER BY `start` , `name`
LIMIT 50;

SELECT 
    `user_name`,
    SUBSTRING_INDEX(`email`, '@', - 1) AS 'Email Provider'
FROM
    `users`
ORDER BY `Email Provider` , `user_name`;

SELECT 
    `user_name`, `ip_address`
FROM
    `users`
WHERE
    `ip_address` LIKE '___.1%.%.___'
ORDER BY `user_name`;

SELECT 
    `name` AS 'game',
    CASE
        WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS 'Part of the Day',
    CASE
        WHEN `duration` <= 3 THEN 'Extra Short'
        WHEN `duration` BETWEEN 4 AND 6 THEN 'Short'
        WHEN `duration` BETWEEN 7 AND 10 THEN 'Long'
        ELSE 'Extra Long'
    END AS 'Duration'
FROM
    `games`
ORDER BY `name`;

SELECT 
    `name` AS 'game',
    CASE
        WHEN HOUR(`start`) < 12 THEN 'Morning'
        WHEN HOUR(`start`) < 18 THEN 'Afternoon'
        ELSE 'Evening'
    END AS 'Part of the Day',
    CASE
        WHEN `duration` < 4 THEN 'Extra Short'
        WHEN `duration` < 7 THEN 'Short'
        WHEN `duration` < 11 THEN 'Long'
        ELSE 'Extra Long'
    END AS 'Duration'
FROM
    `games`
ORDER BY `name`;

USE `orders`;

SELECT 
    `product_name`,
    `order_date`,
    DATE_ADD(`order_date`, INTERVAL 3 DAY) AS 'pay_due',
    DATE_ADD(`order_date`, INTERVAL 1 MONTH) AS 'deliver_due'
FROM
    `orders`;