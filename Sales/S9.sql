--Conversão de unidades
-- ::
-- CAST


--Exemplo 1
SELECT '2021-10-01'::date - '2021-02-01'::date


--Exemplo 2
SELECT '100'::numeric - '10'::numeric


--Exemplo 3
SELECT replace(1112122::text, '1','A')


--Exemplo 4
SELECT CAST('2025-08-01' AS date) - CAST('2021-02-01' AS DATE)



--Tipos
-- CASE WHEN
-- COALESCE()


--Exemplo 1

WITH faixa_de_renda AS (
	SELECT 
		income,
		CASE
			WHEN income < 5000 THEN '0-5000'
			WHEN income >= 5000 AND income < 10000 THEN '5000-10000'
			WHEN income >= 10000 AND income < 15000 THEN '10000-15000'
			ELSE '15000+'
			END AS faixa_renda
	FROM sales.customers
)

SELECT faixa_renda, COUNT(*)
FROM faixa_de_renda
GROUP BY faixa_renda



--Exemplo 2

SELECT 
	*,
	CASE 
		WHEN population IS NOT NULL THEN population
		ELSE (SELECT AVG(population) FROM temp_tables.regions)
		END AS populacao_ajustada

FROM temp_tables.regions
WHERE population IS NULL


--2.1
SELECT
	*,
	COALESCE(population, (SELECT AVG(population) FROM temp_tables.regions)) AS populacao_ajustada

FROM temp_tables.regions
WHERE population IS NULL

-- COALESCE é o comando utilizado para preencher campos nulos com o primeiro valor não nulo de uma sequência de valores.



--Tratamento de texto
-- lower(), upper(), trim(), replace()

SELECT upper('Ceará') = 'CEARÁ'

SELECT lower('Ceará') = 'ceará'

SELECT trim('      Ceará        ') = 'Ceará'

SELECT replace('Ceara pior', 'Ceara', 'Ceará' ) = 'Ceará pior'



--Tipos
/* Interval
	Date_trunc
	Extract
	DateDiff*/

--Exemplo 1

SELECT current_date +10
SELECT (current_date + INTERVAL '10 weeks')::DATE
SELECT (current_date + INTERVAL '10 months')::DATE
SELECT current_date + INTERVAL '45 hours'


--Exemplo 2
SELECT visit_page_date, COUNT(*)
FROM sale.funnel
GROUP BY visit_page_date
ORDER BY visit_page_date DESC

SELECT 
	DATE_TRUNC('month', visit_page_date):: DATE AS visit_page_month,
	COUNT(*)
FROM sales.funnel
GROUP BY visit_page_month
ORDER BY visit_page_month DESC


--Exemplo 3
SELECT 
	EXTRACT('dow'FROM visit_page_date) AS dia_da_semana,
	COUNT(*)
FROM sales.funnel
GROUP BY dia_da_semana
ORDER BY dia_da_semana


--Exemplo 4

--Resumo
/*
(1) O comando INTERVAL é utilizado para somar datas na unidade desejada. Caso a unidade não seja informada, o SQL irá entender que a soma foi
feita em dias.
(2) O comando DATE_TRUNC é utilizado para truncar uma data no início do período.
(3) O comando EXTRACT é utilizado para extrair unidades de uma data/timestamp.
(4) O cálculo da diferença entre datas com o operador de subtração (-) retorna valores em dias. Para calcular a diferença entre datas em outra 
unidade é necessário fazer uma transformação de unidades (ou criar uma função para isso)
*/

-- Funções


CREATE FUNCTION DATEDIFF(unidade varchar, data_inicial date, data_final date)
returns INTEGER
language SQL

AS

$$
	SELECT
		CASE
			WHEN unidade IN ('d', 'day', 'days') THEN (data_final - data_inicial)
			WHEN unidade IN ('w', 'week', 'weeks') THEN (data_final - data_inicial)/7
			WHEN unidade IN ('m', 'month', 'months') THEN (data_final - data_inicial)/30
			WHEN unidade IN ('y', 'year', 'years') THEN (data_final - data_inicial)/365
			END AS diferenca
$$


SELECT datediff('years', '2021-02-04', CURRENT_DATE)


drop FUNCTION datediff


/*Resumo
(1) Para criar funções, utiliza-se o comando CREATE FUNCTION
(2) Para que o comando funcione é obrigatório informar (a) quais as unidades dos INPUTS
(b) quais as unidades dos OUTPUTS e (c) em qual linguagem a função será escrita
(3) O script da função deve estar delimitado po $$
(4) Para deletar uma função utiliza-se o comando DROP FUNCTION


*/