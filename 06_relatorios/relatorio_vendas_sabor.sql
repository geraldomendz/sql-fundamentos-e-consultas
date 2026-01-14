/* ============================================================
   RELATÓRIO DE VENDAS POR SABOR – ANO 2016

   Objetivo:
   - Apresentar o volume total vendido (em litros) por sabor
   - Considerar apenas vendas realizadas no ano de 2016
   - Calcular o percentual de participação de cada sabor
     em relação ao total vendido no ano
============================================================ */


/* ------------------------------------------------------------
   CONSULTA 1 – VOLUME DE VENDAS POR SABOR (2016)

   Descrição:
   - Agrupa as vendas por sabor
   - Soma a quantidade total de litros vendidos
   - Considera apenas notas fiscais do ano de 2016
------------------------------------------------------------ */
SELECT 
   TP.SABOR,
   YEAR(NF.DATA_VENDA) AS ANO,
   SUM(INF.QUANTIDADE) AS QUANTIDADE_LITROS
FROM tabela_de_produtos TP 
INNER JOIN itens_notas_fiscais INF
   ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN notas_fiscais NF 
   ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2016
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
ORDER BY QUANTIDADE_LITROS DESC;


/* ------------------------------------------------------------
   CONSULTA 2 – VOLUME TOTAL VENDIDO NO ANO DE 2016

   Descrição:
   - Soma o total de litros vendidos no ano
   - Utilizada como base para cálculo do percentual
------------------------------------------------------------ */
SELECT 
   YEAR(NF.DATA_VENDA) AS ANO,
   SUM(INF.QUANTIDADE) AS QUANTIDADE_LITROS
FROM tabela_de_produtos TP 
INNER JOIN itens_notas_fiscais INF
   ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN notas_fiscais NF 
   ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2016
GROUP BY YEAR(NF.DATA_VENDA)
ORDER BY QUANTIDADE_LITROS DESC;


/* ------------------------------------------------------------
   CONSULTA FINAL – RELATÓRIO CONSOLIDADO

   Descrição:
   - Combina o total vendido por sabor com o total geral do ano
   - Calcula o percentual de participação de cada sabor
   - Retorna:
       • Sabor
       • Ano
       • Quantidade total vendida (litros)
       • Percentual de participação nas vendas do ano
------------------------------------------------------------ */
SELECT 
   VENDA_SABOR.SABOR,
   VENDA_SABOR.ANO,
   VENDA_SABOR.QUANTIDADE_LITROS,
   ROUND(
      (VENDA_SABOR.QUANTIDADE_LITROS / VENDA_TOTAL.QUANTIDADE_LITROS) * 100, 
      2
   ) AS PERCENTUAL_PARTICIPACAO
FROM
(
   /* Subconsulta: vendas agregadas por sabor */
   SELECT 
      TP.SABOR,
      YEAR(NF.DATA_VENDA) AS ANO,
      SUM(INF.QUANTIDADE) AS QUANTIDADE_LITROS
   FROM tabela_de_produtos TP 
   INNER JOIN itens_notas_fiscais INF
      ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
   INNER JOIN notas_fiscais NF 
      ON NF.NUMERO = INF.NUMERO
   WHERE YEAR(NF.DATA_VENDA) = 2016
   GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
) AS VENDA_SABOR
INNER JOIN
(
   /* Subconsulta: total geral vendido no ano */
   SELECT 
      YEAR(NF.DATA_VENDA) AS ANO,
      SUM(INF.QUANTIDADE) AS QUANTIDADE_LITROS
   FROM tabela_de_produtos TP 
   INNER JOIN itens_notas_fiscais INF
      ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
   INNER JOIN notas_fiscais NF 
      ON NF.NUMERO = INF.NUMERO
   WHERE YEAR(NF.DATA_VENDA) = 2016
   GROUP BY YEAR(NF.DATA_VENDA)
) AS VENDA_TOTAL
   ON VENDA_SABOR.ANO = VENDA_TOTAL.ANO
ORDER BY VENDA_SABOR.QUANTIDADE_LITROS DESC;
