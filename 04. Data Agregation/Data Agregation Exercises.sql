USE `gringotts`;

SELECT 
    COUNT(`id`) AS 'count'
FROM
    `wizzard_deposits`;

SELECT 
    MAX(`magic_wand_size`) AS 'longest_magic_wand'
FROM
    `wizzard_deposits`;
    
SELECT 
    `deposit_group`,
    MAX(`magic_wand_size`) AS 'longest_magic_wand'
FROM
    `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `longest_magic_wand` , `deposit_group`;

SELECT 
    `deposit_group`
FROM
    `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY AVG(`magic_wand_size`)
LIMIT 1;

SELECT 
    `deposit_group`, 
    SUM(`deposit_amount`) AS 'total_sum'
FROM
    `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `total_sum`;

SELECT 
    `deposit_group`, 
    SUM(`deposit_amount`) AS 'total_sum'
FROM
    `wizzard_deposits`
WHERE
    `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
ORDER BY `deposit_group`;

SELECT 
    `deposit_group`, 
    SUM(`deposit_amount`) AS 'total_sum'
FROM
    `wizzard_deposits`
WHERE
    `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
HAVING `total_sum` < 150000
ORDER BY `total_sum` DESC;

SELECT 
    `deposit_group`,
    `magic_wand_creator`,
    MIN(`deposit_charge`) AS 'min_deposit_charge'
FROM
    `wizzard_deposits`
GROUP BY `deposit_group` , `magic_wand_creator`
ORDER BY `magic_wand_creator` , `deposit_group`;

SELECT 
    CASE
        WHEN age <= 10 THEN '[0-10]'
        WHEN age <= 20 THEN '[11-20]'
        WHEN age <= 30 THEN '[21-30]'
        WHEN age <= 40 THEN '[31-40]'
        WHEN age <= 50 THEN '[41-50]'
        WHEN age <= 60 THEN '[51-60]'
        ELSE '[61+]'
    END AS 'age_group',
    COUNT(*) AS 'wizard_count'
FROM
    `wizzard_deposits`
GROUP BY `age_group`
ORDER BY `wizard_count`;

SELECT 
    LEFT(`first_name`, 1) AS 'first_letter'
FROM
    `wizzard_deposits`
WHERE
    `deposit_group` = 'Troll Chest'
GROUP BY `first_letter`
ORDER BY `first_letter`;

SELECT 
    `deposit_group`,
    `is_deposit_expired`,
    AVG(`deposit_interest`) AS `deposit_interest`
FROM
    `wizzard_deposits`
WHERE
    `deposit_start_date` > '1985-01-01'
GROUP BY `deposit_group` , `is_deposit_expired`
ORDER BY `deposit_group` DESC , `is_deposit_expired`;

SELECT 
    SUM(`hw`.`deposit_amount` - `gw`.`deposit_amount`) AS 'sum_difference'
FROM
    `wizzard_deposits` AS `hw`,
    `wizzard_deposits` AS `gw`
WHERE
    `gw`.`id` - `hw`.`id` = 1;

SELECT 
    `hw`.`first_name` AS 'host_wizard',
    `hw`.`deposit_amount` AS 'host_wizard_deposit',
    `gw`.`first_name` AS 'guest_wizard',
    `gw`.`deposit_amount` AS 'guest_wizard_deposit',
    (`hw`.`deposit_amount` - `gw`.`deposit_amount`) AS 'difference'
FROM
    `wizzard_deposits` AS `hw`, `wizzard_deposits` AS `gw`
WHERE
     `gw`.`id` - `hw`.`id` = 1;
 
USE `soft_uni`;

SELECT 
    `department_id`, MIN(`salary`) AS 'minimum_salary'
FROM
    `employees`
WHERE
    `department_id` IN (2 , 5, 7)
GROUP BY `department_id`
ORDER BY `department_id`;

SELECT 
    `department_id`,
    CASE
        WHEN `department_id` = 1 THEN AVG(`salary`) + 5000
        ELSE AVG(`salary`)
    END AS 'avg_salary'
FROM
    `employees`
WHERE
    `salary` > 30000 AND `manager_id` != 42
GROUP BY `department_id`
ORDER BY `department_id`;

SELECT 
    `department_id`, MAX(`salary`) AS 'max_salary'
FROM
    `employees`
GROUP BY `department_id`
HAVING NOT `max_salary` BETWEEN 30000 AND 70000
ORDER BY `department_id`;

SELECT 
    COUNT(`salary`)
FROM
    `employees`
WHERE
    ISNULL(`manager_id`);
    
SELECT 
    `emp`.`department_id`,
    MAX(`emp`.`salary`) AS 'third_highest_salary'
FROM
    `employees` AS `emp`
        JOIN
    (SELECT 
        `e`.`department_id`, MAX(`e`.`salary`) AS `max_salary`
    FROM
        `employees` AS `e`
    JOIN (SELECT 
        `e`.`department_id`, MAX(`e`.`salary`) AS `max_salary`
    FROM
        `employees` AS `e`
    GROUP BY `e`.`department_id`) AS `first_max_salary` ON `e`.`department_id` = `first_max_salary`.`department_id`
    WHERE
        `e`.`salary` < `first_max_salary`.`max_salary`
    GROUP BY `e`.`department_id`) AS `second_max_salary` ON `emp`.`department_id` = `second_max_salary`.`department_id`
WHERE
    `emp`.`salary` < `second_max_salary`.`max_salary`
GROUP BY `emp`.`department_id`
ORDER BY `emp`.`department_id`;

SET @num := 0, @type := '';
SELECT 
    `department_id`, `salary` AS 'third_highest_salary'
FROM
    (SELECT 
        `department_id`,
            `salary`,
            @num:=IF(@type = `department_id`, @num + 1, 1) AS `row_number`,
            @type:=`department_id`
    FROM
        (SELECT 
        `department_id`, `salary`
    FROM
        `employees`
    GROUP BY `department_id` , `salary`
    ORDER BY `department_id` , `salary` DESC) AS `a`) AS `b`
WHERE
    `row_number` = 3
ORDER BY `department_id`;

SELECT 
    `department_id`,
    (SELECT DISTINCT
            `e2`.`salary`
        FROM
            `employees` AS `e2`
        WHERE
            `e2`.`department_id` = `e1`.`department_id`
        ORDER BY `e2`.`salary` DESC
        LIMIT 2 , 1) AS `third_highest_salary`
FROM
    `employees` AS `e1`
GROUP BY `department_id`
HAVING `third_highest_salary` IS NOT NULL;

SELECT 
    `e`.`first_name`, `e`.`last_name`, `e`.`department_id`
FROM
    `employees` AS `e`
        JOIN
    (SELECT 
        `department_id`, AVG(`salary`) AS 'dep_avg_salary'
    FROM
        `employees`
    GROUP BY `department_id`) AS `avrg` ON `e`.`department_id` = `avrg`.`department_id`
WHERE
    `salary` > `avrg`.`dep_avg_salary`
ORDER BY `department_id`
LIMIT 10;

SELECT 
    `department_id`, SUM(`salary`) AS 'total_salary'
FROM
    `employees`
GROUP BY `department_id`
ORDER BY `department_id`;