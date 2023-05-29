CREATE DATABASE EX02
GO

USE EX02
GO

CREATE TABLE Carro (
	Placa varchar (7)  PRIMARY KEY NOT NULL,
	Marca varchar (30) NOT NULL,
	Modelo varchar (25) NOT NULL,
	Cor varchar (20) NOT NULL,
	Ano int NOT NULL
)
GO

CREATE TABLE Cliente (
	Nome varchar (30) PRIMARY KEY NOT NULL,
	Logradouro varchar (50) NOT NULL,
	Nº int NOT NULL,
	Bairro varchar (30),
	Telefone varchar (9) NOT NULL,
	Carro varchar (7) FOREIGN KEY REFERENCES Carro(Placa) NOT NULL
)
GO

CREATE TABLE Peças (
	Codigo int PRIMARY KEY NOT NULL,
	Nome varchar (30) NOT NULL,
	Valor decimal (7, 2) NOT NULL
)
GO

CREATE TABLE Serviços (
	Carro varchar (7) FOREIGN KEY REFERENCES Carro(Placa) NOT NULL,
	Peça int FOREIGN KEY REFERENCES Peças(codigo) NOT NULL,
	Quantidade int NOT NULL,
	Valor decimal (7, 2) NOT NULL,
	Data_Serviço Date NOT NULL,
	PRIMARY KEY (Carro, Peça, Data_Serviço)
)
GO

INSERT INTO Carro VALUES ('AFT9087', 'VW', 'Gol', 'Preto', 2007), 
('DXO9875', 'Ford', 'Ka', 'Azul', 2000),
('EGT4631', 'Renault', 'Clio', 'Verde', 2004),
('LKM7380', 'Fiat', 'Palio', 'Prata', 1997),
('BCD7521', 'Ford', 'Fiesta', 'Preto', 1999) 
GO

INSERT INTO Cliente VALUES ('João Alves', 'R. Pereira Barreto', 1258, 'Jd. Oliveiras', '2154-9658', 'DXO9875'),
('Ana Maria', 'R. 7 de Setembro', 259, 'Centro', '9658-8541', 'LKM7380'),
('Clara Oliveira', 'Av. Nações Unidas', 10254, 'Pinheiros', '2458-9658', 'EGT4631'),
('José Simões', 'R. XV de Novembro', 36, 'Água Branca', '7895-2459', 'BCD7521'),
('Paula Rocha', 'R. Anhaia', 548, 'Barra Funda', '6958-2548', 'AFT9087') 
GO

INSERT INTO Peças VALUES (1, 'Vela', 70.00),
(2, 'Correia Dentada', 125.00),
(3, 'Trambulador', 90.00),
(4, 'Filtro de Ar', 30.00)
GO

INSERT INTO Serviços VALUES ('DXO9875', 1, 4, 280, '8/1/2020'),
('DXO9875', 4, 1, 30, '8/1/2020'),
('EGT4631', 3, 1, 90, '8/2/2020'),
('DXO9875', 2, 1, 125, '8/7/2020')
GO

--Consultar em Subqueries:
--Telefone do dono do carro Ka, Azul
SELECT Telefone FROM Cliente WHERE Carro IN (
SELECT distinct Placa FROM Carro WHERE Modelo LIKE 'Ka' AND Cor LIKE 'Azul' )

--Endereço concatenado do cliente que fez o serviço do dia 02/08/2009
SELECT Logradouro + ' ' + Nº + ' ' +  Bairro  AS Endereço FROM  Cliente WHERE Carro IN (
SELECT distinct Carro FROM Serviços WHERE Data_Serviço = '2009-08-02')

--Consultar:
--Placas dos carros de anos anteriores a 2001
SELECT Placa FROM Carro WHERE Ano < 2001

--Marca, modelo e cor, concatenado dos carros posteriores a 2005
SELECT Marca, Modelo, Cor FROM Carro WHERE Ano > 2005

--Código e nome das peças que custam menos de R$80,00
SELECT Codigo, Nome FROM Peças WHERE Valor < 80.00

SELECT * FROM Cliente
SELECT * FROM Carro
SELECT * FROM Peças
SELECT * FROM Serviços