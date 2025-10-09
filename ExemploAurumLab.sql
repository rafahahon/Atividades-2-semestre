CREATE DATABASE AurumLab;

USE AurumLab;

CREATE TABLE Regra (
	IdRegra INT IDENTITY(1, 1) PRIMARY KEY,
	Nome NVARCHAR(40) NOT NULL UNIQUE
);
GO

CREATE TABLE Usuario (
	IdUsuario		INT IDENTITY(1,1) PRIMARY KEY,
	NomeCompleto	NVARCHAR(200) NOT NULL,
	Email			NVARCHAR(20) NOT NULL UNIQUE,
	Senha			VARBINARY(32) NOT NULL, -- Armazena a hash da senha
	FotoURL			NVARCHAR(500) NULL, -- Armazena caminho da URL da imagem
	CriadoEm		DATETIME2(0) NOT NULL DEFAULT DATEADD(HOUR, -3, SYSUTCDATETIME()),
	-- Zero casas decimais de segundo
	RegraId			INT NOT NULL,
	CONSTRAINT FK_Usuario_Regra FOREIGN KEY (RegraId) REFERENCES Regra(IdRegra)
);
GO