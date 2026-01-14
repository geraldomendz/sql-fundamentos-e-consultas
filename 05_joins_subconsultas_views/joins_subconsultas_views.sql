/* ============================================================
   CONSULTAS DE RELACIONAMENTO E ANÁLISE DE DADOS

   Objetivo:
   - Explorar diferentes tipos de JOINs
   - Analisar relacionamentos entre vendedores, clientes,
     notas fiscais e produtos
   - Demonstrar consultas comuns em cenários analíticos
============================================================ */


/* ------------------------------------------------------------
   CONSULTA 1 – VENDAS REALIZADAS POR VENDEDOR

   Descrição:
   - Lista todas as vendas realizadas
   - Relaciona vendedores às notas fiscais emitidas
------------------------------------------------------------ */
SELECT * 
FROM tabela_de_vendedores A 
INNER JOIN notas_fiscais B
   ON A.MATRICULA = B.MATRICULA;


/* ------------------------------------------------------------
   CONSULTA 2 – QUANTIDADE DE NOTAS FISCAIS POR VENDEDOR

   Descrição:
   - Conta o número de notas fiscais emitidas por cada vendedor
------------------------------------------------------------ */
SELECT 
   A.MATRICULA, 
   A.NOME, 
   COUNT(*)
FROM tabela_de_vendedores A 
INNER JOIN notas_fiscais B
   ON A.MATRICULA = B.MATRICULA
GROUP BY A.MATRICULA, A.NOME;


/* ------------------------------------------------------------
   CONSULTA 3 – CLIENTES E NOTAS FISCAIS ASSOCIADAS

   Descrição:
   - Lista todos os clientes
   - Indica quais possuem notas fiscais vinculadas
------------------------------------------------------------ */
SELECT DISTINCT 
   A.NOME, 
   B.CPF 
FROM tabela_de_clientes A
LEFT JOIN notas_fiscais B
   ON A.CPF = B.CPF;


/* ------------------------------------------------------------
   CONSULTA 4 – CLIENTES SEM NOTAS FISCAIS

   Descrição:
   - Identifica clientes que não possuem nenhuma venda registrada
------------------------------------------------------------ */
SELECT DISTINCT 
   A.NOME, 
   B.CPF 
FROM tabela_de_clientes A
LEFT JOIN notas_fiscais B
   ON A.CPF = B.CPF 
WHERE B.CPF IS NULL;


/* ------------------------------------------------------------
   CONSULTA 5 – CLIENTES SEM COMPRAS NO ANO DE 2015

   Descrição:
   - Lista clientes que não realizaram compras no ano de 2015
------------------------------------------------------------ */
SELECT DISTINCT 
   A.NOME, 
   B.CPF 
FROM tabela_de_clientes A
LEFT JOIN notas_fiscais B
   ON A.CPF = B.CPF 
WHERE B.CPF IS NULL 
  AND YEAR(B.DATA_VENDA = 2015);


/* ------------------------------------------------------------
   CONSULTA 6 – CLIENTES SEM NOTAS FISCAIS (RIGHT JOIN)

   Descrição:
   - Identifica clientes sem notas fiscais
   - Utiliza RIGHT JOIN para o mesmo resultado da consulta anterior
------------------------------------------------------------ */
SELECT DISTINCT 
   A.NOME, 
   A.CPF 
FROM notas_fiscais A
RIGHT JOIN tabela_de_clientes B
   ON B.CPF = A.CPF 
WHERE A.CPF IS NULL;


/* ------------------------------------------------------------
   CONSULTA 7 – VENDEDORES E CLIENTES NO MESMO BAIRRO

   Descrição:
   - Relaciona vendedores e clientes que residem no mesmo bairro
------------------------------------------------------------ */
SELECT 
   tabela_de_vendedores.NOME AS VENDEDOR, 
   tabela_de_vendedores.BAIRRO,
   tabela_de_clientes.NOME AS CLIENTE,
   tabela_de_clientes.BAIRRO 
FROM tabela_de_vendedores 
INNER JOIN tabela_de_clientes  
   ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;


/* ------------------------------------------------------------
   CONSULTA 8 – TODOS OS VENDEDORES E CLIENTES NO MESMO BAIRRO

   Descrição:
   - Lista todos os vendedores
   - Exibe clientes no mesmo bairro quando existirem
------------------------------------------------------------ */
SELECT 
   tabela_de_vendedores.NOME AS VENDEDOR, 
   tabela_de_vendedores.BAIRRO,
   tabela_de_clientes.NOME AS CLIENTE,
   tabela_de_clientes.BAIRRO 
FROM tabela_de_vendedores 
LEFT JOIN tabela_de_clientes 
   ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;


/* ------------------------------------------------------------
   CONSULTA 9 – TODOS OS CLIENTES E VENDEDORES NO MESMO BAIRRO

   Descrição:
   - Lista todos os clientes
   - Exibe vendedores no mesmo bairro quando existirem
------------------------------------------------------------ */
SELECT 
   tabela_de_vendedores.NOME AS VENDEDOR, 
   tabela_de_vendedores.BAIRRO,
   tabela_de_clientes.NOME AS CLIENTE,
   tabela_de_clientes.BAIRRO 
FROM tabela_de_vendedores 
RIGHT JOIN tabela_de_clientes 
   ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;


/* ------------------------------------------------------------
   CONSULTA 10 – SIMULAÇÃO DE FULL JOIN

   Descrição:
   - Combina LEFT JOIN e RIGHT JOIN com UNION
   - Exibe todos os vendedores e clientes, com ou sem correspondência
------------------------------------------------------------ */
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


/* ------------------------------------------------------------
   CONSULTA 11 – PRODUTO CARTESIANO (CROSS JOIN)

   Descrição:
   - Gera todas as combinações possíveis entre vendedores e clientes
------------------------------------------------------------ */
SELECT 
   tabela_de_vendedores.NOME AS VENDEDOR, 
   tabela_de_vendedores.BAIRRO,
   tabela_de_clientes.NOME AS CLIENTE,
   tabela_de_clientes.BAIRRO 
FROM tabela_de_vendedores, tabela_de_clientes;


/* ------------------------------------------------------------
   CONSULTA 12 – CLIENTES EM BAIRROS COM VENDEDORES

   Descrição:
   - Lista clientes que residem em bairros onde há vendedores
------------------------------------------------------------ */
SELECT 
   NOME, 
   BAIRRO 
FROM tabela_de_clientes
WHERE BAIRRO IN (
   SELECT DISTINCT BAIRRO 
   FROM tabela_de_vendedores
);


/* ------------------------------------------------------------
   CONSULTA 13 – EMBALAGENS COM PREÇO MÁXIMO ≥ 10

   Descrição:
   - Identifica embalagens cujo maior preço de produto
     é maior ou igual a 10
------------------------------------------------------------ */
SELECT 
   X.EMBALAGEM, 
   X.PRECO_MAXIMO
FROM (
   SELECT 
      EMBALAGEM, 
      MAX(PRECO_DE_LISTA) AS PRECO_MAXIMO 
   FROM tabela_de_produtos
   GROUP BY EMBALAGEM
) X 
WHERE X.PRECO_MAXIMO >= 10;


/* ------------------------------------------------------------
   CONSULTA 14 – VARIAÇÃO DE PREÇO POR PRODUTO

   Descrição:
   - Calcula o percentual de variação do preço de cada produto
   - Compara o preço do produto com o maior preço da sua embalagem
------------------------------------------------------------ */
SELECT 
   A.NOME_DO_PRODUTO, 
   A.EMBALAGEM, 
   A.PRECO_DE_LISTA, 
   X.PRECO_MAXIMO,
   ((A.PRECO_DE_LISTA / X.PRECO_MAXIMO) - 1) * 100 AS PERCENTUAL
FROM tabela_de_produtos A 
INNER JOIN VW_MAIORES_EMBALAGENS X 
   ON A.EMBALAGEM = X.EMBALAGEM;
