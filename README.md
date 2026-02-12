#  SQL – Fundamentos e Consultas Analíticas

Este repositório reúne **scripts SQL organizados e documentados** com foco em **fundamentos, consultas intermediárias e construção de relatórios analíticos**, simulando cenários reais de análise em bancos de dados relacionais.

O projeto foi estruturado para demonstrar não apenas consultas isoladas, mas também a **evolução até relatórios consolidados**, aplicando regras de negócio, validações e métricas analíticas.

---

##  Objetivo do Projeto

Demonstrar capacidade de:

- Estruturar e consultar bancos de dados relacionais  
- Aplicar boas práticas de organização e documentação de SQL  
- Utilizar `JOINs`, agregações, subconsultas e `CASE`  
- Desenvolver relatórios analíticos com regras de negócio  
- Trabalhar com bases de dados pré-existentes, simulando ambientes reais  

---

##  Estrutura do Projeto

- **01_criacao_tabelas**  
  Scripts responsáveis pela definição da estrutura do banco de dados.

- **02_insercao_dados**  
  Scripts de inserção e carga de dados nas tabelas.

- **03_consultas_basicas**  
  Consultas com filtros, operadores lógicos, aliases e ordenações.

- **04_agregacoes_group_by**  
  Análises utilizando funções de agregação (`SUM`, `AVG`, `COUNT`, `MAX`, `MIN`)  
  combinadas com `GROUP BY` e `HAVING`.

- **05_joins_subconsultas_views**  
  Consultas envolvendo múltiplas tabelas com `JOINs`,  
  uso de subconsultas e criação de `VIEWs`.

- **06_relatorios**  
  Relatórios consolidados com foco analítico e aplicação de regras de negócio.

---

##  Destaque: Relatórios Analíticos

A pasta **06_relatorios** concentra os principais artefatos do projeto, simulando relatórios utilizados em contextos reais de análise de dados.

###  Relatório 1 – Validação de Limite de Compra por Cliente

**Descrição:**

- Consolida o volume de compras **mensais** por cliente  
- Compara o total comprado com o **limite máximo permitido**  
- Classifica as vendas como **“Válida”** ou **“Inválida”** com base em regras de negócio  

**Principais conceitos aplicados:**

- Agregação por cliente e período (ano/mês)  
- `JOINs` entre notas fiscais, itens e clientes  
- Aplicação de regras de negócio com `CASE`  
- Classificação de dados para auditoria e controle comercial  

 *Simula um cenário real de validação de políticas comerciais e controle de risco.*

---

###  Relatório 2 – Vendas por Sabor (Ano de 2016)

**Descrição:**

- Consolida o volume total de vendas por sabor no ano de 2016  
- Calcula a quantidade total vendida (em litros)  
- Determina o **percentual de participação de cada sabor** em relação ao total anual  

**Principais conceitos aplicados:**

- `JOINs` entre produtos, itens de notas fiscais e notas fiscais  
- Agregações com `SUM`  
- Cálculo de métricas percentuais  
- Subconsultas para separação de totais e detalhamento  
- Organização do resultado para análise comparativa  

 *Simula um relatório de performance de produtos, comum em áreas comerciais e de BI.*

---

##  Observações sobre os Dados

- Parte das tabelas foi criada manualmente via scripts SQL  
- Outras tabelas foram importadas a partir de fontes externas  
- O cenário simula ambientes onde o banco já existe e o foco está
  na **análise, consulta e geração de relatórios**

---

##  Tecnologias Utilizadas

-  **MySQL**
-  **MySQL Workbench**
-  SQL padrão ANSI (com extensões específicas do MySQL)

---

##  Considerações Finais

Este projeto tem caráter **educacional e demonstrativo**, servindo como base para:

- Estudos em SQL  
- Portfólio inicial em **Engenharia de Dados**  

