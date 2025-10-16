--JOIN

--1
SELECT
	cus.professional_status,
	COUNT(fun.paid_date) AS pagamentos
FROM sales.funnel AS fun
LEFT


--UNION
--1

SELECT * FROM sales.products
UNION ALL
SELECT * FROM temp_tables.products_2


--SUBQUERY
--1
SELECT * FROM sales.products
WHERE price= (SELECT MIN(price) FROM sales.products)


--2
WITH alguma_tabela AS (
SELECT 
	professional_status,
	(CURRENT_DATE - birth_d)
)