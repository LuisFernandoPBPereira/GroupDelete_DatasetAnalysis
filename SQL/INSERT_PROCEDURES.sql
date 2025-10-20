CREATE OR ALTER PROCEDURE InserirRacaCorPaciente
AS
BEGIN
    SET NOCOUNT ON;

    -- Inserindo dados distintos na tabela RacaCorPaciente
    INSERT INTO RacaCorPaciente (CodigoRacaCorPaciente, NomeRacaCorPaciente)
    SELECT DISTINCT 
           CAST(TRIM(co_raca_cor_paciente) AS INT),         -- Convers�o de NCHAR para INT 
           CAST(TRIM(no_raca_cor_paciente) AS VARCHAR(50)) -- Convers�o de NVARCHAR para VARCHAR(50) 
    FROM vacinacao_jan_2025;                         -- Tabela de origem importada via BULK INSERT
    -- N�o precisa de WHERE pois n�o tem valores nulos

    PRINT 'Dados inseridos com sucesso na tabela RacaCorPaciente.';
END;
GO

EXEC InserirRacaCorPaciente;

