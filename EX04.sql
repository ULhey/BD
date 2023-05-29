CREATE DATABASE EX04
GO

USE EX04
GO

CREATE TABLE Cliente(
	CPF char(12)  NOT NULL,
	Nome varchar (50) NOT NULL,
	Telefone varchar(9) NOT NULL,
	PRIMARY KEY (CPF)
)
GO

CREATE TABLE Fornecedor(
	ID int  NOT NULL,
	Nome varchar (50) NOT NULL,
	Logradouro varchar (60) NOT NULL,
	Nº int NOT NULL,
	Complemento varchar (30) NOT NULL,
	Cidade varchar (30) NOT NULL
	PRIMARY KEY (ID)
)
GO

CREATE TABLE Produto(
	Codigo int  NOT NULL,
	Descrição varchar (60) NOT NULL,
	Fornecedor int,
	Preço decimal (7, 2) NOT NULL,
	PRIMARY KEY (Codigo),
	FOREIGN KEY (Fornecedor) REFERENCES Fornecedor(ID)
)
GO

CREATE TABLE Venda(
	Codigo int NOT NULL,
	Produto int NOT NULL,
	Cliente char(12) NOT NULL,
	Quantidade int NOT NULL,
	Valor_Total decimal (7, 2) NOT NULL,
	Data_venda date NOT NULL,
	PRIMARY KEY (Codigo, Produto, Cliente),
	FOREIGN KEY (Produto) REFERENCES Produto(Codigo),
	FOREIGN KEY (Cliente) REFERENCES Cliente(CPF)
)
GO

INSERT INTO Cliente VALUES('345789092-90', 'Julio Cesar', '8273-6541')
INSERT INTO Fornecedor VALUES(1,	'LG',	'Rod. Bandeirantes', 70000, 'Km 70', 'Itapeva')
INSERT INTO Produto VALUES(1, 'Monitor 19 pol.', 1, 449.99)
INSERT INTO Venda VALUES(1, 1, '251865337-10', 1, 449.99, '03/09/2009')

--Consultar no formato dd/mm/aaaa: Data da Venda 4
SELECT CONVERT(char(10), Data_venda, 103) AS Data_formatada FROM Venda WHERE Codigo = 4

--Inserir na tabela Fornecedor, a coluna Telefone e os seguintes dados:
--1	7216-5371
--2	8715-3738
--4	3654-6289
ALTER TABLE Fornecedor ADD Telefone varchar(9)
UPDATE Fornecedor SET Telefone = '7216-5371' WHERE ID = 1
UPDATE Fornecedor SET Telefone = '8715-3738' WHERE ID = 2
UPDATE Fornecedor SET Telefone = '3654-6289' WHERE ID = 4
SELECT * FROM Fornecedor

--Consultar por ordem alfabética de nome, o nome, o enderço concatenado e o telefone dos fornecedores
SELECT Nome, Logradouro + ' ' + 'Nº' + CAST( Nº AS varchar(10))  + ' ' + Complemento  + ' ' + Cidade AS Endereço, Telefone 
FROM Fornecedor ORDER BY Nome

--Consultar:
--Produto, quantidade e valor total do comprado por Julio Cesar
SELECT Venda.Produto, Venda.Quantidade, Venda.Valor_Total FROM Venda INNER JOIN Cliente ON Venda.Cliente = Cliente.CPF
WHERE Cliente.Nome LIKE 'Julio Cesar'

--Data, no formato dd/mm/aaaa e valor total do produto comprado por  Paulo Cesar
SELECT CONVERT(char(10), Data_venda, 103) AS Data_venda, Valor_Total FROM Venda INNER JOIN Cliente 
ON Venda.Cliente = Cliente.CPF WHERE Cliente.Nome LIKE 'Paulo Cesar'

--Consultar, em ordem decrescente, o nome e o preço de todos os produtos 
SELECT Descrição, preço FROM Produto ORDER BY Descrição, preço DESC

SELECT * FROM Cliente
SELECT * FROM Produto
SELECT * FROM Fornecedor
SELECT * FROM Venda