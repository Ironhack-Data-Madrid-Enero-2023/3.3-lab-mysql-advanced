
--CHALLENGE 1


--STEP 1

SELECT titles.title_id, titleauthor.au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
FROM titles
JOIN titleauthor ON titles.title_id = titleauthor.title_id
JOIN sales ON titles.title_id = sales.title_id
order by sales_royalty desc;


--STEP 2

SELECT title_id, au_id, SUM(sales_royalty) AS total_royalties
FROM (
  SELECT titles.title_id, titleauthor.au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
  FROM titles
  JOIN titleauthor ON titles.title_id = titleauthor.title_id
  JOIN sales ON titles.title_id = sales.title_id
) AS royalties_by_sale
GROUP BY title_id, au_id
;


-- STEP 3

SELECT au_id, SUM(total_royalties + advance) AS total_profits
FROM (
  SELECT title_id, au_id, SUM(sales_royalty) AS total_royalties, advance
  FROM (
    SELECT titles.title_id, titleauthor.au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty, titles.advance
    FROM titles
    JOIN titleauthor ON titles.title_id = titleauthor.title_id
    JOIN sales ON titles.title_id = sales.title_id
  ) AS royalties_by_sale
  GROUP BY title_id, au_id
) AS profits_by_author
GROUP BY au_id
ORDER BY total_profits DESC
LIMIT 3;



-- CHALLENGE 2

-- anteriormente lo he hecho con Subquerys. Este sería la forma de hacerlo con tablas temporales con WHIT: 

WITH royalties_by_sale AS (
  SELECT titles.title_id, titleauthor.au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty, titles.advance
  FROM titles
  JOIN titleauthor ON titles.title_id = titleauthor.title_id
  JOIN sales ON titles.title_id = sales.title_id
), profits_by_author AS (
  SELECT title_id, au_id, SUM(sales_royalty) AS total_royalties, advance
  FROM royalties_by_sale
  GROUP BY title_id, au_id
)
SELECT au_id, SUM(total_royalties + advance) AS total_profits
FROM profits_by_author
GROUP BY au_id
ORDER BY total_profits DESC
LIMIT 3;




--CHALLENGE 3

--primero crear la tabla
CREATE TABLE most_profiting_authors (
  au_id text,
  profits text
);

--Después metes la info anterior en esa tabla:

INSERT INTO most_profiting_authors (au_id, profits)
SELECT au_id, SUM(total_royalties + advance) AS total_profits
FROM (
  SELECT title_id, au_id, SUM(sales_royalty) AS total_royalties, advance
  FROM (
    SELECT titles.title_id, titleauthor.au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty, titles.advance
    FROM titles
    JOIN titleauthor ON titles.title_id = titleauthor.title_id
    JOIN sales ON titles.title_id = sales.title_id
  ) AS royalties_by_sale
  GROUP BY title_id, au_id
) AS profits_by_author
GROUP BY au_id
ORDER BY total_profits DESC
LIMIT 3;



