CREATE DATABASE EX03
GO

USE EX03
GO

CREATE TABLE Paciente(
	CPF char(12)  NOT NULL,
	Nome varchar (30) NOT NULL,
	Rua varchar (60) NOT NULL,
	Nº int NOT NULL,
	Bairro varchar (50) NOT NULL,
	Telefone varchar (9),
	Data_nasc date NOT NULL,
	PRIMARY KEY(CPF)
)

CREATE TABLE Medico(
	Codigo int  NOT NULL,
	Nome varchar (30) NOT NULL,
	Especialidade varchar (20) NOT NULL,
	PRIMARY KEY(Codigo)
)

CREATE TABLE Prontuario(
	Data_prontu date NOT NULL,
	CPF_paciente char(12)  NOT NULL,
	Codigo_medico int NOT NULL,
	Diagnostico varchar (50) NOT NULL,
	Medicamento varchar (50) NOT NULL,
	PRIMARY KEY (Data_prontu, CPF_paciente, Codigo_medico),
	FOREIGN KEY (CPF_paciente) REFERENCES Paciente(CPF),
	FOREIGN KEY (Codigo_medico) REFERENCES Medico(Codigo)
)

INSERT INTO Paciente VALUES ('35454562890',	'José Rubens', 'Campos Salles',  2750, 'Centro', '2145-0998', '18/10/1954'),
('29865439810',	 'Ana Claudia', 'Sete de Setembro', 178,	 'Centro', '9738-2764',	'29/05/1960'),
('82176534800', 'Marcos Aurélio', 'Timóteo Penteado', 236,	 'Vila Galvão', '6817-2651', '24/09/1980'),
('12386758770',  'Maria Rita',  'Castello Branco'	, 7765,	'Vila Rosália', NULL,	'30/03/1975'),
('92173458910',	 'Joana de Souza',	'XV de Novembro', 298,	 'Centro',	'2127-6578', '24/04/1944')

INSERT INTO Prontuario VALUES ('10/09/2020', '35454562890',	2,	'Reumatismo', 'Celebra'),
('10/09/2020', '92173458910', 2, 'Renite Alérgica', 'Allegra'),
('12/09/2020', '29865439810', 1, 'Inflamação de garganta', 'Nimesulida'),
('13/09/2020', '35454562890', 2, 'H1N1', 'Tamiflu'),
('15/09/2020', '82176534800', 4, 'Gripe', 'Resprin'),
('15/09/2020', '12386758770', 3, 'Braço Quebrado', 'Dorflex + Gesso')

--Consultar:
--Nome e Endereço (concatenado) dos pacientes com mais de 50 anos
SELECT Nome, Rua + ' ' + 'Nº' + CAST( Nº AS varchar(10)) + ' ' + Bairro  AS Endereço FROM Paciente 
WHERE DATEDIFF (year, Data_nasc, GETDATE()) >= 50

--Qual a especialidade de Carolina Oliveira
SELECT Especialidade FROM Medico WHERE Nome LIKE 'Carolina Oliveira'

--Qual medicamento receitado para reumatismo
SELECT Medicamento FROM Prontuario WHERE Diagnostico LIKE 'Reumatismo' 

--Consultar em subqueries:
--Diagnóstico e Medicamento do paciente José Rubens em suas consultas
SELECT Prontuario.Diagnostico, Prontuario.Medicamento FROM Prontuario INNER JOIN Paciente 
ON  Prontuario.CPF_paciente = Paciente.CPF WHERE Nome LIKE 'José%'

--Nome e especialidade do(s) Médico(s) que atenderam José Rubens. 
--Caso a especialidade tenha mais de 3 letras, mostrar apenas as 3 primeiras letras concatenada com um ponto final (.)
SELECT Medico.Nome, SUBSTRING(Medico.Especialidade, 1, 3) + '.' AS Especialidade FROM Medico INNER JOIN Prontuario 
ON Medico.Codigo = Prontuario.Codigo_medico INNER JOIN Paciente 
ON Paciente.CPF = Prontuario.CPF_paciente WHERE Paciente.Nome LIKE 'José%' 

--CPF (Com a máscara XXX.XXX.XXX-XX), Nome, Endereço completo (Rua, nº - Bairro), 
--Telefone (Caso nulo, mostrar um traço (-)) dos pacientes do médico Vinicius
SELECT Paciente.Nome, SUBSTRING(Paciente.CPF,  1, 3) + '.' + SUBSTRING(Paciente.CPF,  4, 3)
+ '.' + SUBSTRING(Paciente.CPF,  5, 3) + '-' + SUBSTRING(Paciente.CPF,  7, 2) 
AS CPF, (Rua + ' ' + CAST( Nº AS varchar(10)) + ' ' + Bairro) AS Endereço, Telefone FROM Paciente INNER JOIN Prontuario
ON Paciente.CPF = Prontuario.CPF_paciente INNER JOIN Medico ON Medico.Codigo = Prontuario.Codigo_medico
WHERE Medico.Nome LIKE 'Vinicius%'

--Quantos dias fazem da consulta de Maria Rita até hoje
SELECT DATEDIFF (day, Data_prontu, GETDATE()) As Dias_sem_retorno FROM Prontuario INNER JOIN Paciente
ON Prontuario.CPF_paciente  = Paciente.CPF WHERE Paciente.Nome LIKE 'Maria%'

--Alterar o telefone da paciente Maria Rita, para 98345621
UPDATE Paciente SET Telefone = 98345621 WHERE Nome LIKE 'Maria%'
SELECT Nome, Telefone FROM Paciente WHERE Nome LIKE 'Maria%'

--Alterar o Endereço de Joana de Souza para Voluntários da Pátria, 1980, Jd. Aeroporto
UPDATE Paciente SET Rua = 'Voluntários da Pátria', Nº = 1980, Bairro = 'Jd. Aeroporto'
WHERE Nome LIKE 'Joana%'
SELECT Nome,	Rua + ' ' + 'Nº' + CAST( Nº AS varchar(10)) + ' ' + Bairro  AS Endereço FROM Paciente
WHERE Nome LIKE 'Joana%'

SELECT * FROM Paciente
SELECT * FROM Medico
SELECT * FROM Prontuario