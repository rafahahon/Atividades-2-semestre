-- DDL - Linguagem de definição de dados

-- Apagar base de dados (caso exista)
DROP DATABASE Clinica_Medica;

-- Criar base de dados (Clínica médica)
CREATE DATABASE Clinica_Medica;
GO -- Executa comandos na ordem

USE Clinica_Medica;
GO

-- Tabela paciente
CREATE TABLE Paciente(
	CPF VARCHAR(14) PRIMARY KEY,
	Nome VARCHAR(40),
	Telefone VARCHAR(30),
	NumeroPlano INT,
	NomePlano VARCHAR(20),
	TipoPlano Varchar(10)
);
GO

-- Tabela médico
CREATE TABLE Medico(
	CRM INT PRIMARY KEY,
	NomeMedico VARCHAR(30),
	Especialidade VARCHAR(20)
);
GO

-- Tabela consulta
CREATE TABLE Consulta(
	NumeroConsulta INT PRIMARY KEY IDENTITY(100, 1), -- Identity faz com que o banco autoincremente um valor de 1 em 1 ou pode colocar um valor especifico entre (valor inicial, incremento)
	DataConsulta DATE,
	HorarioConsulta TIME,
	CRM_Medico INT FOREIGN KEY REFERENCES Medico(CRM), -- Para puxar uma chave estrangeira
	CPF_Paciente VARCHAR(14) FOREIGN KEY REFERENCES Paciente(CPF)
);
GO

SELECT * FROM Paciente;
SELECT * FROM Medico;
SELECT * FROM Consulta;