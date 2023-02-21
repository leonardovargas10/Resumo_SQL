
CREATE DATABASE SUCOS_VENDAS_01

CREATE DATABASE SUCOS_VENDAS_02
ON (NAME = SUCOS_VENDAS_DAT, FILENAME = "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SALES_VENDAS_02.MDF", SIZE = 10, MAXSIZE = 50, FILEGROWTH = 5)
LOG ON (NAME = SUCOS_VENDAS_LOG, FILENAME = "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SALES_VENDAS_02.LDF", SIZE = 10, MAXSIZE = 50, FILEGROWTH = 5)

DROP DATABASE SUCOS_VENDAS_01
DROP DATABASE SUCOS_VENDAS_02