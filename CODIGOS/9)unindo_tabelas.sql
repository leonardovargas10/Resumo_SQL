use SUCOS_VENDAS

--UNION 

SELECT DISTINCT BAIRRO FROM [TABELA DE CLIENTES]
UNION
SELECT DISTINCT BAIRRO FROM [TABELA DE VENDEDORES]

--UNION ALL

SELECT DISTINCT BAIRRO FROM [TABELA DE CLIENTES]
UNION ALL
SELECT DISTINCT BAIRRO FROM [TABELA DE VENDEDORES]

SELECT DISTINCT BAIRRO, NOME, 'CLIENTE' as VENDEDOR_OU_CLIENTE
FROM [TABELA DE CLIENTES] 
UNION ALL
SELECT DISTINCT BAIRRO, NOME, 'VENDEDOR' as VENDEDOR_OU_CLIENTE
FROM [TABELA DE VENDEDORES] 

--SUBQUERYS

SELECT 
	NOME,
	BAIRRO
FROM [TABELA DE CLIENTES]
WHERE BAIRRO IN (SELECT BAIRRO FROM [TABELA DE VENDEDORES])

SELECT
	A.EMBALAGEM,
	A.MAX_PRECO
FROM (SELECT 
		EMBALAGEM, 
		MAX([PRE?O DE LISTA]) 
		AS MAX_PRECO 
	FROM [TABELA DE PRODUTOS] 
	GROUP BY EMBALAGEM) AS A
WHERE A.MAX_PRECO<=5

SELECT CPF, COUNT(*) AS QUANTIDADE_DE_COMPRAS FROM [NOTAS FISCAIS]
WHERE YEAR(DATA) = 2016
GROUP BY CPF
HAVING COUNT(*) > 2000


SELECT
	X.CPF, 
	X.CONTADOR 
FROM (SELECT 
			CPF, 
			COUNT(*) AS CONTADOR 
		FROM [NOTAS FISCAIS]
		WHERE YEAR(DATA) = 2016
		GROUP BY CPF) as X 
WHERE X.CONTADOR > 2000

SELECT
	A.CPF,
	A.QUANTIDADE_DE_OCORRENCIAS 
FROM (SELECT 
			CPF, 
			COUNT(*) AS QUANTIDADE_DE_OCORRENCIAS 
		FROM [NOTAS FISCAIS] 
		WHERE YEAR(DATA) = 2016 
		GROUP BY CPF) AS A
WHERE A.QUANTIDADE_DE_OCORRENCIAS >2000


