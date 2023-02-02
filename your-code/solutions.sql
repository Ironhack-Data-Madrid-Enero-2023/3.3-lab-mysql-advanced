-- Step 1

SELECT au_id, titles.title_id, (titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100)) AS Profits
FROM titleauthor

LEFT JOIN titles
ON titles.title_id = titleauthor.title_id

LEFT JOIN sales
ON sales.title_id = titles.title_id

GROUP BY au_id, titles.title_id
ORDER BY Profits DESC
;

-- Step 2

SELECT au_id, titles.title_id, SUM(titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100)) AS Profits
FROM titleauthor

LEFT JOIN titles
ON titles.title_id = titleauthor.title_id

LEFT JOIN sales
ON sales.title_id = titles.title_id

GROUP BY au_id, titles.title_id
ORDER BY Profits DESC;
;

-- Step 3

SELECT au_id, titles.title_id, SUM((titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100))+(advance * (titleauthor.royaltyper / 100))) AS Profits
FROM titleauthor

LEFT JOIN titles
ON titles.title_id = titleauthor.title_id

LEFT JOIN sales
ON sales.title_id = titles.title_id

GROUP BY au_id, titles.title_id
ORDER BY Profits DESC
LIMIT 3
;

-- --------------------------------------------------------------------------

SELECT au_id, SUM(Royalty2)+SUM(advance) AS Profits
FROM
(SELECT title_id, au_id, SUM(Royalty) AS Royalty2, advance

FROM	(SELECT titles.title_id, au_id, (titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100)) AS Royalty, advance

FROM titleauthor

LEFT JOIN titles
ON titles.title_id = titleauthor.title_id

LEFT JOIN sales
ON sales.title_id = titles.title_id) AS tabla1

GROUP BY titles.title_id, au_id) AS tabla2

GROUP BY au_id
ORDER BY Profits DESC
LIMIT 3
;

-- -----------------------------------------------------------------

CREATE TEMPORARY TABLE tablatemp2

SELECT titles.title_id, au_id, (titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100)) AS Royalty

FROM titleauthor

LEFT JOIN titles
ON titles.title_id = titleauthor.title_id

LEFT JOIN sales
ON sales.title_id = titles.title_id
;

CREATE TEMPORARY TABLE tablatemp12
SELECT tablatemp2.title_id AS titulo, au_id AS autor, SUM(tablatemp2.Royalty) AS Profits, advance
FROM tablatemp2
LEFT JOIN titles ON titles.title_id = tablatemp2.title_id
GROUP BY au_id, tablatemp2.title_id
ORDER BY Profits DESC;
;

CREATE TABLE most_profiting_authors
SELECT autor, SUM(Profits)+SUM(advance) AS Profit
FROM tablatemp12
GROUP BY autor
ORDER BY Profit DESC
LIMIT 3;
