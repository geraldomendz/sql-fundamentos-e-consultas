
-- Lista os produtos ordenados pelo preço do menor para o maior

SELECT * 
FROM tabela_de_produtos 
ORDER BY preco_de_lista;

-- Lista os produtos ordenados pelo preço do maior para o menor

SELECT * 
FROM tabela_de_produtos 
ORDER BY preco_de_lista DESC;

-- Agrupa os clientes por estado e mostra o total do limite de crédito

SELECT 
estado, 
SUM(limite_de_credito) AS limite_total 
FROM tabela_de_clientes 
GROUP BY estado;

-- Agrupa os clientes por estado e mostra o maior limite de crédito

SELECT 
estado, 
MAX(limite_de_credito) AS maior_limite 
FROM tabela_de_clientes
GROUP BY estado;

-- Agrupa os produtos por embalagem e calcula o preço médio

SELECT 
embalagem, 
AVG(preco_de_lista) AS preco_medio 
FROM tabela_de_produtos 
GROUP BY embalagem;

-- Agrupa os produtos por embalagem e mostra o maior preço

SELECT 
embalagem, 
MAX(preco_de_lista) AS maior_preco 
FROM tabela_de_produtos 
GROUP BY embalagem;

-- Agrupa os produtos por embalagem e conta a quantidade disponível

SELECT 
embalagem, 
COUNT(*) AS contador
FROM tabela_de_produtos 
GROUP BY embalagem;

-- Agrupa os bairros do Rio de Janeiro e soma o limite de crédito

SELECT 
bairro, 
SUM(limite_de_credito) AS limite_total 
FROM tabela_de_clientes 
WHERE cidade = 'rio de janeiro' 
GROUP BY bairro;

-- Agrupa os bairros do Rio de Janeiro e soma o limite de crédito, ordenando do menor para o maior

SELECT 
bairro, 
SUM(limite_de_credito) AS limite_total 
FROM tabela_de_clientes 
WHERE cidade = 'rio de janeiro' 
GROUP BY bairro 
ORDER BY limite_total;

-- Agrupa os estados que possuem limite de crédito total maior que 900.000

SELECT 
estado, 
SUM(limite_de_credito) AS limite_total 
FROM tabela_de_clientes 
GROUP BY estado
HAVING SUM(limite_de_credito) > 900000;

-- Agrupa os produtos por embalagem exibindo o maior e o menor preço

SELECT 
embalagem,
MAX(preco_de_lista) AS maior_preco, 
MIN(preco_de_lista) AS menor_preco 
FROM tabela_de_produtos
GROUP BY embalagem;

-- Agrupa os produtos por embalagem exibindo apenas os que possuem preço médio maior que 5

SELECT 
embalagem, 
AVG(preco_de_lista) AS preco_medio 
FROM tabela_de_produtos 
GROUP BY embalagem
HAVING AVG(preco_de_lista) > 5
ORDER BY preco_medio;

-- Classifica os produtos de acordo com a faixa de preço

SELECT 
nome_do_produto, 
preco_de_lista,
CASE
 WHEN preco_de_lista >= 12 THEN 'produto caro'
 WHEN preco_de_lista >= 7 and preco_de_lista < 12 THEN 'produto em conta'
ELSE 'produto barato' 
END AS classificacao_preco 
FROM tabela_de_produtos;


-- Agrupa os produtos por embalagem e faixa de preço, calculando o preço médio

SELECT 
embalagem,
CASE
 WHEN preco_de_lista >= 12 THEN 'produto caro'
 WHEN preco_de_lista >= 7 and preco_de_lista < 12 THEN 'produto em conta'
 ELSE 'produto barato' 
END AS classificacao_preco, AVG(preco_de_lista) AS preco_medio
FROM tabela_de_produtos 
GROUP BY embalagem,
CASE
 WHEN preco_de_lista >= 12 THEN 'produto caro'
 WHEN preco_de_lista >= 7 and preco_de_lista < 12 THEN 'produto em conta'
 ELSE 'produto barato' 
END;





