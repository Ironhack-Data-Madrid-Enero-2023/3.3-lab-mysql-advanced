-- Challenge 1
-- Step 1

SELECT titleauthor.title_id as Title, titleauthor.au_id as `author id`, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
FROM titleauthor
LEFT JOIN sales
ON sales.title_id = titleauthor.title_id 
LEFT JOIN titles
ON sales.title_id = titles.title_id 
ORDER BY  `sales_royalty` DESC;


-- Step 2

SELECT titleauthor.title_id as 'Title', titleauthor.au_id as `author id`, coalesce(SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100), 0) as sales_royalty
FROM titleauthor
LEFT JOIN sales
ON sales.title_id = titleauthor.title_id 
LEFT JOIN titles
ON sales.title_id = titles.title_id 
GROUP BY  titleauthor.title_id, titleauthor.au_id
ORDER BY  `sales_royalty` DESC;


-- Step 3

SELECT titleauthor.au_id as `author id`, coalesce(SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) + advance, 0) as Total_profit
FROM titleauthor
LEFT JOIN sales
ON sales.title_id = titleauthor.title_id 
LEFT JOIN titles
ON sales.title_id = titles.title_id 
GROUP BY  titleauthor.title_id, titleauthor.au_id
ORDER BY  `Total_profit` DESC
LIMIT 3;

-- Challenge 2 (Tabla derivada)

SELECT `author id`, Total_profit
FROM 
(SELECT titleauthor.title_id as 'Title', titleauthor.au_id as `author id`, coalesce(SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) + advance, 0) as Total_profit
FROM titleauthor
LEFT JOIN sales
ON sales.title_id = titleauthor.title_id 
LEFT JOIN titles
ON sales.title_id = titles.title_id 

GROUP BY titleauthor.au_id, titleauthor.title_id
ORDER BY  `Total_profit` DESC) as Aggregated_royalties;

-- Challenge 2 (Tabla temporal)

CREATE TEMPORARY TABLE Profits_temp
SELECT titleauthor.au_id as `author id`, coalesce(SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) + advance, 0) as Total_profit
FROM titleauthor
LEFT JOIN sales
ON sales.title_id = titleauthor.title_id 
LEFT JOIN titles
ON sales.title_id = titles.title_id 
GROUP BY  titleauthor.title_id, titleauthor.au_id
ORDER BY  `Total_profit` DESC
LIMIT 3;

-- Challenge 3 

CREATE TABLE most_profiting_authors
SELECT titleauthor.au_id as `author id`, coalesce(SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) + advance, 0) as Total_profit
FROM titleauthor
LEFT JOIN sales
ON sales.title_id = titleauthor.title_id 
LEFT JOIN titles
ON sales.title_id = titles.title_id 
GROUP BY  titleauthor.title_id, titleauthor.au_id
ORDER BY  `Total_profit` DESC;
