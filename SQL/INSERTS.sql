
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

-- Inserindo dados distintos na tabela SistemaOrigem
INSERT INTO dbo.SistemaOrigem (CodigoSistemaOrigem, DescricaoSistemaOrigem)
SELECT DISTINCT
	CAST(co_sistema_origem AS INT),
	CAST(ds_sistema_origem AS VARCHAR(150))
FROM dbo.vacinacao_jan_2025 AS vj25
WHERE vj25.co_sistema_origem IS NOT NULL AND vj25.ds_sistema_origem IS NOT NULL

-- Inserindo dados distintos na tabela OrigemRegistro
INSERT INTO dbo.OrigemRegistro (CodigoOrigemRegistro, DescricaoOrigemRegistro)
SELECT DISTINCT
	CAST(co_origem_registro AS INT),
	CAST(ds_origem_registro AS VARCHAR(100))
FROM dbo.vacinacao_jan_2025 AS vj25
WHERE vj25.co_origem_registro IS NOT NULL AND vj25.ds_origem_registro IS NOT NULL

-- Inserindo dados distintos na tabela GrupoAtendimento
INSERT INTO GrupoAtendimento (CodigoVacinaGrupoAtendimento, DescricaoVacinaGrupoAtendimento)
SELECT DISTINCT 
	CAST(co_vacina_grupo_atendimento AS INT),   -- Conversão de NCHAR para INT
	CAST(ds_vacina_grupo_atendimento AS VARCHAR(150))   -- Conversão de NCHAR para VARCHAR(150)
FROM vacinacao_jan_2025   -- Tabela de origem importada via BULK INSERT
WHERE co_vacina_grupo_atendimento IS NOT NULL;   -- Filtro para evitar campos nulos

-- Inserindo dados distintos na tabela Paciente
INSERT INTO Paciente (CodigoPaciente, TipoSexoPaciente, CodigoPaisPaciente, NumeroIdadePaciente, DescricaoNacionalidadePaciente, NumeroCepPaciente)
SELECT DISTINCT
    CAST(co_paciente AS CHAR(64)),
    CAST(tp_sexo_paciente AS CHAR(1)),
    CAST(co_pais_paciente AS INT),
    CAST(nu_idade_paciente AS INT),
    CAST(ds_nacionalidade_paciente AS VARCHAR(100)),
    CAST(nu_cep_paciente AS VARCHAR(8))
FROM vacinacao_jan_2025
WHERE co_paciente IS NOT NULL;

-- Inserindo dados distintos na tabela Estabelecimento
INSERT INTO Estabelecimento (CodigoCnesEstabelecimento, NomeRazaoSocialEstabelecimento, NomeFantasiaEstalecimento, CodigoMunicipioEstabelecimento, CodigoTipoEstabelecimento, CodigoNaturezaEstabelecimento)
SELECT DISTINCT
    CAST(co_cnes_estabelecimento AS INT),
    CAST(no_razao_social_estabelecimento AS VARCHAR(255)),
    CAST(no_fantasia_estabelecimento AS VARCHAR(255)),
    CAST(co_municipio_estabelecimento AS INT),
    CAST(co_tipo_estabelecimento AS INT),
    CAST(co_natureza_estabelecimento AS INT)
FROM vacinacao_jan_2025
WHERE co_cnes_estabelecimento;

-- Inserindo dados distintos na tabela Vacina
INSERT INTO Vacina (CodigoVacina, DescricaoVacina, SgVacina, CodigoLoteVacina)
SELECT DISTINCT 
	CAST(co_vacina AS INT),   -- Conversão de NCHAR para INT
	CAST(ds_vacina AS VARCHAR(150),   -- Conversão de NCHAR para VARCHAR(150)
	CAST(sg_vacina AS VARCHAR(50)),   -- Conversão de NCHAR para VARCHAR(50)
	CAST(co_lote_vacina AS VARCHAR(100))   ---- Conversão de NCHAR para VARCHAR(100)
FROM vacinacao_jan_2025;   -- Tabela de origem importada via BULK INSERT
WHERE co_vacina IS NOT NULL;   -- Filtro para evitar campos nulos

-- Inserindo dados distintos na tabela NaturezaEstabelecimento
INSERT INTO NaturezaEstabelecimento (CodigoNaturezaEstabelecimento, DescricaoNaturezaEstabelecimento)
SELECT DISTINCT
    CAST(co_natureza_estabelecimento AS INT),
    CAST(ds_natureza_estabelecimento AS VARCHAR(100))
FROM vacinacao_jan_2025

WHERE co_natureza_estabelecimento;

-- Inserindo dados distintos na tabela AplicacaoVacina
INSERT INTO AplicacaoVacina (CodigoDocumento, CodigoPaciente, CodigoCnesEstabelecimento, CodigoVacina, DataVacina)
SELECT DISTINCT
       CAST(st_documento AS VARCHAR(64),        -- Conversão de NVARCHAR para VARCHAR(64)
       CAST(co_paciente AS VARCHAR(64),         -- Conversão de NVARCHAR para VARCHAR(64)
       CAST(co_cnes_estabelecimento AS INT),          -- Conversão DE NCHAR para INT 
       CAST(co_vacina AS INT),                        -- Conversão DE NCHAR para INT 
       CAST(dt_vacina AS DATE)                        -- Conversão DE VARCHAR para DATE 
FROM vacinacao_jan_2025   -- Tabela de origem importada via BULK INSERT
WHERE st_documento IS NOT NULL;  -- Filtro para evitar valores nulos no campo obrigatóriO

-- Inserindo dados distintos na tabela VacinaFabricanteVacina
INSERT INTO VacinaFabricanteVacina (CodigoVacinaFabricante, CodigoVacina)
SELECT DISTINCT
       CAST(co_vacina_fabricante AS INT),   -- Conversão de NVARCHAR para INT
       CAST(co_vacina AS INT)               -- Conversão de NVARCHAR para INT 
FROM vacinacao_jan_2025   -- Tabela de origem importada via BULK INSERT
WHERE co_vacina_fabricante IS NOT NULL;  -- Filtro para evitar campos nulos

-- Inserindo dados distintos na tabela VacinaLocalAplicacao
INSERT INTO VacinaLocalAplicacao (CodigoLocalAplicacao, CodigoVacina)
SELECT DISTINCT
       CAST(co_local_aplicacao AS INT),   -- Conversão de NVARCHAR para INT 
       CAST(co_vacina AS INT)             -- Conversão de NVARCHAR para INT
FROM vacinacao_jan_2025   -- Tabela de origem importada via BULK INSERT
WHERE co_local_aplicacao IS NOT NULL;  -- Filtro para evitar campos nulos

-- Inserindo dados distintos na tabela AplicacaoVacinaEstabelecimento
INSERT INTO AplicacaoVacinaEstabelecimento (CodigoCnesEstabelecimento, IdAplicacao)
SELECT DISTINCT
       CAST(v.co_cnes_estabelecimento AS INT),   -- Conversão de NVARCHAR para INT 
       CAST(av.IdAplicacao AS INT)       -- Conversão de NVARCHAR para INT
FROM vacinacao_jan_2025
WHERE v.co_cnes_estabelecimento IS NOT NULL;  -- Filtro para evitar campos nulos
