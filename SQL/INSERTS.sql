-- Observação: O uso do DISTINCT é necessário para garantir que não sejam inseridos registros duplicados, mas nem todas devem ter.
-- As colunas estão mapeadas conforme o dicionário de dados (De/Para).

-- Tabela RacaCorPaciente
INSERT INTO RacaCorPaciente (CodigoRacaCorPaciente, NomeRacaCorPaciente)
SELECT DISTINCT 
       co_raca_cor_paciente, 
       no_raca_cor_paciente
FROM vacinacao_jan_2025; -- Tabela de origem importada via BULK INSERT

-- Tabela PaisPaciente
INSERT INTO PaisPaciente  (CodigoPaisPaciente , NomePaisPaciente )
SELECT DISTINCT  
       co_pais_paciente, 
       no_pais_paciente
FROM vacinacao_jan_2025 -- Tabela de origem importada via BULK INSERT
WHERE vacinacao_jan_2025.co_pais_paciente IS NOT NULL; -- Existe um campo nulo na tabela, então é necessário ter este where

-- Tabela EtniaIndigenaPaciente
INSERT INTO EtniaIndigenaPaciente  (CodigoEtniaIndigenaPaciente , NomeEtniaIndigenaPaciente )
SELECT DISTINCT  
       co_etnia_indigena_paciente, 
       no_etnia_indigena_paciente
FROM vacinacao_jan_2025 -- Tabela de origem importada via BULK INSERT
WHERE vacinacao_jan_2025.co_etnia_indigena_paciente IS NOT NULL; -- Existe um campo nulo na tabela, então é necessário ter este where
