USE Clinica_Medica;

-- DICIONARIO DE DADOS
-- Mostra todas as tabelas dentro do banco de dados clinica medica, com datas de criacao, modificacao, entre outras propriedades
SELECT * FROM sys.tables;

-- Mostra todas as tabelas, mas somente com o nome, a data de criacao e de modificacao
SELECT name, create_date, modify_date
FROM sys.tables;

-- Mostra todos os atributos de uma coluna e suas propriedades (visualizar informacoes das colunas da tabela)
SELECT * FROM sys.columns
WHERE object_id = OBJECT_ID('Paciente')

-- Mostra todos os tipos de dados que temos no sistema
SELECT * FROM sys.types;

-- Consulta de todos juntos com JOIN
SELECT tabelas.name AS Tabela, colunas.name AS Coluna, 
tipo.name AS Tipo, colunas.max_length AS Tamanho,
colunas.is_nullable AS PermiteNulo
FROM sys.tables tabelas
JOIN sys.columns colunas ON tabelas.object_id = colunas.object_id
JOIN sys.types tipo ON colunas.user_type_id = tipo.user_type_id
ORDER BY tabelas.name, colunas.column_id

SELECT * FROM INFORMATION_SCHEMA.COLUMNS