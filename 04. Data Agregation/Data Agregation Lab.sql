USE `restaurant`;

SELECT 
    `department_id`, COUNT(`id`) AS 'Number of employees'
FROM
    `employees`
GROUP BY `department_id`
ORDER BY `department_id`, COUNT(`id`);

SELECT 
    `department_id`, ROUND(AVG(`salary`), 2) AS 'Average Salary'
FROM
    `employees`
GROUP BY `department_id`
ORDER BY `department_id`;

SELECT 
    `department_id`, ROUND(MIN(`salary`), 2) AS 'Min Salary'
FROM
    `employees`
WHERE
    `salary` > 800
GROUP BY `department_id`
ORDER BY `department_id`
LIMIT 1;

SELECT 
    `department_id`, ROUND(MIN(`salary`), 2) AS 'Min Salary'
FROM
    `employees`
GROUP BY `department_id`
HAVING `Min Salary` > 800
ORDER BY `department_id`;

SELECT 
    COUNT(`id`) AS 'Appetizers'
FROM
    `products`
WHERE
    `category_id` = 2 AND `price` > 8
GROUP BY `category_id`;

SELECT 
    `category_id`,
    ROUND(AVG(`price`), 2) AS 'Average Price',
    ROUND(MIN(`price`), 2) AS 'Cheapest Product',
    ROUND(MAX(`price`), 2) AS 'Most Expensive Product'
FROM
    `products`
GROUP BY `category_id`
ORDER BY `category_id`;

USE `soft_uni`;
SELECT 
    `department_id`, ROUND(SUM(`salary`), 2) AS 'total_salary'
FROM
    `employees`
GROUP BY `department_id`
ORDER BY `department_id`;