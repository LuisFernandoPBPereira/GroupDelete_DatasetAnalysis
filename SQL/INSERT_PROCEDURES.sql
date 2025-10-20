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

