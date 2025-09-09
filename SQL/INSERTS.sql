-- Observação: O uso do DISTINCT é necessário para garantir que não sejam inseridos registros duplicados.
-- As colunas estão mapeadas conforme o dicionário de dados (De/Para).
INSERT INTO RacaCorPaciente (CodigoRacaCorPaciente, NomeRacaCorPaciente)
SELECT DISTINCT 
       co_raca_cor_paciente, 
       no_raca_cor_paciente
FROM vacinacao_jan_2025; -- Tabela de origem importada via BULK INSERT
