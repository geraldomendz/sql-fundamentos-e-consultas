
-- Relatório mensal de vendas por cliente.
-- A consulta soma a quantidade total comprada por cada cliente em cada mês
-- e compara esse valor com o limite máximo de compra permitido.
-- As vendas são classificadas como "Válida" quando não ultrapassam o limite
-- e "Inválida" quando excedem o volume máximo autorizado.


-- Consulta com número de clientes por mês 

SELECT 
NF.CPF, 
DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS ANO_MES, 
SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDA
FROM notas_fiscais NF
INNER JOIN  itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO 
GROUP BY NF.CPF, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m');

-- Limite de compra por cliente *

SELECT 
NF.CPF, 
TC.NOME, 
DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS ANO_MES, 
SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDA, 
MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_LIMITE
FROM notas_fiscais NF
INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO 
INNER JOIN tabela_de_clientes TC ON TC.CPF = NF.CPF
GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m');

-- Consulta Final 

SELECT 
VENDAS_MENSAIS.CPF, 
VENDAS_MENSAIS.NOME, 
VENDAS_MENSAIS.ANO_MES, 
VENDAS_MENSAIS.QUANTIDADE_VENDA, 
VENDAS_MENSAIS.QUANTIDADE_LIMITE,
CASE 
 WHEN VENDAS_MENSAIS.QUANTIDADE_VENDA > VENDAS_MENSAIS.QUANTIDADE_LIMITE THEN 'Inválida'
 ELSE 'Válida' 
END AS STATUS_VENDA
FROM (
SELECT
NF.CPF, 
TC.NOME, 
DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS ANO_MES,  
SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDA, 
MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_LIMITE
FROM notas_fiscais NF
INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO 
INNER JOIN tabela_de_clientes TC ON TC.CPF = NF.CPF
GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m')) VENDAS_MENSAIS;
