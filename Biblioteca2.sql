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

-- DATEADD
-- Adiciona um tempo a mais dentro de uma data
-- YEAR, MONTH, DAY, WEEK
SELECT id_emprestimo, data_emprestimo,
DATEADD(YEAR, 7, data_emprestimo) AS PrevisaoDevolucao 
FROM Emprestimo;

-- Diminuir o tempo
SELECT id_emprestimo, data_emprestimo,
DATEADD(MONTH, -1, data_emprestimo) AS PrevisaoDevolucao 
FROM Emprestimo;

-- DATEDIFF: diferenca entre datas
SELECT id_emprestimo, data_emprestimo, data_devolucao,
DATEDIFF(DAY, data_emprestimo, ISNULL(data_devolucao, GETDATE()))
AS DiasComLivro
FROM Emprestimo;
-- se data_devolucao estiver vazio, ele acrescenta o GETDATE para inserir a data atual e comprar com a data emprestimo

-- FORMAT
-- formatar datas
SELECT * FROM Emprestimo;

SELECT
FORMAT(data_emprestimo, 'dd/MM/yyyy') AS Emprestimo,
FORMAT(data_devolucao, 'dd/MM/yy') AS Devolucao
FROM Emprestimo;

-- Extrair ano, mes e dia de uma data
SELECT YEAR(data_emprestimo) AS Ano,
MONTH(data_emprestimo) AS Mes,
DAY(data_emprestimo) AS Dia
FROM Emprestimo;

SET LANGUAGE Portuguese;

-- DATEPART / DATANAME
SELECT DATEPART(YEAR, data_emprestimo) AS Ano,
	   DATEPART(WEEKDAY, data_emprestimo) AS DiaSemana,
	   DATENAME(WEEKDAY, data_emprestimo) AS NomeDiaSemana,
	   DATENAME(MONTH, data_emprestimo) AS NomeMes
FROM Emprestimo;

-- OPERADORES DE COMPARACAO

-- igualdade =
SELECT titulo, ano
FROM Livro
WHERE ano = 2000;

-- diferente NOT LIKE
SELECT nome, email
FROM Leitor
WHERE email NOT LIKE 'kes%';

SELECT titulo, ano
FROM Livro
WHERE ano <> 2000;

SELECT nome, email
FROM Leitor
WHERE email != 'kes%';

-- maior que >
SELECT titulo, ano
FROM Livro
WHERE ano > 1900;

-- menor que <
SELECT titulo, ano
FROM Livro
WHERE ano < 1900;

-- maior ou igual >=
SELECT id_emprestimo, data_emprestimo
FROM Emprestimo
WHERE data_emprestimo >= '2025-09-01';

-- menor ou igual <=
SELECT id_emprestimo, data_emprestimo
FROM Emprestimo
WHERE data_emprestimo <= '2025-08-31';

-- OPERADORES LOGICOS

-- AND (e)
SELECT Emprestimo.id_Emprestimo, Leitor.nome, Emprestimo.data_emprestimo, Emprestimo.data_devolucao
FROM Emprestimo
JOIN Leitor ON Leitor.id_Leitor = Emprestimo.id_Leitor
WHERE MONTH(Emprestimo.data_emprestimo) = 9
AND YEAR(Emprestimo.data_emprestimo) = 2025
-- Duas condicoes verdadeiras

-- OR (ou)
SELECT l.titulo, l.ano, a.nome
FROM Livro l
JOIN Autor a ON a.id_Autor = l.id_Autor
WHERE a.nome = 'Machado de Assis'
OR a.nome = 'Clarice Lispector';
-- Uma condicao sendo verdadeira, ja retorna o valor

-- NOT (negacao)
SELECT l.titulo, l.ano, a.nome
FROM Livro l
JOIN Autor a ON a.id_Autor = l.id_Autor
WHERE NOT a.nome = 'Shakespeare';

-- OPERADORES ESPECIAIS

-- BETWEEN (entre)
SELECT titulo, ano 
FROM Livro
WHERE ano BETWEEN 1800 AND 2000;

-- IN (verfica uma lista de valores)
SELECT * FROM Autor
WHERE nome IN ('Machado de Assis', 'Shakespeare');

-- LIKE
SELECT titulo
FROM Livro
WHERE titulo LIKE 'O%';
-- Porcentagem antes da letra - existe texto antes da letra 
-- Porcentagem depois da letra - existe texto depois da letra
-- Porcentagem entre a letra - existe texto antes e depois da letra

-- IS NULL
-- Registros vazios
SELECT id_emprestimo, id_livro, data_emprestimo
FROM Emprestimo 
WHERE data_devolucao IS NULL;

-- IS NOT NULL
SELECT id_emprestimo, id_livro, data_emprestimo
FROM Emprestimo 
WHERE data_devolucao IS NOT NULL;

-- ATIVIDADE: Desafios da biblioteca

-- Funcoes agregadas

-- 1 
SELECT COUNT(*) AS QTDLivros
FROM Livro;

-- 2
SELECT AVG(ano) AS AnoMedio FROM Livro;

-- 3
SELECT TOP 1 l.nome AS Nome_Leitor,
    COUNT(e.id_Emprestimo) AS Total_Emprestimos
FROM Leitor l
JOIN Emprestimo e ON l.id_Leitor = e.id_Leitor
GROUP BY l.id_Leitor, l.nome
ORDER BY Total_Emprestimos DESC;

-- Funcoes de texto

-- 1
SELECT LEFT(nome, 3) AS Primeiras3 FROM Autor;

-- 2
SELECT UPPER(titulo) FROM Livro;

-- 3
SELECT * FROM Leitor
WHERE RIGHT(email, 4) = '.com';

-- 4
SELECT REPLACE(titulo, 'estrela', 'sol')
FROM Livro;

-- Funcoes de data e hora

-- 1
SELECT * FROM Emprestimo
WHERE MONTH(data_emprestimo) = 8;

-- 2
SELECT 
DATEDIFF(DAY, data_emprestimo, GETDATE())
AS AteHoje
FROM Emprestimo;

-- 3
SELECT DATEPART(YEAR, data_emprestimo) AS Ano,
	   DATENAME(MONTH, data_emprestimo) AS Mes,
	   DATEPART(WEEKDAY, data_emprestimo) AS DiaSemana,
	   DATENAME(WEEKDAY, data_emprestimo) AS NomeDiaSemana
FROM Emprestimo;

-- Operadores de comparacao e logicos

-- 1 
SELECT l.titulo, l.ano, a.nome
FROM Livro l
JOIN Autor a ON a.id_Autor = l.id_Autor
WHERE ano BETWEEN 1800 AND 2000
AND a.nome <> 'J. K. Rowling';

-- 2
SELECT nome
FROM Leitor
WHERE nome LIKE 'C%';

-- 3
SELECT id_emprestimo, id_livro, data_emprestimo
FROM Emprestimo 
WHERE data_devolucao IS NULL;

-- 4
SELECT a.nome
FROM autor A
LEFT JOIN Livro l ON a.id_Autor = l.id_Autor
WHERE l.id_Livro IS NULL;