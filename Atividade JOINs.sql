-- Criar base de dados Locadora de carros
CREATE DATABASE LocadoraDeCarros;
GO

-- Entra na base
USE LocadoraDeCarros;
GO

-- Criando tabelas
CREATE TABLE Agencia(
	IdAgencia INT,
	Nome NVARCHAR(30) UNIQUE,
	CONSTRAINT Pk_Agencia PRIMARY KEY (IdAgencia)
);
GO

CREATE TABLE Carro(
	IdCarro INT,
	Placa NVARCHAR(10) UNIQUE,
	CONSTRAINT Pk_Carro PRIMARY KEY (IdCarro),
	IdAgencia INT,
	CONSTRAINT Fk_Carro_Agencia FOREIGN KEY (IdAgencia)
	REFERENCES Agencia(IdAgencia)
);
GO

CREATE TABLE Cliente(
	IdCliente INT,
	Nome NVARCHAR(20),
	CNH NVARCHAR(20) UNIQUE,
	CONSTRAINT Pk_Cliente PRIMARY KEY (IdCliente)
);
GO

CREATE TABLE Locacao(
	IdLocacao INT,
	IdCarro INT,
	CONSTRAINT Fk_Carro_Locacao FOREIGN KEY (IdCarro)
	REFERENCES Carro(IdCarro),
	IdCliente INT,
	CONSTRAINT Fk_Cliente_Locacao FOREIGN KEY (IdCliente)
	REFERENCES Cliente(IdCliente),
	Retirada DATE,
	Devolucao DATE,
	CONSTRAINT Pk_Locacao PRIMARY KEY (IdLocacao)
);
GO

-- Populando as tabelas
INSERT INTO Agencia VALUES
(5542, 'CarLeave'),
(2343, 'CarPull'),
(4565, 'StaySafe')
GO

INSERT INTO Carro VALUES
(23, 'BZN-0069', 2343),
(26, 'CTQ-9086', 4565),
(32, 'EDU-1180', 4565),
(34, 'FEH-3253', 5542),
(56, 'BXJ-2650', 2343)
GO

INSERT INTO Cliente VALUES
(27, 'Breno Gomes', '40675518964'),
(88, 'Mel Alves', '39453321500'),
(103, 'Pedro Silva', '16937916922'),
(205, 'Bruno Carvalho', '10634867767'),
(347, 'Rebeca Lima', '93803597614')
GO

INSERT INTO Locacao VALUES 
(1, 56, 103, '2025-09-30', '2025-10-02'),
(2, 26, 347, '2025-09-30', '2025-10-06'),
(3, 23, 205, '2025-09-30', '2025-10-20'),
(4, 34, 27, '2025-10-20', '2025-10-25'),
(5, 32, 88, '2025-10-30', '2025-11-05')
GO

SELECT * FROM Agencia;
SELECT * FROM Carro;
SELECT * FROM Cliente;
SELECT * FROM Locacao;

-- Join
-- INNER JOIN
SELECT l.IdLocacao, l.Retirada, l.Devolucao, c.Nome AS Nome, ca.Placa
FROM Locacao l
INNER JOIN Cliente c ON c.Nome = c.Nome
INNER JOIN Carro ca ON ca.Placa = ca.Placa;

--LEFT JOIN
SELECT c.Nome as Nome, ca.Placa, l.Retirada
FROM Cliente c
LEFT JOIN Carro ca ON ca.Placa = ca.Placa
LEFT JOIN Locacao l ON l.Retirada = l.Retirada;

--RIGHT JOIN
SELECT ca.IdCarro, ca.Placa, c.Nome AS NomeCliente
FROM Locacao l
RIGHT JOIN Carro ca ON ca.Placa = ca.Placa
LEFT JOIN Cliente c ON c.Nome = c.Nome;

--FULL JOIN
SELECT c.Nome AS NomeCLiente, a.IdAgencia, ca.Placa, l.Retirada
FROM Cliente c
FULL JOIN Agencia a ON a.IdAgencia = a.IdAgencia
FULL JOIN Carro ca ON ca.Placa = ca.Placa
FULL JOIN Locacao l ON l.Retirada = l.Retirada;

--CROSS JOIN
SELECT c.Nome AS NomeCLiente, ca.IdCarro, ca.Placa
FROM Cliente c
CROSS JOIN Carro ca;

-- Utilizando novos comandos
-- Atualizando atributo especifico
UPDATE Agencia SET Nome = 'CarPark'
WHERE IdAgencia = 4565;

-- Alterando tamanho do tipo de dado
ALTER TABLE Agencia
ALTER COLUMN Nome NVARCHAR(50);

-- Adicionando nova coluna 
ALTER TABLE Locacao
ADD Valor DECIMAL(10, 2);

-- Atualizando valores
UPDATE Locacao SET Valor = '109.90'
WHERE IdLocacao = 1;

-- Renomeando uma coluna
EXEC sp_rename 'Locacao.IdCliene', 'IdCliente', 'COLUMN'

-- Apagando a chave primaria da tabela Locacao
ALTER TABLE Locacao
DROP CONSTRAINT Pk_Locacao;

-- Recriando a chave primaria
ALTER TABLE Locacao
ADD CONSTRAINT Pk_Locacao PRIMARY KEY (IdLocacao);

-- Alterando tabela Carro (criando e recriando fk e pk, removendo restricoes para deletar)
-- ON DELETE CASCADE
-- Removendo FK
ALTER TABLE Carro
DROP CONSTRAINT Fk_Carro_Agencia

ALTER TABLE Locacao
DROP CONSTRAINT Fk_Carro_Locacao;

-- Recriando FK com ON DELETE CASCADE
ALTER TABLE Carro
ADD CONSTRAINT Fk_Carro_Agencia
FOREIGN KEY (IdAgencia) REFERENCES Agencia(IdAgencia)
ON DELETE CASCADE

ALTER TABLE Locacao
ADD CONSTRAINT Fk_Carro_Locacao
FOREIGN KEY (IdCarro) REFERENCES Carro(IdCarro)
ON DELETE CASCADE

SELECT * FROM Carro;
DELETE Carro
WHERE IdCarro = 23;
SELECT * FROM Carro;

-- Selects
SELECT * FROM Agencia;
SELECT * FROM Carro;
SELECT * FROM Cliente;
SELECT * FROM Locacao;