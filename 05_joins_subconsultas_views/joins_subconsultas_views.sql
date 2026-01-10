
-- Lista todas as vendas realizadas, relacionando vendedores e notas fiscais

SELECT * 
FROM tabela_de_vendedores A 
INNER JOIN notas_fiscais B
ON A.MATRICULA = B.MATRICULA;

-- Mostra a quantidade de notas fiscais emitidas por cada vendedor

SELECT 
A.MATRICULA, 
A.NOME, 
COUNT(*)
FROM tabela_de_vendedores A 
INNER JOIN notas_fiscais B
ON A.MATRICULA = B.MATRICULA
GROUP BY A.MATRICULA, A.NOME;

-- Lista todos os clientes e indica quais possuem notas fiscais associadas

SELECT DISTINCT 
A.NOME, 
B.CPF 
FROM tabela_de_clientes A
LEFT JOIN notas_fiscais B
on A.CPF = B.CPF;

-- Lista os clientes que não possuem nenhuma nota fiscal registrada

SELECT DISTINCT 
A.NOME, 
B.CPF 
FROM tabela_de_clientes A
LEFT JOIN notas_fiscais B
ON A.CPF = B.CPF WHERE B.CPF IS NULL;


-- Lista os clientes que não realizaram compras no ano de 2015

SELECT DISTINCT 
A.NOME, 
B.CPF 
FROM tabela_de_clientes A
LEFT JOIN notas_fiscais B
ON A.CPF = B.CPF WHERE B.CPF IS NULL AND YEAR(B.DATA_VENDA = 2015);

-- Lista os clientes que não possuem nota fiscal utilizando RIGHT JOIN

SELECT DISTINCT 
A.NOME, 
A.CPF 
FROM notas_fiscais A
RIGHT JOIN tabela_de_clientes B
ON B.CPF = A.CPF WHERE A.CPF IS NULL;

-- Lista vendedores e clientes que estão no mesmo bairro

SELECT 
tabela_de_vendedores.NOME AS VENDEDOR, 
tabela_de_vendedores.BAIRRO,
tabela_de_clientes.NOME AS CLIENTE,
tabela_de_clientes.BAIRRO 
FROM tabela_de_vendedores 
INNER JOIN tabela_de_clientes  
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;


-- Lista todos os vendedores, indicando clientes no mesmo bairro quando existirem

SELECT 
tabela_de_vendedores.NOME AS VENDEDOR, 
tabela_de_vendedores.BAIRRO,
tabela_de_clientes.NOME AS CLIENTE,
tabela_de_clientes.BAIRRO 
FROM tabela_de_vendedores 
LEFT JOIN tabela_de_clientes 
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;

-- Lista todos os clientes, indicando vendedores no mesmo bairro quando existirem

SELECT 
tabela_de_vendedores.NOME AS VENDEDOR, 
tabela_de_vendedores.BAIRRO,
tabela_de_clientes.NOME AS CLIENTE,
tabela_de_clientes.BAIRRO 
FROM tabela_de_vendedores 
RIGHT JOIN tabela_de_clientes 
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;

-- Simula um FULL JOIN exibindo vendedores e clientes com seus bairros

SELECT 
tabela_de_vendedores.NOME AS VENDEDOR, 
tabela_de_vendedores.BAIRRO,
tabela_de_clientes.NOME AS CLIENTE,
tabela_de_clientes.BAIRRO 
FROM tabela_de_vendedores 
LEFT JOIN tabela_de_clientes 
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO
UNION 
SELECT 
tabela_de_vendedores.NOME AS VENDEDOR, 
tabela_de_vendedores.BAIRRO,
tabela_de_clientes.NOME AS CLIENTE,
tabela_de_clientes.BAIRRO 
FROM tabela_de_vendedores 
RIGHT JOIN tabela_de_clientes 
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;

-- Gera todas as combinações possíveis entre vendedores e clientes

SELECT 
tabela_de_vendedores.NOME AS VENDEDOR, 
tabela_de_vendedores.BAIRRO,
tabela_de_clientes.NOME AS CLIENTE,
tabela_de_clientes.BAIRRO 
FROM tabela_de_vendedores, tabela_de_clientes;

-- Lista os clientes que residem em bairros onde existem vendedores

SELECT 
NOME, 
BAIRRO 
FROM tabela_de_clientes
WHERE BAIRRO IN (SELECT DISTINCT BAIRRO FROM tabela_de_vendedores);
 
 
-- Lista as embalagens cujo maior preço de produto é maior ou igual a 10

SELECT 
X.EMBALAGEM, 
X.PRECO_MAXIMO
FROM (SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS PRECO_MAXIMO FROM tabela_de_produtos
GROUP BY EMBALAGEM) X WHERE X.PRECO_MAXIMO >= 10;

-- Calcula o percentual de variação do preço de cada produto
-- em relação ao maior preço da sua respectiva embalagem

SELECT 
A.NOME_DO_PRODUTO, 
A.EMBALAGEM, 
A.PRECO_DE_LISTA, 
X.PRECO_MAXIMO,
((A.PRECO_DE_LISTA / X.PRECO_MAXIMO)-1) * 100 AS PERCENTUAL
FROM tabela_de_produtos A 
INNER JOIN VW_MAIORES_EMBALAGENS X 
ON A.EMBALAGEM = X.EMBALAGEM;















