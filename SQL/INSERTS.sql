-- Observação: O uso do DISTINCT é necessário para garantir que não sejam inseridos registros duplicados, mas nem todas devem ter.
-- As colunas estão mapeadas conforme o dicionário de dados (De/Para).

-- Inserindo dados distintos na tabela RacaCorPaciente
INSERT INTO RacaCorPaciente (CodigoRacaCorPaciente, NomeRacaCorPaciente)
SELECT DISTINCT 
       CAST(co_raca_cor_paciente AS INT),         -- Conversão de NCHAR para INT 
       CAST(no_raca_cor_paciente AS VARCHAR(50)) -- Conversão de NVARCHAR para VARCHAR(50) 
FROM vacinacao_jan_2025;                         -- Tabela de origem importada via BULK INSERT

-- Inserindo dados distintos na tabela PaisPaciente
INSERT INTO PaisPaciente  (CodigoPaisPaciente , NomePaisPaciente )
SELECT DISTINCT  
       CAST(co_pais_paciente AS INT), -- Conversão de NVARCHAR para INT
       CAST(no_pais_paciente AS VARCHAR(100)) -- Conversão de NVARCHAR para VARCHAR(100) 
FROM vacinacao_jan_2025 -- Tabela de origem importada via BULK INSERT
WHERE vacinacao_jan_2025.co_pais_paciente IS NOT NULL; -- Existe um campo nulo na tabela, então é necessário ter este where

-- Inserindo dados distintos na tabela EtniaIndigenaPaciente
INSERT INTO EtniaIndigenaPaciente  (CodigoEtniaIndigenaPaciente , NomeEtniaIndigenaPaciente )
SELECT DISTINCT  
       CAST(co_etnia_indigena_paciente AS CHAR(4)), -- Conversão de NVARCHAR para CHAR(4) 
       CAST(no_etnia_indigena_paciente AS VARCHAR(100)) -- Conversão de NVARCHAR para VARCHAR(100) 
FROM vacinacao_jan_2025 -- Tabela de origem importada via BULK INSERT
WHERE vacinacao_jan_2025.co_etnia_indigena_paciente IS NOT NULL; -- Existe um campo nulo na tabela, então é necessário ter este where




