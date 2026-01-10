
-- Cria a tabela de clientes com informações pessoais, endereço,
-- dados demográficos e regras comerciais de compra

CREATE TABLE tb_cliente
(cpf VARCHAR(11) PRIMARY KEY, 
nome VARCHAR(100) NOT NULL, 
endereco1 VARCHAR(150), 
endereco2 VARCHAR(150), 
bairro VARCHAR(50),
cidade VARCHAR(50) NOT NULL, 
estado CHAR(2) NOT NULL, 
cep VARCHAR(10), 
idade SMALLINT, 
genero CHAR(1), 
limite_credito DECIMAL(10,2),
volume_minimo DECIMAL(10,2),
primeira_compra BIT(1));


-- Cria a tabela de produtos com dados de identificação,
-- características do produto e preço de venda

CREATE TABLE tb_produto
(codigo VARCHAR(20) PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
embalagem VARCHAR(50),
tamanho VARCHAR(50),
sabor VARCHAR(50),
preco_lista DECIMAL(10,2));
