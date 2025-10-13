-- PROCEDURES

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
EXEC InserirCliente 'Ana', 'Souza', 'anasouza@gmail.com', '1199999999', '2025-10-13'

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
