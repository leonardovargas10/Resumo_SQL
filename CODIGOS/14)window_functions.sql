USE SUCOS_VENDAS

--SELECT * FROM [NOTAS FISCAIS]

--SELECT * FROM [ITENS NOTAS FISCAIS]

--SELECT * FROM [TABELA DE CLIENTES]

--SELECT * FROM [TABELA DE PRODUTOS]

--SELECT * FROM [TABELA DE VENDEDORES]

WITH table_transaction AS (
SELECT 
	vendedores.NOME as nome_vendedores,
	notas_fiscais.NUMERO as numero_nota_fiscal,
	clientes.NOME as nome_cliente,
	produtos.[NOME DO PRODUTO] as NOME_PRODUTO,
	itens.QUANTIDADE,
	produtos.[PRE�O DE LISTA] as PRECO_PRODUTO,
	itens.QUANTIDADE*produtos.[PRE�O DE LISTA] as FATURAMENTO
FROM [TABELA DE CLIENTES] as clientes
inner join [NOTAS FISCAIS] as notas_fiscais on clientes.CPF = notas_fiscais.CPF 
inner join [ITENS NOTAS FISCAIS] as itens on notas_fiscais.NUMERO = itens.NUMERO
inner join [TABELA DE PRODUTOS] as produtos on itens.[CODIGO DO PRODUTO] = produtos.[CODIGO DO PRODUTO]
inner join [TABELA DE VENDEDORES] as vendedores on notas_fiscais.MATRICULA = vendedores.MATRICULA
)
-- As funções de janela (window functions) auxiliam de forma intuitiva na resolução de uma variedade de tarefas. 
-- Neste contexto, a janela se refere a um conjunto de linhas cujo conteúdo é definido na cláusula OVER.
SELECT 
	NOME_PRODUTO,
	MAX(FATURAMENTO)
FROM (
	SELECT 
		vendedores.NOME as nome_vendedores,
		notas_fiscais.NUMERO as numero_nota_fiscal,
		clientes.NOME as nome_cliente,
		produtos.[NOME DO PRODUTO] as NOME_PRODUTO,
		itens.QUANTIDADE,
		produtos.[PRE�O DE LISTA] as PRECO_PRODUTO,
		itens.QUANTIDADE*produtos.[PRE�O DE LISTA] as FATURAMENTO
	FROM [TABELA DE CLIENTES] as clientes
	inner join [NOTAS FISCAIS] as notas_fiscais on clientes.CPF = notas_fiscais.CPF 
	inner join [ITENS NOTAS FISCAIS] as itens on notas_fiscais.NUMERO = itens.NUMERO
	inner join [TABELA DE PRODUTOS] as produtos on itens.[CODIGO DO PRODUTO] = produtos.[CODIGO DO PRODUTO]
	inner join [TABELA DE VENDEDORES] as vendedores on notas_fiscais.MATRICULA = vendedores.MATRICULA
) as table_transaction
GROUP BY NOME_PRODUTO

SELECT 
	*,
	MAX(FATURAMENTO) OVER(PARTITION BY NOME_PRODUTO ORDER BY nome_vendedores ASC) as FATURAMENTO_MAXIMO
FROM (
	SELECT 
		vendedores.NOME as nome_vendedores,
		notas_fiscais.NUMERO as numero_nota_fiscal,
		clientes.NOME as nome_cliente,
		produtos.[NOME DO PRODUTO] as NOME_PRODUTO,
		itens.QUANTIDADE,
		produtos.[PRE�O DE LISTA] as PRECO_PRODUTO,
		itens.QUANTIDADE*produtos.[PRE�O DE LISTA] as FATURAMENTO
	FROM [TABELA DE CLIENTES] as clientes
	inner join [NOTAS FISCAIS] as notas_fiscais on clientes.CPF = notas_fiscais.CPF 
	inner join [ITENS NOTAS FISCAIS] as itens on notas_fiscais.NUMERO = itens.NUMERO
	inner join [TABELA DE PRODUTOS] as produtos on itens.[CODIGO DO PRODUTO] = produtos.[CODIGO DO PRODUTO]
	inner join [TABELA DE VENDEDORES] as vendedores on notas_fiscais.MATRICULA = vendedores.MATRICULA
) as table_transaction

-- ROW_NUMBER
-- O funcionamento dela é bem simples: gera uma sequência numérica no conjunto de linhas da janela, em ordem definida pelo elemento ORDER BY.

SELECT 
	*,
	ROW_NUMBER() OVER(PARTITION BY NOME_PRODUTO ORDER BY nome_vendedores ASC) as rn
FROM (
	SELECT 
		vendedores.NOME as nome_vendedores,
		notas_fiscais.NUMERO as numero_nota_fiscal,
		clientes.NOME as nome_cliente,
		produtos.[NOME DO PRODUTO] as NOME_PRODUTO,
		itens.QUANTIDADE,
		produtos.[PRE�O DE LISTA] as PRECO_PRODUTO,
		itens.QUANTIDADE*produtos.[PRE�O DE LISTA] as FATURAMENTO
	FROM [TABELA DE CLIENTES] as clientes
	inner join [NOTAS FISCAIS] as notas_fiscais on clientes.CPF = notas_fiscais.CPF 
	inner join [ITENS NOTAS FISCAIS] as itens on notas_fiscais.NUMERO = itens.NUMERO
	inner join [TABELA DE PRODUTOS] as produtos on itens.[CODIGO DO PRODUTO] = produtos.[CODIGO DO PRODUTO]
	inner join [TABELA DE VENDEDORES] as vendedores on notas_fiscais.MATRICULA = vendedores.MATRICULA
) as table_transaction

-- RANK
-- A função de janela RANK retorna a classificação de cada linha na janela. 
-- As funções ROW_NUMBER e RANK geram resultados similares: enquanto a função ROW_NUMBER numera todas as linhas em sequência (por exemplo 1, 2, 3, 4, 5, a função RANK fornece o mesmo valor numérico para empates (por exemplo 1, 2, 2, 4, 5) .

SELECT 
	*,
	RANK() OVER(PARTITION BY NOME_PRODUTO ORDER BY FATURAMENTO DESC) as rn
FROM (
	SELECT 
		vendedores.NOME as nome_vendedores,
		notas_fiscais.NUMERO as numero_nota_fiscal,
		clientes.NOME as nome_cliente,
		produtos.[NOME DO PRODUTO] as NOME_PRODUTO,
		itens.QUANTIDADE,
		produtos.[PRE�O DE LISTA] as PRECO_PRODUTO,
		itens.QUANTIDADE*produtos.[PRE�O DE LISTA] as FATURAMENTO
	FROM [TABELA DE CLIENTES] as clientes
	inner join [NOTAS FISCAIS] as notas_fiscais on clientes.CPF = notas_fiscais.CPF 
	inner join [ITENS NOTAS FISCAIS] as itens on notas_fiscais.NUMERO = itens.NUMERO
	inner join [TABELA DE PRODUTOS] as produtos on itens.[CODIGO DO PRODUTO] = produtos.[CODIGO DO PRODUTO]
	inner join [TABELA DE VENDEDORES] as vendedores on notas_fiscais.MATRICULA = vendedores.MATRICULA
) as table_transaction

-- DENSE_RANK
-- Esta função retorna a posição de cada linha dentro de uma janela, sem nenhum intervalo nos valores de classificação.

SELECT 
	*,
	DENSE_RANK() OVER(PARTITION BY NOME_PRODUTO ORDER BY FATURAMENTO DESC) as rn
FROM (
	SELECT 
		vendedores.NOME as nome_vendedores,
		notas_fiscais.NUMERO as numero_nota_fiscal,
		clientes.NOME as nome_cliente,
		produtos.[NOME DO PRODUTO] as NOME_PRODUTO,
		itens.QUANTIDADE,
		produtos.[PRE�O DE LISTA] as PRECO_PRODUTO,
		itens.QUANTIDADE*produtos.[PRE�O DE LISTA] as FATURAMENTO
	FROM [TABELA DE CLIENTES] as clientes
	inner join [NOTAS FISCAIS] as notas_fiscais on clientes.CPF = notas_fiscais.CPF 
	inner join [ITENS NOTAS FISCAIS] as itens on notas_fiscais.NUMERO = itens.NUMERO
	inner join [TABELA DE PRODUTOS] as produtos on itens.[CODIGO DO PRODUTO] = produtos.[CODIGO DO PRODUTO]
	inner join [TABELA DE VENDEDORES] as vendedores on notas_fiscais.MATRICULA = vendedores.MATRICULA
) as table_transaction

-- LAG
-- Esta função retorna dados de alguma linha anterior (normalmente a primeira) de uma janela cujo conjunto de dados esteja ordenado logicamente.

SELECT 
	*,
	LAG(rn) OVER(PARTITION BY NOME_PRODUTO ORDER BY nome_vendedores ASC) as rn_lag
FROM (
	SELECT 
		vendedores.NOME as nome_vendedores,
		notas_fiscais.NUMERO as numero_nota_fiscal,
		clientes.NOME as nome_cliente,
		produtos.[NOME DO PRODUTO] as NOME_PRODUTO,
		itens.QUANTIDADE,
		produtos.[PRE�O DE LISTA] as PRECO_PRODUTO,
		itens.QUANTIDADE*produtos.[PRE�O DE LISTA] as FATURAMENTO,
		ROW_NUMBER() OVER(PARTITION BY produtos.[NOME DO PRODUTO] ORDER BY vendedores.NOME ASC) as rn
	FROM [TABELA DE CLIENTES] as clientes
	inner join [NOTAS FISCAIS] as notas_fiscais on clientes.CPF = notas_fiscais.CPF 
	inner join [ITENS NOTAS FISCAIS] as itens on notas_fiscais.NUMERO = itens.NUMERO
	inner join [TABELA DE PRODUTOS] as produtos on itens.[CODIGO DO PRODUTO] = produtos.[CODIGO DO PRODUTO]
	inner join [TABELA DE VENDEDORES] as vendedores on notas_fiscais.MATRICULA = vendedores.MATRICULA
) as table_transaction


-- NTILE
-- NTILE é a próxima função de janela que abordaremos neste artigo. Ela divide um conjunto de dados ordenado em n partes e numera as partes sequencialmente.
-- Desta forma, todas as linhas de cada parte possuem o mesmo valor.
SELECT 
	NOME_PRODUTO,
	FATURAMENTO,
	NTILE(10) OVER( ORDER BY FATURAMENTO DESC) as rn
FROM (
	SELECT 
		vendedores.NOME as nome_vendedores,
		notas_fiscais.NUMERO as numero_nota_fiscal,
		clientes.NOME as nome_cliente,
		produtos.[NOME DO PRODUTO] as NOME_PRODUTO,
		itens.QUANTIDADE,
		produtos.[PRE�O DE LISTA] as PRECO_PRODUTO,
		itens.QUANTIDADE*produtos.[PRE�O DE LISTA] as FATURAMENTO
	FROM [TABELA DE CLIENTES] as clientes
	inner join [NOTAS FISCAIS] as notas_fiscais on clientes.CPF = notas_fiscais.CPF 
	inner join [ITENS NOTAS FISCAIS] as itens on notas_fiscais.NUMERO = itens.NUMERO
	inner join [TABELA DE PRODUTOS] as produtos on itens.[CODIGO DO PRODUTO] = produtos.[CODIGO DO PRODUTO]
	inner join [TABELA DE VENDEDORES] as vendedores on notas_fiscais.MATRICULA = vendedores.MATRICULA
) as table_transaction