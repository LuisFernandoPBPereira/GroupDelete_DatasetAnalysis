CREATE OR ALTER PROCEDURE InserirRacaCorPaciente
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM RacaCorPaciente)
    BEGIN
        PRINT 'Os dados já foram inseridos anteriormente na tabela RacaCorPaciente.';
        RETURN;
    END;

    INSERT INTO RacaCorPaciente (CodigoRacaCorPaciente, NomeRacaCorPaciente)
    SELECT DISTINCT 
           CAST(TRIM(co_raca_cor_paciente) AS INT),
           CAST(TRIM(no_raca_cor_paciente) AS VARCHAR(50))
    FROM vacinacao_jan_2025;

    PRINT 'Dados inseridos com sucesso na tabela RacaCorPaciente.';
END;
GO

EXEC InserirRacaCorPaciente;

CREATE OR ALTER PROCEDURE InserirPaisPaciente
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM PaisPaciente)
    BEGIN
        PRINT 'Os dados já foram inseridos anteriormente na tabela PaisPaciente.';
        RETURN;
    END;

    INSERT INTO PaisPaciente (CodigoPaisPaciente, NomePaisPaciente)
    SELECT DISTINCT  
           CAST(TRIM(co_pais_paciente) AS INT),
           CAST(TRIM(no_pais_paciente) AS VARCHAR(100))
    FROM vacinacao_jan_2025
    WHERE co_pais_paciente IS NOT NULL;

    PRINT 'Dados inseridos com sucesso na tabela PaisPaciente.';
END;
GO

EXEC InserirPaisPaciente;

