-- PROCEDURES

USE VendasOnline;

-- Procedure 1: Inserir clientes
CREATE PROCEDURE InserirCliente
	@Nome VARCHAR(50),
	@Sobrenome VARCHAR(50),
	@Email VARCHAR(100),
	@Telefone VARCHAR(20),
	@DataCadastro DATE
AS
BEGIN
	SET NOCOUNT ON; -- nao mostra informacao de linhas afetadas
	INSERT INTO Cliente(Nome, Sobrenome, Email, Telefone, DataCadastro)
	VALUES (@Nome, @Sobrenome, @Email, @Telefone, @DataCadastro)
END

-- Testando procedure 
EXEC InserirCliente 'Ana', 'Lima', 'analima@gmail.com', '1199998999', '2025-10-14'

SELECT * FROM Cliente;

-- Procedure 2: Inserir pedido
CREATE PROCEDURE InserirPedido
	@ClientID INT,
	@DataPedido DATE,
	@ValorTotal DECIMAL(10, 2),
	@StatusID INT
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO Pedido (ClienteID, DataPedido, ValorTotal, StatusID)
	VALUES (@ClientID, @DataPedido, @ValorTotal, @StatusID)
END

-- Testando procedure 
EXEC InserirPedido 2, '2025-10-13', 250.00, 1;

SELECT * FROM Pedido;

-- Procedure 3: Atualizar preco de produto
CREATE PROCEDURE AtualizarPrecoProduto
	@ProdutoId INT,
	@PercentualAumento DECIMAL(5,2)
AS
BEGIN
	SET NOCOUNT ON
	UPDATE Produto
		SET Preco = Preco * (1 + @PercentualAumento / 100.0)
	WHERE ProdutoID = @ProdutoId;
END

-- Testando procedure 
SELECT * FROM Produto;
EXEC AtualizarPrecoProduto 2, 10;
SELECT * FROM Produto;

-- Procedure 4: Total de vendas por cliente (saida)
CREATE PROCEDURE ObterTotalVendas
	@ClienteId INT,
	@TotalVendas DECIMAL(10, 2) OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	SELECT @TotalVendas = COALESCE(SUM(ValorTotal), 0) -- substitui valores nulos por 0
	FROM Pedido
	WHERE ClienteId = @ClienteId
END

-- Testando procedure
DECLARE @Total DECIMAL(10, 2)
EXEC ObterTotalVendas 2, @Total OUTPUT;
SELECT @Total AS TotalDeVendas

-- Procedure 5: Relatorio de vendas por cliente
CREATE PROCEDURE VendasPorCliente
	@DataLimite DATE
AS 
BEGIN
	SET NOCOUNT ON
	SELECT C.ClienteId, C.Nome, 
	SUM(D.Quantidade * D.PrecoUnitario) AS TotalGasto
	FROM Cliente C 
	JOIN Pedido P ON P.ClienteId = C.ClienteId
	JOIN DetalhesPedido D ON D.PedidoId = P.PedidoId
	WHERE P.DataPedido < @DataLimite
	GROUP BY C.ClienteId, C.Nome
END

-- Testando procedure
INSERT INTO DetalhesPedido (PedidoId, ProdutoId, Quantidade, PrecoUnitario)
VALUES
(1, 1, 1, 4500.00)

SELECT * FROM Pedido
SELECT * FROM DetalhesPedido

EXEC VendasPorCliente '2025-10-14'

-- Procedure 6: Historico de preco com tabela propria
CREATE TABLE HistoricoPreco (
	HistoricoId INT IDENTITY PRIMARY KEY,
	ProdutoId INT FOREIGN KEY REFERENCES Produto(ProdutoId),
	PrecoAntigo DECIMAL(10, 2),
	PrecoNovo DECIMAL(10, 2),
	DataModificacao DATE
);

CREATE PROCEDURE AtualizarPrecoProdutoComHistorico
	@ProdutoId INT,
	@NovoPreco DECIMAL(10, 2)
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE @PrecoAntigo DECIMAL(10, 2)

	SELECT @PrecoAntigo = Preco
	FROM Produto 
	WHERE ProdutoId = @ProdutoId

	UPDATE Produto SET Preco = @NovoPreco
	WHERE ProdutoId = @ProdutoId

	INSERT INTO HistoricoPreco (ProdutoId, PrecoAntigo, PrecoNovo, DataModificacao)
	VALUES (@ProdutoId, @PrecoAntigo, @NovoPreco, DATEADD(HOUR, -3, SYSUTCDATETIME()))
END

-- Testando procedure
SELECT * FROM Produto

EXEC AtualizarPrecoProdutoComHistorico 2, 75.00

SELECT * FROM HistoricoPreco

