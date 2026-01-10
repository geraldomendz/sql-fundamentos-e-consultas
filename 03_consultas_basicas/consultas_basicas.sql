
-- Lista os clientes exibindo CPF e cidade 

SELECT cpf, cidade FROM tb_cliente;

-- Lista os clientes exibindo CPF e gênero 

SELECT cpf, genero FROM tb_cliente;

-- Lista os clientes exibindo cidade e data de nascimento 

SELECT cidade, data_nascimento FROM tb_cliente;

-- Lista os 5 primeiros clientes exibindo CPF e nome 

SELECT cpf, nome FROM tb_cliente LIMIT 5;

-- Lista os clientes exibindo o CPF com alias "IDENTIFICADOR" e gênero 

SELECT cpf AS IDENTIFICADOR, genero FROM tb_cliente;

-- Lista o produto de código 1013793 exibindo código, nome e preço 

SELECT codigo, nome, preco_Lista FROM tb_produto WHERE codigo = '1013793';

-- Lista os produtos com preço maior que 10

SELECT * FROM tb_produto WHERE preco_lista > 10;

-- Lista os clientes com idade maior que 20 exibindo nome, idade e cidade

SELECT nome, idade, cidade FROM tb_cliente WHERE idade > 20;

-- Lista os clientes que residem na cidade do Rio de Janeiro

SELECT * FROM tb_cliente WHERE cidade = 'rio de janeiro';

-- Lista os produtos com sabor diferente de limão e preço menor que 5 

SELECT * FROM tb_produto WHERE sabor <> 'limão' and preco_lista < 5;

-- Lista o produto com preço igual a 4.21 exibindo nome e preço 

SELECT nome, preco_lista FROM tb_produto WHERE preco_lista = 4.21;

-- Lista os produtos com preço entre 2 e 5 

SELECT * FROM tb_produto WHERE preco_lista between 2 and 5;

-- Lista os clientes que nasceram no ano de 1992 

SELECT * FROM tb_cliente WHERE YEAR(data_nascimento) = 1992;

-- Lista os clientes que nasceram no mês de julho

SELECT * FROM tb_cliente WHERE MONTH(data_nascimento) = 07;

-- Lista os clientes com idade maior que 20 e residentes no Rio de Janeiro

SELECT * FROM tb_Cliente WHERE idade > 20 and cidade = 'Rio de Janeiro';

-- Lista os clientes que possuem "silva" no nome

SELECT * FROM tabela_de_clientes WHERE nome LIKE '%silva%';

-- Lista os clientes que não possuem "silva" no nome

SELECT * FROM tabela_de_clientes WHERE nome NOT LIKE '%silva%';

-- Lista os produtos que não são sabor uva e possuem preço maior que 5

SELECT * FROM tabela_de_produtos WHERE (sabor NOT LIKE '%uva%' AND preco_de_lista > 5);

-- Lista os produtos com sabor cereja ou uva 

SELECT * FROM tabela_de_produtos WHERE sabor IN ('cereja','uva');

-- Lista 3 clientes a partir da terceira posição da tabela

SELECT * FROM tabela_de_clientes LIMIT 2,3;