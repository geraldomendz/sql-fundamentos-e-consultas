/* ============================================================
   RELATÓRIO MENSAL DE VENDAS POR CLIENTE

   Objetivo:
   - Consolidar o volume total comprado por cada cliente em
     cada mês
   - Comparar o volume mensal de compras com o limite máximo
     permitido para cada cliente
   - Classificar as vendas como:
       • "Válida"   → dentro do limite autorizado
       • "Inválida" → acima do limite permitido
============================================================ */


/* ------------------------------------------------------------
   CONSULTA 1 – VOLUME DE VENDAS MENSAL POR CLIENTE

   Descrição:
   - Agrupa as vendas por cliente (CPF) e por mês/ano
   - Soma a quantidade total vendida em cada período
------------------------------------------------------------ */
SELECT 
   NF.CPF, 
   DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS ANO_MES, 
   SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDA
FROM notas_fiscais NF
INNER JOIN itens_notas_fiscais INF 
   ON NF.NUMERO = INF.NUMERO 
GROUP BY NF.CPF, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m');


/* ------------------------------------------------------------
   CONSULTA 2 – LIMITE DE COMPRA MENSAL POR CLIENTE

   Descrição:
   - Recupera o limite máximo de compra definido para cada cliente
   - Consolida o volume comprado por mês
   - Associa os dados de vendas às informações cadastrais do cliente
------------------------------------------------------------ */
SELECT 
   NF.CPF, 
   TC.NOME, 
   DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS ANO_MES, 
   SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDA, 
   MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_LIMITE
FROM notas_fiscais NF
INNER JOIN itens_notas_fiscais INF 
   ON NF.NUMERO = INF.NUMERO 
INNER JOIN tabela_de_clientes TC 
   ON TC.CPF = NF.CPF
GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m');


/* ------------------------------------------------------------
   CONSULTA FINAL – CLASSIFICAÇÃO DAS VENDAS

   Descrição:
   - Compara o volume mensal comprado com o limite do cliente
   - Classifica cada registro como "Válida" ou "Inválida"
   - Retorna um relatório consolidado pronto para análise
------------------------------------------------------------ */
SELECT 
   VENDAS_MENSAIS.CPF, 
   VENDAS_MENSAIS.NOME, 
   VENDAS_MENSAIS.ANO_MES, 
   VENDAS_MENSAIS.QUANTIDADE_VENDA, 
   VENDAS_MENSAIS.QUANTIDADE_LIMITE,
   CASE 
      WHEN VENDAS_MENSAIS.QUANTIDADE_VENDA > VENDAS_MENSAIS.QUANTIDADE_LIMITE 
         THEN 'Inválida'
      ELSE 'Válida' 
   END AS STATUS_VENDA
FROM (
   /* Subconsulta: consolidação das vendas mensais com limite */
   SELECT
      NF.CPF, 
      TC.NOME, 
      DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS ANO_MES,  
      SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDA, 
      MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_LIMITE
   FROM notas_fiscais NF
   INNER JOIN itens_notas_fiscais INF 
      ON NF.NUMERO = INF.NUMERO 
   INNER JOIN tabela_de_clientes TC 
      ON TC.CPF = NF.CPF
   GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m')
) VENDAS_MENSAIS;
