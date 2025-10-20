CREATE OR ALTER PROCEDURE InserirRacaCorPaciente
AS
BEGIN
    SET NOCOUNT ON;

    -- Inserindo dados distintos na tabela RacaCorPaciente
    INSERT INTO RacaCorPaciente (CodigoRacaCorPaciente, NomeRacaCorPaciente)
    SELECT DISTINCT 
           CAST(TRIM(co_raca_cor_paciente) AS INT),         -- Conversão de NCHAR para INT 
           CAST(TRIM(no_raca_cor_paciente) AS VARCHAR(50)) -- Conversão de NVARCHAR para VARCHAR(50) 
    FROM vacinacao_jan_2025;                         -- Tabela de origem importada via BULK INSERT
    -- Não precisa de WHERE pois não tem valores nulos

    PRINT 'Dados inseridos com sucesso na tabela RacaCorPaciente.';
END;
GO

EXEC InserirRacaCorPaciente;

CREATE OR ALTER PROCEDURE InserirPaisPaciente
AS
BEGIN
    SET NOCOUNT ON;

    -- Inserindo dados distintos na tabela PaisPaciente
    INSERT INTO PaisPaciente  (CodigoPaisPaciente , NomePaisPaciente )
    SELECT DISTINCT  
           CAST(TRIM(co_pais_paciente) AS INT), -- Conversão de NVARCHAR para INT
           CAST(TRIM(no_pais_paciente) AS VARCHAR(100)) -- Conversão de NVARCHAR para VARCHAR(100) 
    FROM vacinacao_jan_2025 -- Tabela de origem importada via BULK INSERT
    WHERE vacinacao_jan_2025.co_pais_paciente IS NOT NULL; -- Existe um campo nulo na tabela, então é necessário ter este where

    PRINT 'Dados inseridos com sucesso na tabela PaisPaciente.';
END;
GO

EXEC InserirPaisPaciente;
