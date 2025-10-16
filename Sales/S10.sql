--Secao 10


--Exemplo 1
SELECT
	customer_id,
	datediff('year', birth_date, CURRENT_DATE) idade_cliente
	INTO temp_tables.customers_age
FROM sales.customers

SELECT * 
FROM temp_tables.customers_age


--Exemplo 2

SELECT DISTINCT professional_status
FROM sales.customers

CREATE TABLE temp_tables.profissoes(
	professional_status varchar,
	status_professional varchar
)

INSERT INTO temp_tables.profissoes
(professional_status, status_professional)

VALUES
('frelancer', 'frelancer'),
('retired', 'aposentado(a)'),
('clt', 'clt'),
('self_employed', 'autônomo(a)'),
('other', 'outro'),
('businessman', 'empresário(a)'),
('civil_servant', 'funcionário público(a)'),
('student', 'estudante')

SELECT * FROM temp_tables.profissoes

-- Exemplo 3
DROP TABLE temp_tables.profissoes


/*Resumo
(1) Para criar tabelas a partir de uma query basta escrever a query normalmente e colocar o comando INTO antes do FROM informando o schema e
o nome da tabela a ser criada.
(2) Para criar tabelas a partir do zero é necessário (a) criar uma tabela vazia com o comando CREATE TABLE (b) Informar que os valores serão
inseridos com o comando INSERT INTO seguido do nome das colunas (c) Inserir os valores manualmente em forma de lista após o comando VALUES
(3) Para deletar uma tabela utiliza-se o comando DROP TABLE

*/

--Exemplo 1
SELECT * FROM temp_tables.profissoes

INSERT INTO temp_tables.profissoes
(professional_status, status_professional)

VALUES
('unemployed', 'desempregado(a)'),
('trainee', 'estagiário(a)')


--Exemplo 2
UPDATE temp_tables.profissoes
SET professional_status = 'intern'
WHERE status_professional = 'estagiário(a)'

SELECT * FROM temp_tables.profissoes



--Exemplo 3
DELETE FROM temp_tables.profissoes
WHERE status_professional = 'desempregado(a)'
OR status_professional = 'estagiário(a)'

SELECT * FROM temp_tables.profissoes

/* RESUMO
(1) Para inserir linhas em uma tabela é necessário (a) Informar que valores serão inseridos com o comando INSERT INTO seguido do nome da tabela e 
nome das colunas (b) Inserir os valores manualmente em forma de lista após o comando VALUES
(2) Para atualizar as linhas de uma tabela é necessário (a) Informar qual tabela será atualizada com o comando UPDATE (b) Informar qual o novo valor
com o comando SET (c) Delimitar qual linha será modificada utilizando o filtro WHERE
(3) Para deletar linhas de uma tabela é necessário (a) Informar de qual tabela as linhas serão deletadas com o comando DELETE FROM (b) Delimitar qual 
linha será deletada utilizando o filtro WHERE
*/



-- Inserir, alterar, deletar coluna

--Exemplo
ALTER TABLE sales.customers
ADD customer_age int


UPDATE sales.customers
SET customer_age = datediff('year', birth_date, current_date)
WHERE true 

SELECT * FROM sales.customers LIMIT 10


--Exemplo 2

ALTER TABLE sales.customers
ALTER COLUMN customer_age type varchar 

SELECT * FROM sales.customers LIMIT 10


--Exemplo 3

ALTER TABLE sales.customers
RENAME COLUMN customer_age to age

SELECT * FROM sales.customers LIMIT 10


--Exemplo 4
ALTER TABLE sales.customers
DROP COLUMN age

SELECT * FROM sales.customers LIMIT 10


/* 
Resumo
(1) Para fazer qualquer modificação nas colunas de uma tabela utiliza-se o comando ALTER TABLE seguido do nome da tabela
(2) Para adicionar colunas utiliza-se o comando ADD seguido do nome da coluna e da unidade da nova coluna
(3) Para mudar o tipo de unidade de uma coluna utiliza-se o comando ALTER COLUMN
(4) Para renomear uma coluna utiliza-se o comando RENAME COLUMN
(5) Para deletar uma coluna utiliza-se o comando DROP COLUMN

*/

