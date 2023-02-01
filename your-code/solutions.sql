-- CHALLENGUE 1 STEP 1
SELECT ti.title_id AS 'Title ID', tiau.au_id AS 'Author ID', COALESCE((ti.price * sa.qty * ti.royalty / 100 * tiau.royaltyper / 100), 0) AS 'sales_royality'
FROM titles AS ti
LEFT JOIN titleauthor AS tiau
ON ti.title_id = tiau.title_id
LEFT JOIN sales AS sa
ON ti.title_id = sa.title_id
WHERE tiau.au_id IS NOT NULL;


-- CHALLENGUE 1 STEP 2
SELECT `Title ID`, `Author ID`, COALESCE(SUM(sales_royality), 0) AS 'sales_royality'
FROM (SELECT ti.title_id AS 'Title ID', tiau.au_id AS 'Author ID', COALESCE((ti.price * sa.qty * ti.royalty / 100 * tiau.royaltyper / 100), 0) AS 'sales_royality'
FROM titles AS ti
LEFT JOIN titleauthor AS tiau
ON ti.title_id = tiau.title_id
LEFT JOIN sales AS sa
ON ti.title_id = sa.title_id
WHERE tiau.au_id IS NOT NULL) AS tabla
GROUP BY `Title ID`, `Author ID`;


-- CHALLENGUE 1 STEP 3
SELECT `Author ID`, SUM(sales_royality) AS 'sales_royality'
FROM  (SELECT `Title ID`, `Author ID`, COALESCE(SUM(sales_royality), 0) AS 'sales_royality'
FROM (SELECT ti.title_id AS 'Title ID', tiau.au_id AS 'Author ID', COALESCE((ti.price * sa.qty * ti.royalty / 100 * tiau.royaltyper / 100), 0) AS 'sales_royality'
FROM titles AS ti
LEFT JOIN titleauthor AS tiau
ON ti.title_id = tiau.title_id
LEFT JOIN sales AS sa
ON ti.title_id = sa.title_id
WHERE tiau.au_id IS NOT NULL) AS tabla
GROUP BY `Title ID`, `Author ID`) AS tabla
GROUP BY `Author ID`
ORDER BY SUM(sales_royality) DESC
LIMIT 3;


-- CHALLENGUE 2 STEP 1
CREATE TEMPORARY TABLE royality
SELECT ti.title_id AS 'Title ID', tiau.au_id AS 'Author ID', COALESCE((ti.price * sa.qty * ti.royalty / 100 * tiau.royaltyper / 100), 0) AS 'sales_royality'
FROM titles AS ti
LEFT JOIN titleauthor AS tiau
ON ti.title_id = tiau.title_id
LEFT JOIN sales AS sa
ON ti.title_id = sa.title_id
WHERE tiau.au_id IS NOT NULL;


-- CHALLENGUE 2 STEP 2
SELECT `Title ID`, `Author ID`, SUM(sales_royality)
FROM royality
GROUP BY `Title ID`, `Author ID`;

-- CHALLENGUE 2 STEP 3
SELECT `Author ID`, SUM(sales_royality)
FROM royality
GROUP BY `Author ID`
ORDER BY SUM(sales_royality) DESC
LIMIT 3;

-- CHALLENGUE 3
CREATE TABLE most_profiting_authors
SELECT `Author ID`, SUM(sales_royality) AS 'profits'
FROM royality
GROUP BY `Author ID`
ORDER BY SUM(sales_royality) DESC;