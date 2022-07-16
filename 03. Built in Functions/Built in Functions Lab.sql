USE `book_library`;

SELECT 
    `title`
FROM
    `books`
WHERE
    SUBSTRING(`title`, 1, 3) = 'The'
ORDER BY `id`;

SELECT 
    CONCAT('***', SUBSTRING(`title`, 4)) AS 'title'
FROM
    `books`
WHERE
    SUBSTRING(`title`, 1, 3) = 'The'
ORDER BY `id`;

SELECT 
    REPLACE(`title`, 'The', '***') AS 'title'
FROM
    `books`
WHERE
    `title` LIKE ('The%')
ORDER BY `id`;

SELECT 
    ROUND(SUM(`cost`), 2) AS 'cost'
FROM
    `books`;
    
SELECT 
    CONCAT_WS(' ', `first_name`, `last_name`) AS 'Full Name',
    TIMESTAMPDIFF(DAY, `born`, `died`) AS 'Days Lived'
FROM
    `authors`;
    
SELECT 
    `title`
FROM
    `books`
WHERE
    `title` LIKE ('%Harry Potter%')
ORDER BY `id`;