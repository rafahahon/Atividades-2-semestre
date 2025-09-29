-- DDL - Linguagem de definição de dados

-- APAGAR BASE DE DADOS (caso exista)
DROP DATABASE Clinica_Medica;

-- CRIAR BASE DE DADOS (Clinica médica)
CREATE DATABASE Clinica_Medica;
GO

USE Clinica_Medica;
GO

-- TABELA PACIENTE
CREATE TABLE Paciente(
	CPF VARCHAR(14) PRIMARY KEY,
	Nome VARCHAR(40),
	Telefone VARCHAR(30),
	NumeroPlano INT,
	NomePlano VARCHAR(20),
	TipoPlano VARCHAR(10)
);
GO

-- TABELA MEDICO
CREATE TABLE Medico(
	CRM INT PRIMARY KEY,
	NomeMedico VARCHAR(30),
	Especialidade VARCHAR(20)
);
GO

-- TABELA CONSULTA
CREATE TABLE Consulta (
	NumeroConsulta INT PRIMARY KEY IDENTITY(100, 1), -- (valor inicial, incremento)
	DataConsulta DATE,
	HorarioConsulta TIME,
	CRM_Medico INT FOREIGN KEY REFERENCES Medico(CRM),
	CPF_Paciente VARCHAR(14) FOREIGN KEY REFERENCES Paciente(CPF)
);
GO

SELECT * FROM Paciente;
SELECT * FROM Medico;
SELECT * FROM Consulta;

-- 1 - Inserindo valores na tabela paciente
INSERT INTO Paciente VALUES
('87889001232', 'Robson', '987234231', 1, 'Profit', 'Básico'),
('34334545697', 'Julia', '987454231', 2, 'Luxo', 'Premium'),
('67889001232', 'Emerson', '987237231', 3, 'Profit', 'Básico'),
('77889001232', 'Eduardo', '987534291', 4, 'Luxo', 'Premium'),
('97879531232', 'Pedro', '988224231', 5, 'Profit', 'Básico'),
('17809067232', 'Marcia', '982254281', 6, 'Luxo', 'Premium')
GO

-- 2 - Inserindo dados na tabela medico
INSERT INTO Medico VALUES
(3465, 'Kleber', 'Oftalmologia'),
(4342, 'Erick', 'Anestesiologia'),
(8656, 'Rebeca', 'Pediatria'),
(7676, 'Cynthia', 'Cardiologia'),
(9567, 'Katia', 'Urologia')
GO

-- 3 - Criando consultas
INSERT INTO Consulta VALUES
('2025-09-29', '15:35:00', 8656, '67889001232'),
('2025-10-29', '17:00:00', 3465, '77889001232'),
('2025-09-30', '16:40:00', 9567, '34334545697'),
('2025-10-03', '14:20:00', 4342, '97879531232'),
('2025-10-19', '13:30:00', 7676, '17809067232'),
('2025-10-13', '10:30:00', 7676, '87889001232')
GO

-- 4 - Listando pacientes cadastrados
SELECT * FROM Paciente;
GO

-- 5 - Listando todos os médicos e suas especialidades
SELECT NomeMedico, Especialidade FROM Medico;
GO

-- 6 - Listando as consultas
SELECT * FROM Consulta;
GO

-- 7 - Listando consulta pelo cpf do paciente
SELECT * FROM Consulta
WHERE CPF_Paciente = '87889001232';
GO

-- 8 - Listando consulta pelo crm do medico
SELECT * FROM Consulta
WHERE CRM_Medico = 7676;
GO

-- 9 - Atualizando o numero do plano de 3 pacientes
UPDATE Paciente SET NumeroPlano = 22
Where NumeroPlano = 1; 
GO

UPDATE Paciente SET NumeroPlano = 23
Where NumeroPlano = 2; 
GO

UPDATE Paciente SET NumeroPlano = 24
Where NumeroPlano = 3; 
GO

SELECT * FROM Paciente;
GO

-- 10 - Deletando 2 pacientes 
DELETE FROM Consulta
WHERE CPF_Paciente = '21338749697';
GO

DELETE FROM Consulta
WHERE CPF_Paciente = '67889001232';
GO

DELETE FROM Paciente
WHERE CPF = '21338749697';
GO

DELETE FROM Paciente
WHERE CPF = '67889001232';
GO

SELECT * FROM Paciente;
GO

-- 11 - Cadastrando mais medicos e pacientes
INSERT INTO Medico VALUES
(2345, 'Robert', 'Oftalmologia'),
(5594, 'Rita', 'Oftalmologia'),
(2290, 'Antonia', 'Pediatria')
GO

INSERT INTO Paciente VALUES
('56842001232', 'Wellington', '947436278', 7, 'Profit', 'Básico'),
('21338749697', 'Gleide', '946424635', 8, 'Luxo', 'Premium')
GO

-- 12 - Atualizando especialidades dos medicos
UPDATE Medico SET Especialidade = 'Radiologia '
Where Especialidade = 'Oftalmologia'; 
GO

UPDATE Medico SET Especialidade = 'Traumatologia'
Where Especialidade = 'Pediatria'; 
GO

SELECT * FROM Medico;