/* ============================================================
   CONSULTAS DE ORDENAÇÃO, AGREGAÇÃO E CLASSIFICAÇÃO

   Objetivo:
   - Demonstrar operações de ordenação (ORDER BY)
   - Realizar agregações com funções estatísticas
   - Aplicar filtros em grupos (HAVING)
   - Classificar registros com expressões condicionais (CASE)
============================================================ */


/* ------------------------------------------------------------
   CONSULTA 1 – PRODUTOS ORDENADOS POR PREÇO (CRESCENTE)

   Descrição:
   - Lista todos os produtos
   - Ordena do menor para o maior preço
------------------------------------------------------------ */
SELECT * 
FROM tabela_de_produtos 
ORDER BY preco_de_lista;


/* ------------------------------------------------------------
   CONSULTA 2 – PRODUTOS ORDENADOS POR PREÇO (DECRESCENTE)

   Descrição:
   - Lista todos os produtos
   - Ordena do maior para o menor preço
------------------------------------------------------------ */
SELECT * 
FROM tabela_de_produtos 
ORDER BY preco_de_lista DESC;


/* ------------------------------------------------------------
   CONSULTA 3 – LIMITE DE CRÉDITO TOTAL POR ESTADO

   Descrição:
   - Agrupa os clientes por estado
   - Soma o limite de crédito disponível em cada estado
------------------------------------------------------------ */
SELECT 
   estado, 
   SUM(limite_de_credito) AS limite_total 
FROM tabela_de_clientes 
GROUP BY estado;


/* ------------------------------------------------------------
   CONSULTA 4 – MAIOR LIMITE DE CRÉDITO POR ESTADO

   Descrição:
   - Agrupa os clientes por estado
   - Identifica o maior limite de crédito em cada estado
------------------------------------------------------------ */
SELECT 
   estado, 
   MAX(limite_de_credito) AS maior_limite 
FROM tabela_de_clientes
GROUP BY estado;


/* ------------------------------------------------------------
   CONSULTA 5 – PREÇO MÉDIO DOS PRODUTOS POR EMBALAGEM

   Descrição:
   - Agrupa os produtos por tipo de embalagem
   - Calcula o preço médio por grupo
------------------------------------------------------------ */
SELECT 
   embalagem, 
   AVG(preco_de_lista) AS preco_medio 
FROM tabela_de_produtos 
GROUP BY embalagem;


/* ------------------------------------------------------------
   CONSULTA 6 – MAIOR PREÇO POR EMBALAGEM

   Descrição:
   - Agrupa os produtos por embalagem
   - Exibe o maior preço registrado em cada grupo
------------------------------------------------------------ */
SELECT 
   embalagem, 
   MAX(preco_de_lista) AS maior_preco 
FROM tabela_de_produtos 
GROUP BY embalagem;


/* ------------------------------------------------------------
   CONSULTA 7 – QUANTIDADE DE PRODUTOS POR EMBALAGEM

   Descrição:
   - Agrupa os produtos por embalagem
   - Conta a quantidade de produtos disponíveis
------------------------------------------------------------ */
SELECT 
   embalagem, 
   COUNT(*) AS contador
FROM tabela_de_produtos 
GROUP BY embalagem;


/* ------------------------------------------------------------
   CONSULTA 8 – LIMITE DE CRÉDITO POR BAIRRO (RIO DE JANEIRO)

   Descrição:
   - Agrupa clientes por bairro
   - Soma o limite de crédito apenas para a cidade do Rio de Janeiro
------------------------------------------------------------ */
SELECT 
   bairro, 
   SUM(limite_de_credito) AS limite_total 
FROM tabela_de_clientes 
WHERE cidade = 'rio de janeiro' 
GROUP BY bairro;


/* ------------------------------------------------------------
   CONSULTA 9 – LIMITE DE CRÉDITO POR BAIRRO (ORDENADO)

   Descrição:
   - Agrupa clientes por bairro no Rio de Janeiro
   - Ordena o total de limite do menor para o maior
------------------------------------------------------------ */
SELECT 
   bairro, 
   SUM(limite_de_credito) AS limite_total 
FROM tabela_de_clientes 
WHERE cidade = 'rio de janeiro' 
GROUP BY bairro 
ORDER BY limite_total;


/* ------------------------------------------------------------
   CONSULTA 10 – ESTADOS COM LIMITE DE CRÉDITO TOTAL ELEVADO

   Descrição:
   - Agrupa os clientes por estado
   - Exibe apenas estados cujo limite total ultrapassa 900.000
------------------------------------------------------------ */
SELECT 
   estado, 
   SUM(limite_de_credito) AS limite_total 
FROM tabela_de_clientes 
GROUP BY estado
HAVING SUM(limite_de_credito) > 900000;


/* ------------------------------------------------------------
   CONSULTA 11 – MAIOR E MENOR PREÇO POR EMBALAGEM

   Descrição:
   - Agrupa os produtos por embalagem
   - Exibe o maior e o menor preço de cada grupo
------------------------------------------------------------ */
SELECT 
   embalagem,
   MAX(preco_de_lista) AS maior_preco, 
   MIN(preco_de_lista) AS menor_preco 
FROM tabela_de_produtos
GROUP BY embalagem;


/* ------------------------------------------------------------
   CONSULTA 12 – EMBALAGENS COM PREÇO MÉDIO ACIMA DE 5

   Descrição:
   - Calcula o preço médio por embalagem
   - Exibe apenas as embalagens com média superior a 5
------------------------------------------------------------ */
SELECT 
   embalagem, 
   AVG(preco_de_lista) AS preco_medio 
FROM tabela_de_produtos 
GROUP BY embalagem
HAVING AVG(preco_de_lista) > 5
ORDER BY preco_medio;


/* ------------------------------------------------------------
   CONSULTA 13 – CLASSIFICAÇÃO DE PRODUTOS POR FAIXA DE PREÇO

   Descrição:
   - Classifica cada produto de acordo com seu preço
   - Categorias:
       • produto caro
       • produto em conta
       • produto barato
------------------------------------------------------------ */
SELECT 
   nome_do_produto, 
   preco_de_lista,
   CASE
      WHEN preco_de_lista >= 12 THEN 'produto caro'
      WHEN preco_de_lista >= 7 AND preco_de_lista < 12 THEN 'produto em conta'
      ELSE 'produto barato' 
   END AS classificacao_preco 
FROM tabela_de_produtos;


/* ------------------------------------------------------------
   CONSULTA 14 – PREÇO MÉDIO POR EMBALAGEM E FAIXA DE PREÇO

   Descrição:
   - Agrupa os produtos por embalagem
   - Classifica por faixa de preço
   - Calcula o preço médio em cada combinação
------------------------------------------------------------ */
SELECT 
   embalagem,
   CASE
      WHEN preco_de_lista >= 12 THEN 'produto caro'
      WHEN preco_de_lista >= 7 AND preco_de_lista < 12 THEN 'produto em conta'
      ELSE 'produto barato' 
   END AS classificacao_preco, 
   AVG(preco_de_lista) AS preco_medio
FROM tabela_de_produtos 
GROUP BY 
   embalagem,
   CASE
      WHEN preco_de_lista >= 12 THEN 'produto caro'
      WHEN preco_de_lista >= 7 AND preco_de_lista < 12 THEN 'produto em conta'
      ELSE 'produto barato' 
   END;
