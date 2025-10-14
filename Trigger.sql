USE VendasOnline;

-- Triggers

-- Trigger 1: Auditoria clientes inseridos
CREATE TABLE Auditoria_Cliente (
	AuditoriaId INT IDENTITY PRIMARY KEY,
	ClienteId INT FOREIGN KEY REFERENCES Cliente(ClienteId),
	DataInsercao DATE
);

CREATE TRIGGER trg_AuditoriaCliente
ON Cliente -- tabela que vai disparar a trigger
AFTER INSERT 
AS 
BEGIN
	SET NOCOUNT ON
	INSERT Auditoria_Cliente (ClienteId, DataInsercao) -- toda vez q fiz um insert em cliente, vai fazer o mesmo insert na auditoria
	SELECT ClienteId, DATEADD(HOUR, -3, SYSUTCDATETIME())
	FROM inserted
	-- armazena insert e update de forma temporaria
END

-- testando trigger
INSERT INTO Cliente(Nome, Sobrenome, Email, Telefone, DataCadastro)
VALUES ('Carlos', 'Pereira', 'carlos@gmail.com', '1199999339', '2025-10-14')

SELECT * FROM Cliente;
SELECT * FROM Auditoria_Cliente;

-- Trigger 2: Atualizar estoque ao inserir um pedido
CREATE TRIGGER trg_AtualizarEstoque
ON DetalhesPedido
AFTER INSERT 
AS
BEGIN
	SET NOCOUNT ON
	UPDATE Produto
		SET QuantidadeEstoque = QuantidadeEstoque - i.Quantidade
		FROM Produto p
		JOIN inserted i ON p.ProdutoID = i.ProdutoID
END

-- testando trigger
SELECT * FROM Produto;
SELECT * FROM DetalhesPedido;

INSERT INTO DetalhesPedido (PedidoID, ProdutoID, Quantidade, PrecoUnitario)
VALUES (1, 2, 3, 75.00)

-- Trigger 3: Prevenir exclusao de produto com pedido
CREATE TRIGGER trg_PrevenirExclusaoProduto
ON Produto
INSTEAD OF DELETE -- ao inves de deletar (pode ser insert ou update)
AS 
BEGIN
	SET NOCOUNT ON
	IF EXISTS (
		SELECT 1
			FROM DetalhesPedido dp
			JOIN deleted d ON dp.ProdutoID = d.ProdutoID
	)
	BEGIN 
		RAISERROR('Não é possível excluir produto com pedidos associados.', 16, 1)
		-- codigo de erro do usuario
	END

	DELETE FROM Produto 
	WHERE ProdutoId IN (SELECT ProdutoID FROM deleted)
END

-- Testando trigger
DELETE FROM Produto WHERE ProdutoID = 2 -- tem que dar erro caso houver produto associado ao pedido

SELECT * FROM Produto;
SELECT * FROM DetalhesPedido;

-- Trigger 4: Cria log de funcionarios
CREATE TABLE Funcionario (
	FuncionarioId INT IDENTITY PRIMARY KEY,
	Nome VARCHAR(100),
	CPF VARCHAR(14) UNIQUE
);

CREATE TABLE LogFuncionario (
	LogId INT IDENTITY PRIMARY KEY,
	FuncionarioId INT FOREIGN KEY REFERENCES Funcionario(FuncionarioId),
	Nome VARCHAR(100),
	DataCadastro DATETIME2(0) DEFAULT DATEADD(HOUR, -3, SYSUTCDATETIME())
);

CREATE TRIGGER trg_LogFuncionario
ON Funcionario
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO LogFuncionario(FuncionarioId, Nome)
	SELECT FuncionarioId, Nome FROM inserted
END

-- Testando trigger
INSERT INTO Funcionario  (Nome, CPF)
VALUES ('Rafaella', '3243252332')

SELECT * FROM Funcionario;
SELECT * FROM LogFuncionario;