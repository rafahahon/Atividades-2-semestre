CREATE DATABASE Atividade1;

USE Atividade1;

-- 1 - Cadastro de alunos
CREATE TABLE Aluno(
	IdAluno INT PRIMARY KEY,
	Nome NVARCHAR(100),
	Idade INT,
	Cidade NVARCHAR(100)
);

INSERT INTO Aluno VALUES
(1, 'Alana', 21, 'Salvador'),
(2, 'Bruna', 16, 'Recife'),
(3, 'Erick', 24, 'Fortaleza'),
(4, 'Fred', 18, 'Campo Grande'),
(5, 'George', 34, 'Curitiba'),
(6, 'Rebeca', 17, 'Porto Alegre')

-- Consultas
SELECT * FROM Aluno;

SELECT * FROM Aluno
WHERE idade > 20;

SELECT * FROM Aluno
WHERE cidade = 'Porto Alegre';

-- 2 - Loja de games
CREATE TABLE Jogo(
	IdJogo INT PRIMARY KEY,
	Titulo NVARCHAR(100),
	Genero NVARCHAR(100),
	Preco INT
);

INSERT INTO Jogo VALUES
(1, 'God of War', 'Ação', 234),
(2, 'Silent Hill', 'Terror', 218),
(3, 'Silent Hill 2', 'Terror', 104),
(4, 'Resident Evil', 'Ação', 34),
(5, 'It Takes Two', 'Aventura', 135),
(6, 'Dead Space', 'Terror', 52)

-- Consultas
SELECT * FROM Jogo
WHERE Genero = 'Terror';

SELECT * FROM Jogo
WHERE preco > 200;

SELECT Titulo, Preco FROM Jogo;

-- 3 - Biblioteca virtual
CREATE TABLE Livro(
	IdLivro INT PRIMARY KEY,
	Titulo NVARCHAR(100),
	Autor NVARCHAR(100),
	AnoPublicacao INT
);

INSERT INTO Livro VALUES
(1, 'Cem Anos de Solidão', 'Gabriel García Márquez', 1967),
(2, 'O Velho e o Mar', 'Ernest Hemingway', 1952),
(3, 'A Estratégia de Davi', 'Tiago Souza', 2024),
(4, 'Dom Casmurro', 'Machado de Assis', 1899),
(5, 'Jantar Secreto', 'Raphael Montes', 2024),
(6, 'A Empregada', 'Freida McFadden', 2024)

-- Consultas
SELECT * FROM Livro
WHERE AnoPublicacao > 2010;

SELECT * FROM Livro
WHERE Autor = 'Raphael Montes';

SELECT Titulo FROM Livro;

-- 3 - Cadastro de funcionarios
CREATE TABLE Funcionario(
	IdFuncionario INT PRIMARY KEY,
	Nome NVARCHAR(100),
	Cargo NVARCHAR(100),
	Salario INT
);

INSERT INTO Funcionario VALUES
(1, 'Eduarda', 'Diretora', 15000),
(2, 'Rodrigo', 'Gerente', 7000),
(3, 'Sabrina', 'Lider de equipe', 5000),
(4, 'Angelo', 'Recrutador', 4000),
(5, 'Bruno', 'Recrutador', 4000),
(6, 'Pedro', 'Assistente', 2000)

-- Consultas
SELECT * FROM Funcionario
WHERE Salario > 3000;

SELECT * FROM Funcionario
WHERE Cargo = 'Recrutador';

SELECT Nome, Cargo FROM Funcionario;

-- 5 - Sistema de Pedidos Simples
CREATE TABLE Pedido(
	IdPedido INT PRIMARY KEY,
	Cliente NVARCHAR(100),
	Produto NVARCHAR(100),
	Quantidade INT
);

INSERT INTO Pedido VALUES
(1, 'Rodrigo', 'PF', 2),
(2, 'Rebeca', 'Pizza', 3),
(3, 'Rodrigo', 'Suco de laranja', 2),
(4, 'Sofia', 'Bolo de pote', 1),
(5, 'Olivia', 'Macarrão', 3),
(6, 'Maria', 'Bolo de pote', 2)

-- Consultas
SELECT * FROM Pedido
WHERE Cliente = 'Rodrigo';

SELECT * FROM Pedido
WHERE Produto = 'Bolo de pote';

SELECT Cliente, Quantidade FROM Pedido;