-- Observação: O uso do DISTINCT é necessário para garantir que não sejam inseridos registros duplicados, mas nem todas devem ter.
-- As colunas estão mapeadas conforme o dicionário de dados (De/Para).

-- Inserindo dados distintos na tabela RacaCorPaciente
INSERT INTO RacaCorPaciente (CodigoRacaCorPaciente, NomeRacaCorPaciente)
SELECT DISTINCT 
       CAST(co_raca_cor_paciente AS INT),         -- Conversão de NCHAR para INT 
       CAST(no_raca_cor_paciente AS VARCHAR(50)) -- Conversão de NVARCHAR para VARCHAR(50) 
FROM vacinacao_jan_2025;                         -- Tabela de origem importada via BULK INSERT
-- Não precisa de WHERE pois não tem valores nulos

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

-- Inserindo dados distintos na tabela CondicaoMaternal
INSERT INTO CondicaoMaternal (CodigoCondicaoMaternal, DescricaoCondicaoMaternal)
SELECT DISTINCT 
       CAST(co_condicao_maternal AS INT),         -- Conversão de NCHAR para INT 
       CAST(ds_condicao_maternal AS VARCHAR(50))  -- Conversão de NVARCHAR para VARCHAR(50) 
FROM vacinacao_jan_2025
WHERE vacinacao_jan_2025.co_condicao_maternal IS NOT NULL -- Filtro para evitar campos nulos 

-- Inserindo dados distintos na tabela MunicipioPaciente
INSERT INTO MunicipioPaciente (CodigoMunicipioPaciente, NomeMunicipioPaciente, SgUfPaciente, NomeUfPaciente)
SELECT DISTINCT 
       CAST(co_municipio_paciente AS INT),          -- Código do município: convertido de NCHAR para INT
       CAST(no_municipio_paciente AS VARCHAR(50)),  -- Nome do município: convertido de NVARCHAR para VARCHAR(50)
       CAST(sg_uf_paciente AS CHAR(2)),             -- Sigla da UF: convertido de NVARCHAR para CHAR(2)
       CAST(no_uf_paciente AS VARCHAR(50))          -- Nome da UF: convertido de NVARCHAR para VARCHAR(50)
FROM vacinacao_jan_2025 v
WHERE v.co_municipio_paciente IS NOT NULL AND v.no_municipio_paciente IS NOT NULL  -- "IS NOT NULL" Remove registros com código ou nome de município nulos
  AND v.no_municipio_paciente <> 'CG' --  Exclui 'CG', usado incorretamente no lugar de 'CAMPO GRANDE', 

-- Inserindo dados distintos na tabela MunicipioEstabelecimento
INSERT INTO MunicipioEstabelecimento (CodigoMunicipioEstabelecimento, NomeMunicipioEstabelecimento, SgUfEstabelecimento, NomeUfEstabelecimento )
SELECT DISTINCT 
       CAST(co_municipio_estabelecimento AS INT),         -- Conversão de NCHAR para INT 
       CAST(no_municipio_estabelecimento AS VARCHAR(50)), -- Conversão de NVARCHAR para VARCHAR(50) 
	   CAST(sg_uf_estabelecimento AS CHAR(2)),  -- Conversão de NVARCHAR para CHAR(2)
	   CAST(no_uf_estabelecimento AS VARCHAR(50))  -- Conversão de NVARCHAR para VARCHAR(50)
FROM vacinacao_jan_2025 v
WHERE
    v.co_municipio_estabelecimento IS NOT NULL AND v.no_municipio_estabelecimento IS NOT NULL

-- Inserindo dados distintos na tabela DoseVacina
INSERT INTO DoseVacina(CodigoDoseVacina,DescricaoDoseVacina)
SELECT DISTINCT
    CAST(v.co_dose_vacina AS INT),
    CAST(v.ds_dose_vacina AS VARCHAR(100))
FROM
    vacinacao_jan_2025 v
-- Não precisa de WHERE pois não tem valores nulos

-- Inserindo dados distintos na tabela ViaAdministracao
INSERT INTO ViaAdministracao (CodigoViaAdministracao, DescricaoViaAdministracao)    
SELECT DISTINCT 
	CAST(co_via_administracao AS INT),   -- Conversão de NCHAR para INT
	CAST(ds_via_administracao AS VARCHAR(150))   -- Conversão de NCHAR para VARCHAR(150)
FROM vacinacao_jan_2025   -- Tabela de origem importada via BULK INSERT
WHERE 
	v.co_via_administracao IS NOT NULL AND v.ds_via_administracao IS NOT NULL   -- Filtro para evitar campos nulos

-- Inserindo dados distintos na tabela AplicacaoVacina
INSERT INTO AplicacaoVacina (CodigoDocumento, CodigoPaciente, CodigoCnesEstabelecimento, CodigoVacina, DataVacina)
SELECT DISTINCT
       CAST(st_documento AS UNIQUEIDENTIFIER),        -- Conversão de NCHAR/NVARCHAR para UNIQUEIDENTIFIER (chave do Documento)
       CAST(co_paciente AS UNIQUEIDENTIFIER),         -- Conversão de NCHAR/NVARCHAR para UNIQUEIDENTIFIER (chave do Paciente)
       CAST(co_cnes_estabelecimento AS INT),          -- Conversão de NCHAR/NVARCHAR para INT (código CNES do Estabelecimento)
       CAST(co_vacina AS INT),                        -- Conversão de NCHAR/NVARCHAR para INT (código da Vacina)
       CAST(dt_vacina AS DATE)                        -- Conversão de NCHAR/NVARCHAR para DATE (data da aplicação da vacina)
FROM vacinacao_jan_2025   -- Tabela de origem importada via BULK INSERT
WHERE st_documento IS NOT NULL;  -- Filtro para evitar valores nulos no campo obrigatório

-- Inserindo dados distintos na tabela VacinaFabricanteVacina
INSERT INTO VacinaFabricanteVacina (CodigoVacinaFabricante, CodigoVacina)
SELECT DISTINCT
       CAST(v.co_vacina_fabricante AS INT),   -- Código do fabricante
       CAST(v.co_vacina AS INT)               -- Código da vacina
FROM vacinacao_jan_2025 v
WHERE v.co_vacina_fabricante IS NOT NULL 
  AND v.co_vacina IS NOT NULL;                -- Filtro para evitar campos nulos

-- Inserindo dados distintos na tabela VacinaLocalAplicacao
INSERT INTO VacinaLocalAplicacao (CodigoLocalAplicacao, CodigoVacina)
SELECT DISTINCT
       CAST(v.co_local_aplicacao AS INT),   -- Código do local de aplicação
       CAST(v.co_vacina AS INT)             -- Código da vacina
FROM vacinacao_jan_2025 v
WHERE v.co_local_aplicacao IS NOT NULL 
  AND v.co_vacina IS NOT NULL;              -- Filtro para evitar campos nulos

-- Inserindo dados distintos na tabela AplicacaoVacinaEstabelecimento
INSERT INTO AplicacaoVacinaEstabelecimento (CodigoCnesEstabelecimento, IdAplicacao)
SELECT DISTINCT
       CAST(v.co_cnes_estabelecimento AS INT),   -- Código CNES do estabelecimento
       av.IdAplicacao                            -- IdAplicacao já gerado em AplicacaoVacina
FROM vacinacao_jan_2025 v
INNER JOIN AplicacaoVacina av
       ON av.CodigoDocumento = CAST(v.st_documento AS UNIQUEIDENTIFIER)
       AND av.CodigoPaciente = CAST(v.co_paciente AS UNIQUEIDENTIFIER)
WHERE v.co_cnes_estabelecimento IS NOT NULL 
  AND v.st_documento IS NOT NULL 
  AND v.co_paciente IS NOT NULL;  -- Garantia de integridade nas FKs
