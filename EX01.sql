CREATE DATABASE EX01
GO

USE EX01
GO

CREATE TABLE Aluno (
	RA int PRIMARY KEY NOT NULL,
	Nome varchar (20) NOT NULL,
	Sobrenome varchar (20) NOT NULL,
	Rua varchar (100) NOT NULL,
	Nº int NOT NULL,
	Bairro varchar (30),
	CEP int NOT NULL,
	Telefone int ,
	)
GO

CREATE TABLE Cursos (
	Codigo int NOT NULL,
	Nome varchar (15) NOT NULL,
	Carga_Horario int NOT NULL,
	Turno varchar (5) NOT NULL
	)
GO

CREATE TABLE Disciplina (
	Codigo int NOT NULL,
	Nome varchar (30) NOT NULL,
	Carga_Horario int NOT NULL,
	Turno varchar (5) NOT NULL,
	Semestre int NOT NULL,
)
GO

INSERT INTO Aluno VALUES ('12345', 'José', 'Silva', 'Almirante Noroha', '236', 'Jardim São Paulo', '1589000', '69875287')
GO

INSERT INTO Cursos VALUES ('1', 'Informática', '2800', 'Tarde')
GO

INSERT INTO Disciplina VALUES ('1', 'Informática', '4', 'Tarde', '1')
GO

--Nome e sobrenome, como nome completo dos Alunos Matriculados
SELECT Nome + ' ' +Sobrenome AS Nome_Completo FROM Aluno

--Rua, nº , Bairro e CEP como Endereço do aluno que não tem telefone
SELECT Rua, Bairro, CEP FROM Aluno WHERE  Telefone IS NULL

--Telefone do aluno com RA 12348
SELECT Telefone FROM Aluno WHERE RA = 12348

--Nome e Turno dos cursos com 2800 horas
SELECT Nome, Turno FROM Cursos WHERE Carga_Horario = 2800

--O semestre do curso de Banco de Dados I noite
SELECT Semestre FROM Disciplina Where Nome LIKE 'Banco%' AND Turno LIKE 'Noite'  

SELECT * FROM Aluno
SELECT * FROM Cursos
SELECT * FROM Disciplina