CREATE DATABASE BIBLIOTECA2;
GO

USE BIBLIOTECA2;
GO

CREATE TABLE Autor (
	id_Autor INT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL
	);
GO

CREATE TABLE Livro (
	id_Livro INT PRIMARY KEY,
	titulo VARCHAR(150) NOT NULL,
	ano INT,
	id_Autor INT NOT NULL,
	CONSTRAINT fk_livro_autor FOREIGN KEY (id_Autor) REFERENCES Autor(id_Autor) ON DELETE CASCADE
	);
GO

CREATE TABLE Leitor (
	id_Leitor INT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR (120) UNIQUE
	);
GO

CREATE TABLE Emprestimo (
	id_Emprestimo INT PRIMARY KEY,
	id_Livro INT NOT NULL,
	id_Leitor INT NOT NULL,
	data_emprestimo DATE NOT NULL, 
	data_devolucao DATE,
	CONSTRAINT fk_empr_livro FOREIGN KEY (id_Livro) REFERENCES Livro(id_Livro) ON DELETE CASCADE,
	CONSTRAINT fk_empr_leitor FOREIGN KEY (id_Leitor) REFERENCES Leitor(id_Leitor) ON DELETE CASCADE
	);
GO

INSERT INTO Autor VALUES 
  (1,'Machado de Assis'),
  (2,'Clarice Lispector'),
  (3,'J. K. Rowling'),
  (4,'Shakespeare');
GO

INSERT INTO Livro VALUES 
	(1, 'Dom Casmurro', 1899, 1),
	(2, 'Memórias Póstumas de Brás Cubas', 1881, 1),
	(3, 'A hora da estrela', 1977, 2),
	(4, 'O sonho de uma noite de verão', 1600, 4),		
	(5, 'Harry Potter e o calice de fogo', 2000, 3);
GO

INSERT INTO Leitor VALUES
	(1, 'Thiago Oliveira' , 'thiago@gmail.com'),
	(2, 'Caique' , 'caique@gmail.com'),
	(3, 'Odirlei' , 'odi@gmail.com' ),
	(4, 'Kessia', 'kessia@gmail.com');
GO

INSERT INTO Emprestimo VALUES --id_emprestimo, id_livro, id_leitor, data_empr, data_dev
	(1, 5, 1, '2025-09-02', '2025-09-09'), -- Thiago pegou harry potter
	(2, 4, 4, '2025-08-27', '2025-09-05'), -- kessia pegou o sonho de uma noite
	(3, 1, 2, '2025-05-01', '2025-06-10'); --caique pegou Dom casmurro
GO

-- COUNT: Contar o total de registros
SELECT * FROM Leitor;

SELECT COUNT(*) AS QtdLeitores -- Nomeia a coluna
FROM Leitor;

SELECT * FROM Emprestimo;

-- COUNT + GROUP BY (funcao agregada precisa do GROUP BY para mais atributos)
-- Para exibir a quantidade de emprestimos por pessoas
SELECT l.nome, COUNT(e.id_emprestimo) AS QtdEmprestimo
FROM Emprestimo e
JOIN Leitor l ON l.id_Leitor = e.id_Leitor
GROUP BY l.nome -- Organiza os atributos por nome

-- MIN / MAX
SELECT Ano FROM Livro;

SELECT MIN(Ano) AS MenorAno FROM Livro;
SELECT MAX(Ano) AS MaiorAno FROM Livro;

-- Funcoes de texto

-- LEN
-- Retorna o tamanho do atributo (qtde de caracteres, incluindo espacos)
SELECT LEN('Odirlei') AS TamanhoString;
SELECT nome, LEN(nome) AS TamanhoNome FROM Autor;

-- UPPER (maiusculo) / LOWER (minusculo)
SELECT UPPER(nome) FROM Leitor;
SELECT LOWER(email) FROM Leitor;

-- LEFT (esquerda) / RIGHT (direita)
-- Pega as letras a esquerda e direita
SELECT * FROM Livro;

SELECT LEFT(titulo, 5) AS Primeiros5 FROM Livro; -- atributo, e quantidade de caracteres
SELECT RIGHT(titulo, 5) AS Ultimos5 FROM Livro;

-- REPLACE
-- Trocar caracteres
SELECT * FROM Livro;

SELECT REPLACE(titulo, 'Harry', 'Hermione') -- REPLACE(nome_atributo, valorInicial, valorFinal)
FROM Livro;

-- CHARINDEX
-- Localizar a posicao de alguma palavra (so retorna a primeira)
SELECT titulo, CHARINDEX('de', titulo) AS PosicaoTexto 
FROM Livro;

-- CONCAT
-- Concatenar textos
-- SELECT e.id_Emprestimo, le.nome, li.titulo
SELECT CONCAT('Emprestimo', e.id_Emprestimo, ' - Leitor: ', le.nome, ' - Livro: ', li.titulo)
FROM Emprestimo e
JOIN Leitor le ON le.id_Leitor = e.id_Leitor
JOIN Livro li ON li.id_Livro = e.id_Livro

-- SUBSTRING
-- Mostra o texto conforme o tamanho passado
SELECT SUBSTRING(titulo, 1, 10)
FROM Livro;

-- RTRIM (direita) / LTRIM (esquerda) / TRIM (dos dois lados)
SELECT Nome, RTRIM(nome), LTRIM(nome), TRIM(nome)
FROM Leitor;

-- Funcoes de data e hora

-- GETDATE
-- dia e horario atual
-- DA INSTANCIA ONDE ESTA SENDO EXECUTADA
SELECT GETDATE();

SELECT SYSDATETIMEOFFSET()
AT TIME ZONE 'E. South America Standard Time';