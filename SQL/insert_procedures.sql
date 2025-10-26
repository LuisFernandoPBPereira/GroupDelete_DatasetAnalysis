/*
  Procedure única para inserir os dados provenientes da tabela
  vacinacao_jan_2025 nas tabelas dimensionais e de relacionamento.
  Baseada no arquivo inserts.sql: mantém a ordem das inserções para
  respeitar dependências e usa uma transação com tratamento de erro.
*/
CREATE OR ALTER PROCEDURE InserirTodosDados
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Inserindo dados distintos na tabela RacaCorPaciente
        INSERT INTO RacaCorPaciente (CodigoRacaCorPaciente, NomeRacaCorPaciente)
        SELECT DISTINCT 
               CAST(TRIM(co_raca_cor_paciente) AS INT),
               CAST(TRIM(no_raca_cor_paciente) AS VARCHAR(50))
        FROM vacinacao_jan_2025
        WHERE co_raca_cor_paciente IS NOT NULL;

        -- Inserindo dados distintos na tabela PaisPaciente
        INSERT INTO PaisPaciente  (CodigoPaisPaciente , NomePaisPaciente )
        SELECT DISTINCT  
               CAST(TRIM(co_pais_paciente) AS INT),
               CAST(TRIM(no_pais_paciente) AS VARCHAR(100))
        FROM vacinacao_jan_2025
        WHERE vacinacao_jan_2025.co_pais_paciente IS NOT NULL;

        -- Inserindo dados distintos na tabela EtniaIndigenaPaciente
        INSERT INTO EtniaIndigenaPaciente  (CodigoEtniaIndigenaPaciente , NomeEtniaIndigenaPaciente )
        SELECT DISTINCT  
               CAST(TRIM(co_etnia_indigena_paciente) AS CHAR(4)),
               CAST(TRIM(no_etnia_indigena_paciente) AS VARCHAR(100))
        FROM vacinacao_jan_2025
        WHERE vacinacao_jan_2025.co_etnia_indigena_paciente IS NOT NULL;

        -- Inserindo dados distintos na tabela CondicaoMaternal
        INSERT INTO CondicaoMaternal (CodigoCondicaoMaternal, DescricaoCondicaoMaternal)
        SELECT DISTINCT 
               CAST(TRIM(co_condicao_maternal) AS INT),
               CAST(TRIM(ds_condicao_maternal) AS VARCHAR(50))
        FROM vacinacao_jan_2025
        WHERE vacinacao_jan_2025.co_condicao_maternal IS NOT NULL;

        -- Inserindo dados distintos na tabela MunicipioPaciente
        INSERT INTO MunicipioPaciente (CodigoMunicipioPaciente, NomeMunicipioPaciente, SgUfPaciente, NomeUfPaciente)
        SELECT DISTINCT 
               CAST(TRIM(co_municipio_paciente) AS INT),
               CAST(TRIM(no_municipio_paciente) AS VARCHAR(50)),
               CAST(TRIM(sg_uf_paciente) AS CHAR(2)),
               CAST(TRIM(no_uf_paciente) AS VARCHAR(50))
        FROM vacinacao_jan_2025 v
        WHERE v.co_municipio_paciente IS NOT NULL AND v.no_municipio_paciente IS NOT NULL
          AND v.no_municipio_paciente <> 'CG';

        -- Inserindo dados distintos na tabela Paciente
        INSERT INTO Paciente (
            CodigoPaciente,
            TipoSexoPaciente,
            NumeroIdadePaciente,
            CodigoMunicipioPaciente,
            CodigoRacaCorPaciente,
            CodigoCondicaoMaternal,
            CodigoEtniaIndigenaPaciente,
            CodigoPaisPaciente
        )
        SELECT DISTINCT
            CAST(TRIM(co_paciente) AS CHAR(64)),
            CAST(MAX(TRIM(tp_sexo_paciente)) AS CHAR(1)),
            CAST(MAX(TRIM(nu_idade_paciente)) AS INT),
            CAST(MAX(TRIM(co_municipio_paciente)) AS INT),
            CAST(MAX(TRIM(co_raca_cor_paciente)) AS INT),
            CAST(MAX(TRIM(co_condicao_maternal)) AS INT),
            CAST(MAX(TRIM(co_etnia_indigena_paciente)) AS CHAR(4)),
            CAST(MAX(TRIM(co_pais_paciente)) AS INT)
        FROM 
            vacinacao_jan_2025 v
        WHERE 
            co_paciente IS NOT NULL
            AND co_municipio_paciente IS NOT NULL
            AND co_raca_cor_paciente IS NOT NULL
            AND co_pais_paciente IS NOT NULL
        GROUP BY
            co_paciente;

        -- Inserindo dados distintos na tabela MunicipioEstabelecimento
        INSERT INTO MunicipioEstabelecimento (CodigoMunicipioEstabelecimento, NomeMunicipioEstabelecimento, SgUfEstabelecimento, NomeUfEstabelecimento )
        SELECT DISTINCT 
             CAST(TRIM(co_municipio_estabelecimento) AS INT),
             CAST(TRIM(no_municipio_estabelecimento) AS VARCHAR(50)),
             CAST(TRIM(sg_uf_estabelecimento) AS CHAR(2)),
             CAST(TRIM(no_uf_estabelecimento) AS VARCHAR(50))
        FROM vacinacao_jan_2025 v
        WHERE v.co_municipio_estabelecimento IS NOT NULL AND v.no_municipio_estabelecimento IS NOT NULL;

        -- Inserindo dados distintos na tabela TipoEstabelecimento
        INSERT INTO TipoEstabelecimento (CodigoTipoEstabelecimento, DescricaoTipoEstabelecimento)
        SELECT DISTINCT
            CAST(TRIM(co_tipo_estabelecimento) AS INT),
            CAST(TRIM(ds_tipo_estabelecimento) AS VARCHAR(100))
        FROM vacinacao_jan_2025 v
        WHERE v.co_tipo_estabelecimento IS NOT NULL AND V.ds_tipo_estabelecimento IS NOT NULL;

        -- Inserindo dados distintos na tabela NaturezaEstabelecimento
        INSERT INTO NaturezaEstabelecimento (CodigoNaturezaEstabelecimento, DescricaoNaturezaEstabelecimento)
        SELECT DISTINCT
            CAST(TRIM(co_natureza_estabelecimento) AS INT),
            CAST(TRIM(ds_natureza_estabelecimento) AS VARCHAR(100))
        FROM vacinacao_jan_2025 v
        WHERE v.co_natureza_estabelecimento IS NOT NULL;

        -- Inserindo dados distintos na tabela Estabelecimento
        ;WITH EstabelecimentoNumerado AS (
            SELECT
                v.co_cnes_estabelecimento,
                v.no_razao_social_estabelecimento,
                v.no_fantasia_estalecimento,
                v.co_municipio_estabelecimento,
                ROW_NUMBER() OVER (
                    PARTITION BY v.co_cnes_estabelecimento
                    ORDER BY v.co_cnes_estabelecimento DESC
                ) AS rn
            FROM 
                vacinacao_jan_2025 v
            WHERE 
                v.co_cnes_estabelecimento IS NOT NULL AND v.no_razao_social_estabelecimento IS NOT NULL
        )
        INSERT INTO Estabelecimento (
            CodigoCnesEstabelecimento, 
            NomeRazaoSocialEstabelecimento, 
            NomeFantasiaEstalecimento, 
            CodigoMunicipioEstabelecimento
        )
        SELECT
            CAST(TRIM(co_cnes_estabelecimento) AS CHAR(7)),
            CAST(TRIM(no_razao_social_estabelecimento) AS VARCHAR(255)),
            CAST(TRIM(no_fantasia_estalecimento) AS VARCHAR(255)),
            CAST(TRIM(co_municipio_estabelecimento) AS INT)
        FROM 
            EstabelecimentoNumerado
        WHERE 
            rn = 1;

        -- Inserindo dados distintos na tabela SistemaOrigem
        INSERT INTO dbo.SistemaOrigem (CodigoSistemaOrigem, DescricaoSistemaOrigem)
        SELECT DISTINCT
            CAST(TRIM(co_sistema_origem) AS INT),
            CAST(TRIM(ds_sistema_origem) AS VARCHAR(150))
        FROM dbo.vacinacao_jan_2025 AS vj25
        WHERE vj25.co_sistema_origem IS NOT NULL AND vj25.ds_sistema_origem IS NOT NULL;

        -- Inserindo dados distintos na tabela OrigemRegistro
        INSERT INTO dbo.OrigemRegistro (CodigoOrigemRegistro, DescricaoOrigemRegistro)
        SELECT DISTINCT
            CAST(TRIM(co_origem_registro) AS INT),
            CAST(TRIM(ds_origem_registro) AS VARCHAR(100))
        FROM dbo.vacinacao_jan_2025 AS vj25
        WHERE vj25.co_origem_registro IS NOT NULL AND vj25.ds_origem_registro IS NOT NULL;

        -- Inserindo dados distintos na tabela EstrategiaVacinacao
        INSERT INTO EstrategiaVacinacao (CodigoEstrategiaVacinacao, DescricaoEstrategiaVacinacao)
        SELECT 
            CAST(TRIM(v.co_estrategia_vacinacao) AS INT),
            CAST(MIN(TRIM(v.ds_estrategia_vacinacao)) AS VARCHAR(100))
        FROM vacinacao_jan_2025 v
        WHERE v.co_estrategia_vacinacao IS NOT NULL
          AND v.ds_estrategia_vacinacao IS NOT NULL
        GROUP BY v.co_estrategia_vacinacao;

        --Inserindo dados distintos na tabela Documento
        INSERT INTO Documento (
            CodigoDocumento, 
            CodigoPaciente, 
            CodigoTrocaDocumento, 
            StDocumento, 
            DataEntradaRnDescricao, 
            CodigoSistemaOrigem, 
            CodigoOrigemRegistro, 
            CodigoEstrategiaVacinacao
        )
        SELECT DISTINCT
            CAST(TRIM(v.co_documento) AS CHAR(41)),
            CAST(TRIM(v.co_paciente) AS CHAR(64)),
            CAST(TRIM(v.co_troca_documento) AS CHAR(41)),
            CAST(TRIM(v.st_documento) AS VARCHAR(20)),
            CAST(TRIM(v.dt_entrada_rnds) AS DATETIME2),
            CAST(TRIM(v.co_sistema_origem) AS INT),
            CAST(TRIM(v.co_origem_registro) AS INT),
            CAST(TRIM(v.co_estrategia_vacinacao) AS INT)
        FROM 
            vacinacao_jan_2025 v
        INNER JOIN 
            Paciente p ON TRIM(v.co_paciente) = p.CodigoPaciente
        INNER JOIN
            OrigemRegistro o ON o.CodigoOrigemRegistro = v.co_origem_registro
        WHERE 
            v.co_documento IS NOT NULL;

        -- Inserindo dados distintos na tabela DoseVacina
        INSERT INTO DoseVacina(CodigoDoseVacina,DescricaoDoseVacina)
        SELECT DISTINCT
            CAST(TRIM(v.co_dose_vacina) AS INT),
            CAST(TRIM(v.ds_dose_vacina) AS VARCHAR(100))
        FROM
            vacinacao_jan_2025 v
        WHERE v.co_dose_vacina IS NOT NULL;

        -- Inserindo dados distintos na tabela LocalAplicacao
        INSERT INTO LocalAplicacao (CodigoLocalAplicacao, DescricaoLocalAplicacao)
        SELECT DISTINCT
               CAST(TRIM(co_local_aplicacao) AS INT),
               CAST(TRIM(ds_local_aplicacao) AS VARCHAR(150))
        FROM vacinacao_jan_2025
        WHERE co_local_aplicacao IS NOT NULL;

        -- Inserindo dados distintos na tabela ViaAdministracao
        INSERT INTO ViaAdministracao (CodigoViaAdministracao, DescricaoViaAdministracao)    
        SELECT DISTINCT 
            CAST(TRIM(co_via_administracao) AS INT),
            CAST(TRIM(ds_via_administracao) AS VARCHAR(150))
        FROM vacinacao_jan_2025 v
        WHERE 
            v.co_via_administracao IS NOT NULL AND v.ds_via_administracao IS NOT NULL;

        -- Inserindo dados distintos na tabela VacinaFabricante
        INSERT INTO VacinaFabricante (CodigoVacinaFabricante, DescricaoVacinaFabricante)
        SELECT DISTINCT
               CAST(TRIM(co_vacina_fabricante) AS INT),
               CAST(TRIM(ds_vacina_fabricante) AS VARCHAR(150))
        FROM vacinacao_jan_2025
        WHERE co_vacina_fabricante IS NOT NULL;

        -- Inserindo dados distintos na tabela GrupoAtendimento
        INSERT INTO GrupoAtendimento (CodigoVacinaGrupoAtendimento, DescricaoVacinaGrupoAtendimento)
        SELECT DISTINCT 
            CAST(TRIM(co_vacina_grupo_atendimento) AS INT),
            CAST(TRIM(ds_vacina_grupo_atendimento) AS VARCHAR(150))
        FROM vacinacao_jan_2025
        WHERE co_vacina_grupo_atendimento IS NOT NULL;

        -- Inserindo dados distintos na tabela CategoriaAtendimento
        INSERT INTO CategoriaAtendimento (CodigoVacinaCategoriaAtendimento, DescricaoVacinaCategoriaAtendimento)
        SELECT DISTINCT
               CAST(TRIM(co_vacina_categoria_atendimento) AS INT),
               CAST(TRIM(ds_vacina_categoria_atendimento) AS VARCHAR(150))
        FROM vacinacao_jan_2025
        WHERE co_vacina_categoria_atendimento IS NOT NULL;

        -- Inserindo dados distintos na tabela Vacina
        INSERT INTO Vacina (CodigoVacina, DescricaoVacina)
        SELECT DISTINCT 
            CAST(TRIM(co_vacina) AS INT),
            CAST(TRIM(MAX(ds_vacina)) AS VARCHAR(150))
        FROM vacinacao_jan_2025
        WHERE co_vacina IS NOT NULL
        GROUP BY 
            CAST(TRIM(co_vacina) AS INT);

        -- Inserindo dados distintos na tabela AplicacaoVacina
        INSERT INTO AplicacaoVacina (CodigoDocumento, CodigoPaciente, CodigoCnesEstabelecimento, CodigoVacina, DataVacina)
        SELECT DISTINCT
               CAST(TRIM(co_documento) AS CHAR(41)),
               CAST(TRIM(co_paciente) AS CHAR(64)),
               CAST(TRIM(co_cnes_estabelecimento) AS CHAR(7)),
               CAST(TRIM(co_vacina) AS INT),
               CAST(TRIM(dt_vacina) AS DATE)
        FROM vacinacao_jan_2025 V
        INNER JOIN DOCUMENTO D ON V.co_documento = D.CodigoDocumento
        INNER JOIN VACINA VA ON V.co_vacina = VA.CodigoVacina
        WHERE  co_documento IS NOT NULL;

        -- Inserindo dados distintos na tabela VacinaFabricanteVacina
        INSERT INTO VacinaFabricanteVacina (CodigoVacinaFabricante, CodigoVacina)
        SELECT DISTINCT
               CAST(TRIM(co_vacina_fabricante) AS INT),
               CAST(TRIM(co_vacina) AS INT)
        FROM vacinacao_jan_2025 vj
        INNER JOIN vacina v on v.CodigoVacina = vj.co_vacina
        INNER JOIN VacinaFabricante vf on vf.CodigoVacinaFabricante = vj.co_vacina_fabricante
        WHERE vj.co_vacina_fabricante IS NOT NULL;

        -- Inserindo dados distintos na tabela AplicacaoVacinaEstabelecimento
        INSERT INTO AplicacaoVacinaEstabelecimento (CodigoCnesEstabelecimento, IdAplicacao)
        SELECT DISTINCT
               CAST(TRIM(v.co_cnes_estabelecimento) AS CHAR(7)),
               av.IdAplicacao
        FROM vacinacao_jan_2025 v
        INNER JOIN AplicacaoVacina av on av.CodigoCnesEstabelecimento = v.co_cnes_estabelecimento
        WHERE v.co_cnes_estabelecimento IS NOT NULL;

        -- Inserindo dados distintos na tabela VacinaLocalAplicacao
        INSERT INTO VacinaLocalAplicacao (CodigoLocalAplicacao, CodigoVacina)
        SELECT DISTINCT
               CAST(TRIM(co_local_aplicacao) AS INT),
               CAST(TRIM(co_vacina) AS INT)
        FROM vacinacao_jan_2025 VJ
        INNER JOIN Vacina V ON V.CodigoVacina = VJ.co_vacina
        INNER JOIN LocalAplicacao LA ON LA.CodigoLocalAplicacao = VJ.co_local_aplicacao
        WHERE co_local_aplicacao IS NOT NULL AND co_vacina IS NOT NULL;

        -- Inserindo dados distintos na tabela VacinaDoseVacina
        INSERT INTO VacinaDoseVacina (CodigoVacina, CodigoDoseVacina)
        SELECT DISTINCT
               CAST(TRIM(co_vacina) AS INT),
               CAST(TRIM(co_dose_vacina) AS INT)
        FROM vacinacao_jan_2025 VJ
        INNER JOIN Vacina V ON VJ.co_vacina = V.CodigoVacina
        INNER JOIN DoseVacina DV ON VJ.co_vacina = DV.CodigoDoseVacina
        WHERE co_vacina IS NOT NULL AND co_dose_vacina IS NOT NULL;

        -- Inserindo dados distintos na tabela VacinaViaAdministracao
        INSERT INTO VacinaViaAdministracao(CodigoVacina, CodigoViaAdministracao)
        SELECT DISTINCT
            CAST(TRIM(co_vacina) AS INT),
            CAST(TRIM(co_via_administracao) AS INT)
        FROM vacinacao_jan_2025 VJ
        INNER JOIN Vacina V ON V.CodigoVacina = VJ.co_vacina
        INNER JOIN ViaAdministracao VA ON VA.CodigoViaAdministracao = VJ.co_via_administracao
        WHERE co_vacina IS NOT NULL AND co_via_administracao IS NOT NULL;

        -- Inserindo dados distintos na tabela VacinaGrupoAtendimento
        INSERT INTO VacinaGrupoAtendimento (CodigoVacina, CodigoVacinaGrupoAtendimento)
        SELECT DISTINCT 
            CAST(TRIM(co_vacina) AS INT),
            CAST(TRIM(co_vacina_grupo_atendimento) AS INT)
        FROM vacinacao_jan_2025 VJ
        INNER JOIN Vacina V ON V.CodigoVacina = VJ.co_vacina
        INNER JOIN GrupoAtendimento GA ON GA.CodigoVacinaGrupoAtendimento = VJ.co_vacina_grupo_atendimento
        WHERE co_vacina IS NOT NULL AND co_vacina_grupo_atendimento IS NOT NULL;

        -- Inserindo dados distintos na tabela CategoriaAtendimento
        INSERT INTO VacinaCategoriaAtendimento (CodigoVacina, CodigoVacinaCategoriaAtendimento)
        SELECT DISTINCT
            CAST(TRIM(co_vacina) AS INT),
            CAST(TRIM(co_vacina_categoria_atendimento) AS INT)
        FROM vacinacao_jan_2025 VJ
        INNER JOIN Vacina V ON V.CodigoVacina = VJ.co_vacina
        INNER JOIN CategoriaAtendimento CA ON CA.CodigoVacinaCategoriaAtendimento = VJ.co_vacina_categoria_atendimento
        WHERE co_vacina IS NOT NULL AND co_vacina_categoria_atendimento IS NOT NULL;

        --Inserindo dados distintos na tabela EstabelecimentoTipoEstabelecimento
        INSERT INTO EstabelecimentoTipoEstabelecimento(CodigoCnesEstabelecimento,CodigoTipoEstabelecimento)
        SELECT DISTINCT 
            CAST(TRIM(co_cnes_estabelecimento) AS CHAR(7)),
            CAST(TRIM(co_tipo_estabelecimento) AS INT)
        FROM vacinacao_jan_2025 VJ
        INNER JOIN Estabelecimento E ON E.CodigoCnesEstabelecimento = VJ.co_cnes_estabelecimento
        INNER JOIN TipoEstabelecimento TE ON TE.CodigoTipoEstabelecimento = VJ.co_tipo_estabelecimento
        WHERE co_cnes_estabelecimento IS NOT NULL AND co_tipo_estabelecimento IS NOT NULL;

        --Inserindo dados distintos na tabela EstabelecimentoNaturezaEstabelecimento
        INSERT INTO EstabelecimentoNaturezaEstabelecimento(CodigoCnesEstabelecimento, CodigoNaturezaEstabelecimento) 
        SELECT DISTINCT 
            CAST(TRIM(co_cnes_estabelecimento) AS CHAR(7)),
            CAST(TRIM(co_natureza_estabelecimento) AS INT)
        FROM vacinacao_jan_2025 VJ
        INNER JOIN Estabelecimento E ON E.CodigoCnesEstabelecimento = VJ.co_cnes_estabelecimento
        INNER JOIN NaturezaEstabelecimento NE ON NE.CodigoNaturezaEstabelecimento = VJ.co_natureza_estabelecimento
        WHERE co_cnes_estabelecimento IS NOT NULL AND co_natureza_estabelecimento IS NOT NULL;

        COMMIT TRANSACTION;
        PRINT 'InserirTodosDados: execução finalizada com sucesso.';
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrNum INT = ERROR_NUMBER();
        PRINT CONCAT('Erro (', @ErrNum, '): ', @ErrMsg);
        THROW; -- re-raise
    END CATCH
END;
GO

-- Executa a procedure após criá-la
EXEC InserirTodosDados;

