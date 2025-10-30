IF NOT EXISTS (
    SELECT name 
    FROM sys.databases 
    WHERE name = 'DB_VACINACAO'
)
BEGIN
    CREATE DATABASE DB_VACINACAO;
END

GO

USE DB_VACINACAO;

DROP TABLE IF EXISTS vacinacao_jan_2025;

CREATE TABLE [dbo].[vacinacao_jan_2025] (
[co_documento] nvarchar(500),
[co_paciente] nvarchar(500),
[tp_sexo_paciente] nvarchar(500),
[co_raca_cor_paciente] nvarchar(500),
[no_raca_cor_paciente] nvarchar(500),
[co_municipio_paciente] nvarchar(500),
[co_pais_paciente] nvarchar(500),
[no_municipio_paciente] nvarchar(500),
[no_pais_paciente] nvarchar(500),
[sg_uf_paciente] nvarchar(500),
[nu_cep_paciente] nvarchar(500),
[ds_nacionalidade_paciente] nvarchar(500),
[no_etnia_indigena_paciente] nvarchar(500),
[co_etnia_indigena_paciente] nvarchar(500),
[co_cnes_estabelecimento] nvarchar(500),
[no_razao_social_estabelecimento] nvarchar(500),
[no_fantasia_estalecimento] nvarchar(500),
[co_municipio_estabelecimento] nvarchar(500),
[no_municipio_estabelecimento] nvarchar(500),
[sg_uf_estabelecimento] nvarchar(500),
[co_troca_documento] nvarchar(500),
[co_vacina] nvarchar(500),
[sg_vacina] nvarchar(500),
[dt_vacina] nvarchar(500),
[co_dose_vacina] nvarchar(500),
[ds_dose_vacina] nvarchar(500),
[co_local_aplicacao] nvarchar(500),
[ds_local_aplicacao] nvarchar(500),
[co_via_administracao] nvarchar(500),
[ds_via_administracao] nvarchar(500),
[co_lote_vacina] nvarchar(500),
[ds_vacina_fabricante] nvarchar(500),
[dt_entrada_rnds] nvarchar(500),
[co_sistema_origem] nvarchar(500),
[ds_sistema_origem] nvarchar(500),
[st_documento] nvarchar(500),
[co_estrategia_vacinacao] nvarchar(500),
[ds_estrategia_vacinacao] nvarchar(500),
[co_origem_registro] nvarchar(500),
[ds_origem_registro] nvarchar(500),
[co_vacina_grupo_atendimento] nvarchar(500),
[ds_vacina_grupo_atendimento] nvarchar(500),
[co_vacina_categoria_atendimento] nvarchar(500),
[ds_vacina_categoria_atendimento] nvarchar(500),
[co_vacina_fabricante] nvarchar(500),
[ds_vacina] nvarchar(500),
[ds_condicao_maternal] nvarchar(500),
[co_tipo_estabelecimento] nvarchar(500),
[ds_tipo_estabelecimento] nvarchar(500),
[co_natureza_estabelecimento] nvarchar(500),
[ds_natureza_estabelecimento] nvarchar(500),
[nu_idade_paciente] nvarchar(500),
[co_condicao_maternal] nvarchar(500),
[no_uf_paciente] nvarchar(500),
[no_uf_estabelecimento] nvarchar(500),
[dt_deletado_rnds] nvarchar(500)
)
