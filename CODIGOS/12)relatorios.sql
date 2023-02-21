USE SUCOS_VENDAS

--VENDAS VALIDAS
SELECT
	AUX1.NOME, 
	AUX1.ANO_MES,
	AUX1.QUANTIDADE_MES,
	CASE 
		 WHEN AUX1.QUANTIDADE_MES <= AUX1.[VOLUME DE COMPRA] THEN 'VENDA VALIDA'
		 WHEN AUX1.QUANTIDADE_MES > AUX1.[VOLUME DE COMPRA] THEN 'VENDA INVALIDA'
	END AS STATUS_VENDA
FROM
	(SELECT 
		C.NOME,
		CQ.ANO_MES,
		CQ.QUANTIDADE_MES,
		C.[VOLUME DE COMPRA]
	FROM 
	(SELECT
		B.CPF,
		SUBSTRING(CONVERT(VARCHAR, B.DATA, 120), 1, 7) AS ANO_MES,
		SUM(A.QUANTIDADE) AS QUANTIDADE_MES
	FROM [ITENS NOTAS FISCAIS] A
	INNER JOIN [NOTAS FISCAIS] B
	ON A.NUMERO = B.NUMERO
	GROUP BY B.CPF, SUBSTRING(CONVERT(VARCHAR, B.DATA, 120), 1, 7)) AS CQ
	INNER JOIN [TABELA DE CLIENTES] C
	ON CQ.CPF=C.CPF) AUX1
	ORDER BY AUX1.NOME, AUX1.ANO_MES

--MODIFICANDO A CONSULTA DO RELATORIO

SELECT
	AUX1.NOME, 
	AUX1.ANO_MES,
	AUX1.QUANTIDADE_MES,
	CONVERT(DECIMAL(15,2), (1 - (AUX1.[VOLUME DE COMPRA]/AUX1.QUANTIDADE_MES))) * 100 AS VARIACAO,
	CASE 
		 WHEN AUX1.QUANTIDADE_MES <= AUX1.[VOLUME DE COMPRA] THEN 'VENDA VALIDA'
		 WHEN AUX1.QUANTIDADE_MES > AUX1.[VOLUME DE COMPRA] THEN 'VENDA INVALIDA'
	END AS STATUS_VENDA
FROM
	(SELECT 
		C.NOME,
		CQ.ANO_MES,
		CQ.QUANTIDADE_MES,
		C.[VOLUME DE COMPRA]
	FROM 
	(SELECT
		B.CPF,
		SUBSTRING(CONVERT(VARCHAR, B.DATA, 120), 1, 7) AS ANO_MES,
		SUM(A.QUANTIDADE) AS QUANTIDADE_MES
	FROM [ITENS NOTAS FISCAIS] A
	INNER JOIN [NOTAS FISCAIS] B
	ON A.NUMERO = B.NUMERO
	GROUP BY B.CPF, SUBSTRING(CONVERT(VARCHAR, B.DATA, 120), 1, 7)) AS CQ
	INNER JOIN [TABELA DE CLIENTES] C
	ON CQ.CPF=C.CPF) AUX1
	ORDER BY AUX1.NOME, AUX1.ANO_MES

--VENDAS POR SABOR

SELECT
	TP.SABOR
FROM [TABELA DE PRODUTOS] TP

SELECT 
	NF.DATA
FROM [NOTAS FISCAIS] NF

SELECT 
	INF.QUANTIDADE*INF.PRE�O AS FATURAMENTO
FROM [ITENS NOTAS FISCAIS] INF




SELECT
	TP.SABOR,
	YEAR(NF.DATA) AS ANO,
	SUM((INF.QUANTIDADE*INF.PRE�O)) AS FATURAMENTO
FROM [ITENS NOTAS FISCAIS] INF
INNER JOIN [TABELA DE PRODUTOS] TP
ON INF.[CODIGO DO PRODUTO] = TP.[CODIGO DO PRODUTO]
INNER JOIN [NOTAS FISCAIS] NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA) = 2016
GROUP BY TP.SABOR, YEAR(NF.DATA)




SELECT
	AUX1.SABOR,
	AUX1.ANO,
	CONVERT(DECIMAL(15,2), AUX1.FATURAMENTO),
	CONVERT(VARCHAR,CONVERT(DECIMAL(15,2),(AUX1.FATURAMENTO/AUX2.TOTAL)*100)) + '%' AS PERCENTUAL
FROM
(SELECT
	TP.SABOR,
	YEAR(NF.DATA) AS ANO,
	SUM((INF.QUANTIDADE*INF.PRE�O)) AS FATURAMENTO
FROM [ITENS NOTAS FISCAIS] INF
INNER JOIN [TABELA DE PRODUTOS] TP
ON INF.[CODIGO DO PRODUTO] = TP.[CODIGO DO PRODUTO]
INNER JOIN [NOTAS FISCAIS] NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA) = 2016
GROUP BY TP.SABOR, YEAR(NF.DATA)) AUX1
INNER JOIN
(SELECT
	YEAR(NF.DATA) AS ANO,
	SUM((INF.QUANTIDADE*INF.PRE�O)) AS TOTAL
FROM [ITENS NOTAS FISCAIS] INF
INNER JOIN [TABELA DE PRODUTOS] TP
ON INF.[CODIGO DO PRODUTO] = TP.[CODIGO DO PRODUTO]
INNER JOIN [NOTAS FISCAIS] NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA) = 2016
GROUP BY YEAR(NF.DATA)) AUX2
ON AUX1.ANO = AUX2.ANO
ORDER BY AUX1.FATURAMENTO DESC


