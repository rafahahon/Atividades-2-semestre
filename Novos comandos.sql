DROP DATABASE Loja;

CREATE DATABASE Loja;

USE Loja;

CREATE TABLE Cliente(
	ClienteID INT IDENTITY(100, 1),
	Nome NVARCHAR(100) NOT NULL, -- NOT NULL obriga a pessoa a escrever um valor
	Email NVARCHAR(100) UNIQUE, -- UNIQUE nao permite a repeticao
	CONSTRAINT Pk_Cliente PRIMARY KEY (ClienteId) -- Declarando a primary key com um nome definido (pk = primary key)
);

CREATE TABLE Pedido(
	PedidoId INT IDENTITY(100, 1),
	DataPedido DATE NOT NULL,
	Valor DECIMAL(10, 2), -- Pode ter 10 numeros e 2 sao depois da virgula
	ClienteId INT, 
	CONSTRAINT Pk_Pedido PRIMARY KEY (PedidoId),
	CONSTRAINT Fk_Pedido FOREIGN KEY (ClienteId)
	REFERENCES Cliente(ClienteId) -- ON DELETE CASCADE para deletar um cliente que ja tem um pedido (fk = foreign key)
);

INSERT INTO Cliente VALUES -- (NOME, EMAIL)
('Rafaella Hahon', 'rafhon@senai.com'),
('Mayara Almeida', 'maymay@senai.com'),
('Julia Franca', 'juju@senai.com')

INSERT INTO Pedido VALUES -- (DataPedido, Valor, ClienteId)
('2025-10-01', '344.80', 100),
('2025-10-02', '100.80', 100),
('2025-10-03', '55.00', 101)

SELECT * FROM Cliente;
SELECT * FROM Pedido;

-- Ajustar email de cliente
UPDATE Cliente SET Email = 'rafon@senai.com'
WHERE ClienteID = 100;

-- Atualizar o valor de um pedido 
SELECT * FROM Pedido; -- Exibe a tabela antes da mudanca
UPDATE Pedido SET Valor = Valor + '4.99'
WHERE PedidoId = 101;
SELECT * FROM Pedido; -- Exibe a tabela depois da mudanca

-- Renomear a tabela Cliente para Funcionario
EXEC sp_rename 'Cliente', 'Funcionario';
SELECT * FROM Funcionario;

-- Renomear a coluna ClienteId -> FuncionarioId
EXEC sp_rename 'Funcionario.ClienteId', 'FuncionarioId', 'COLUMN'

-- Alterar tamanho do tipo de dado
ALTER TABLE Funcionario
ALTER COLUMN Nome NVARCHAR(150) NOT NULL;

-- Ver a estrutura da tabela
EXEC sp_help 'Funcionario';

-- Deletar um funcionario
DELETE Funcionario
WHERE FuncionarioId = 100;

-- Apagando a chave primaria da tabela Pedido
ALTER TABLE Pedido
DROP CONSTRAINT Pk_Pedido;

-- Recriando a chave primaria
ALTER TABLE Pedido
ADD CONSTRAINT Pk_Pedido PRIMARY KEY (PedidoId);

-- Alterando tabela Pedido
-- ON DELETE CASCADE, quando apagar um funcionario, vai apagar tambem o pedido linkado com o funcionario
ALTER TABLE Pedido
DROP CONSTRAINT Fk_Pedido

-- Recriar FK com ON DELETE CASCADE
ALTER TABLE Pedido
ADD CONSTRAINT FK_Pedido_Cliente
FOREIGN KEY (ClienteId) REFERENCES Funcionario(FuncionarioId)
ON DELETE CASCADE

SELECT * FROM Funcionario;
SELECT * FROM Pedido;

-- Deletar um funcionario
DELETE Funcionario
WHERE FuncionarioId = 100;

-- Adicionar novas colunas 
ALTER TABLE Funcionario
ADD Cargo NVARCHAR(50);