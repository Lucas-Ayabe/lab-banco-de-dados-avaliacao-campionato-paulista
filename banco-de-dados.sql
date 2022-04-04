CREATE DATABASE CP
GO
USE CP
GO
CREATE TABLE Times (
	CodigoTime INT NOT NULL IDENTITY,
	NomeTime VARCHAR(255) NOT NULL,
	Cidade VARCHAR(255) NOT NULL,
	Estadio VARCHAR(255) NOT NULL,
	PRIMARY KEY(CodigoTime)
)
GO
CREATE TABLE Grupos (
	CodigoGrupo INT NOT NULL IDENTITY,
	Grupo CHAR(1) NOT NULL,
	CodigoTime INT NOT NULL,
	PRIMARY KEY(CodigoGrupo),
	FOREIGN KEY(CodigoTime) REFERENCES Times(CodigoTime)
)
GO
CREATE TABLE Jogos (
	CodigoJogo INT NOT NULL IDENTITY,
	CodigoTimeA INT NOT NULL,
	CodigoTimeB INT NOT NULL,
	GolsTimeA INT DEFAULT 0,
	GolsTimeB INT DEFAULT 0,
	DataDoJogo Date NULL 
)
GO
INSERT INTO Times(NomeTime, Cidade, Estadio) VALUES
('Botafogo-SP', 'Ribeirão Preto', 'Santa Cruz'),
('Corinthians', 'São Paulo', 'Neo Química Arena'),
('Ferroviária', 'Araraquara', 'Fonte Luminosa'),
('Guarani', 'Campinas', 'Brinco de Ouro'), 
('Inter de Limeira', 'Limeira', 'Limeirão'),
('Ituano', 'Itu', 'Novelli Júnior'),
('Mirassol', 'Mirassol', 'José Maria de Campos Maia'), 
('Novorizontino', 'Novo Horizonte', 'Jorge Ismael de Biasi'),
('Palmeiras', 'São Paulo', 'Allianz Parque'),
('Ponte Preta', 'Campinas', 'Moisés Lucarelli'),
('Red Bull Bragantino', 'Bragança Paulista', 'Nabi Abi Chedd'),
('Santo André', 'Santo André', 'Bruno José Daniel'),
('Santos', 'Santos', 'Vila Belmiro'),
('São Bento', 'Sorocaba', 'Walter Ribeiro'),
('São Caetano', 'São Caetano do Sul', 'Anacletto Campanella'),
('São Paulo', 'São Paulo', 'Morumbi')
GO
CREATE VIEW v_novo_id
AS
SELECT CAST(CAST(NEWID() AS BINARY(3)) AS INT) AS novo_id
GO
CREATE FUNCTION fn_gerar_novo_id() RETURNS INT
AS
BEGIN
	RETURN (SELECT TOP 1 novo_id FROM v_novo_id)
END
GO
DROP FUNCTION fn_gerar_grupos_aleatorios
GO
CREATE FUNCTION fn_gerar_grupos_aleatorios()
RETURNS @tabela TABLE (
	CodigoGrupo INT NOT NULL IDENTITY,
	Grupo CHAR(1) NOT NULL DEFAULT 'A',
	CodigoTime INT NOT NULL,
	NomeTime VARCHAR(255) NOT NULL
)
AS
BEGIN
	DECLARE @grupo INT
	SET @grupo = 1
	DECLARE @times_aleatorios TABLE (
		Codigo INT NOT NULL IDENTITY,
		CodigoTime INT NOT NULL,
		NomeTime VARCHAR(255) NOT NULL
	)

	INSERT INTO @times_aleatorios (CodigoTime, NomeTime)
	SELECT CodigoTime, NomeTime FROM Times
	ORDER BY dbo.fn_gerar_novo_id()

	INSERT INTO @tabela(CodigoTime, NomeTime)
	SELECT CodigoTime, NomeTime
	FROM @times_aleatorios
	WHERE NomeTime IN ('São Paulo', 'Corinthians', 'Palmeiras', 'Santos')
	ORDER BY dbo.fn_gerar_novo_id()

	INSERT INTO @tabela(CodigoTime, NomeTime)
	SELECT CodigoTime, NomeTime
	FROM @times_aleatorios
	WHERE NomeTime NOT IN ('São Paulo', 'Corinthians', 'Palmeiras', 'Santos')
	ORDER BY dbo.fn_gerar_novo_id()

	WHILE (@grupo <= 4)
	BEGIN
		UPDATE @tabela SET Grupo = 'A'
		WHERE CodigoGrupo = @grupo * 4 - 3
		UPDATE @tabela SET Grupo = 'B'
		WHERE CodigoGrupo = @grupo * 4 - 2
		UPDATE @tabela SET Grupo = 'C'
		WHERE CodigoGrupo = @grupo * 4 - 1
		UPDATE @tabela SET Grupo = 'D'
		WHERE CodigoGrupo = @grupo * 4
		SET @grupo = @grupo + 1;
	END

	RETURN
END
GO
DROP PROCEDURE sp_inserir_grupos
GO
CREATE PROCEDURE sp_inserir_grupos
AS
	TRUNCATE TABLE Grupos
	INSERT INTO Grupos(Grupo, CodigoTime)
	SELECT Grupo, CodigoTime FROM dbo.fn_gerar_grupos_aleatorios()
	
GO
EXEC sp_inserir_grupos
GO
DROP FUNCTION fn_gerar_jogos
GO
CREATE FUNCTION fn_gerar_jogos()
RETURNS @tabela TABLE (
		CodigoJogo INT NOT NULL IDENTITY,
		IdentificadorDeIntegridade VARCHAR(10),
		CodigoTimeA INT NOT NULL,
		CodigoTimeB INT NOT NULL,
		DataDoJogo Date
	)
AS
BEGIN
	DECLARE @codigoTime INT
	DECLARE @grupoTime CHAR(1)
	DECLARE cursor_grupos CURSOR FOR
	SELECT CodigoTime, Grupo FROM Grupos ORDER BY CodigoTime

	OPEN cursor_grupos
	FETCH NEXT FROM cursor_grupos INTO @codigoTime, @grupoTime
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO @tabela (CodigoTimeA, CodigoTimeB, IdentificadorDeIntegridade, DataDoJogo)
		SELECT DISTINCT
			@codigoTime AS CodigoTimeA,
			CodigoTime AS CodigoTimeB,
			CONCAT(
				CONCAT(
					CASE
						WHEN @codigoTime < CodigoTime THEN @codigoTime
						ELSE CodigoTime
					END
					,
					'-'
				),
				CASE
					WHEN @codigoTime > CodigoTime THEN @codigoTime
					ELSE CodigoTime
				END
			) AS Partida,
			NULL
		FROM Grupos
		WHERE Grupo != @grupoTime
		AND
		CONCAT(
				CONCAT(
					CASE
						WHEN @codigoTime < CodigoTime THEN @codigoTime
						ELSE CodigoTime
					END
					,
					'-'
				),
				CASE
					WHEN @codigoTime > CodigoTime THEN @codigoTime
					ELSE CodigoTime
				END
		) NOT IN (SELECT IdentificadorDeIntegridade FROM @tabela)

		FETCH NEXT FROM cursor_grupos INTO @codigoTime, @grupoTime
	END

	DECLARE @diaComJogo INT = 1;
	DECLARE @data DATE = '27-02-2022';
	DECLARE @codigoJogo INT = 0;
	DECLARE @timeA INT;
	DECLARE @timeB INT;
	DECLARE @jaJogou INT = 0;
	DECLARE @cheio INT = 0;
	DECLARE @dataDoJogo DATE;
	
	WHILE @diaComJogo <= 24 BEGIN
		SET @codigoJogo = 1;
		SET @cheio = 0;
			 
		WHILE @codigoJogo <= 96 AND @cheio < 4 BEGIN
			SET @jaJogou = 0;
					
			SELECT
				@timeA = CodigoTimeA,
				@timeB = CodigoTimeB,
				@dataDoJogo = DataDoJogo
			FROM @tabela 
			WHERE CodigoJogo = @codigoJogo;

			IF @diaComJogo % 2 != 0 BEGIN
				SELECT @jaJogou = COUNT(*) FROM @tabela
				WHERE DataDoJogo = @data
				AND (CodigoTimeA IN (@timeA, @timeB) OR CodigoTimeB IN(@timeA, @timeB));
			END
			ELSE BEGIN
				SELECT @jaJogou = COUNT(*) FROM @tabela
				WHERE ((DataDoJogo = @data) OR (DataDoJogo = DATEADD(DAY,-4,@data)))
				AND (CodigoTimeA IN (@timeA, @timeB) OR CodigoTimeB IN(@timeA, @timeB));
			END

			IF @jaJogou = 0 AND @dataDoJogo IS NULL BEGIN
				UPDATE @tabela SET DataDoJogo = @data WHERE CodigoJogo = @codigoJogo
				SET @cheio = @cheio + 1
			END
					
			SET @codigoJogo = @codigoJogo + 1;
		END
			
		IF @diaComJogo % 2 != 0 BEGIN
			SET @data = DATEADD(DAY, 3, @data);
		END
		ELSE BEGIN
			SET @data = DATEADD(DAY, 4, @data);
		END
		SET @diaComJogo = @diaComJogo + 1;
	END

	DEALLOCATE cursor_grupos;
	RETURN  
END
GO
CREATE PROCEDURE sp_inserir_jogos
AS
	TRUNCATE TABLE Jogos
	INSERT INTO Jogos(CodigoTimeA, CodigoTimeB, DataDoJogo, GolsTimeA, GolsTimeB)
	SELECT
		CodigoTimeA,
		CodigoTimeB,
		DataDoJogo,
		0 AS GolsTimeA,
		0 AS GolsTimeB
	FROM dbo.fn_gerar_jogos()
GO
EXEC sp_inserir_jogos
GO
CREATE VIEW v_grupos
AS
SELECT
	CodigoGrupo AS Codigo,
	Grupo,
	Times.CodigoTime AS CodigoTime,
	NomeTime AS Nome,
	Cidade,
	Estadio
FROM Grupos
INNER JOIN Times
ON Grupos.CodigoTime = Times.CodigoTime;
GO
DROP VIEW v_jogos;
GO
CREATE VIEW v_jogos
AS
	SELECT
		CodigoJogo,
		TimesA.NomeTime AS NomeTimeA,
		TimesB.NomeTime AS NomeTimeB,
		GolsTimeA,
		GolsTimeB,
		DataDoJogo
	FROM Jogos
	LEFT JOIN Times AS TimesA
	ON CodigoTimeA = TimesA.CodigoTime
	LEFT JOIN Times AS TimesB
	ON CodigoTimeB = TimesB.CodigoTime
	WHERE DataDoJogo IS NOT NULL
GO
DROP PROCEDURE sp_pesquisar_rodada;
GO
CREATE PROCEDURE sp_pesquisar_rodada(@data DATE)
AS
	SELECT * FROM v_jogos WHERE DataDoJogo IN (@data, (
		CASE
			WHEN DATEPART(WEEKDAY, @data) = 4 THEN DATEADD(DAY, -3, @data)
			ELSE DATEADD(DAY, 3, @data)
		END
	))
	ORDER BY DataDoJogo
GO
SELECT * FROM v_jogos ORDER BY DataDoJogo
SELECT * FROM Jogos ORDER BY DataDoJogo