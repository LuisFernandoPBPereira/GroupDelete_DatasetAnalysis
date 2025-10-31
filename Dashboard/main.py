import pyodbc
import streamlit as st
import pandas as pd
import plotly.express as px

conn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};'
    'SERVER=;'
    'DATABASE=DB_VACINACAO;'
    'UID=;'
    'PWD=;'
)

aplicacoes_por_estrategia_vacinacao = pd.read_sql("SELECT * FROM [DB_VACINACAO].[dbo].[vw_AplicacoesPorEstrategiaVacinacao]", conn)
aplicacoes_por_natureza_juridica = pd.read_sql("SELECT * FROM [DB_VACINACAO].[dbo].[vw_AplicacoesPorNaturezaJuridica]", conn)
aplicacoes_por_tipo_estabelecimento = pd.read_sql("SELECT * FROM [DB_VACINACAO].[dbo].[vw_AplicacoesPorTipoEstabelecimento]", conn)
distribuicao_raca_cor = pd.read_sql("SELECT *FROM [DB_VACINACAO].[dbo].[vw_DistribuicaoRacaCorPacientes]", conn)
distribuicao_condicao_maternal_pacientes = pd.read_sql("SELECT * FROM [DB_VACINACAO].[dbo].[vw_DistribuicaoCondicaoMaternalPacientes]", conn)
correlacao_municipio_paciente_estabelecimento = pd.read_sql("SELECT * FROM [DB_VACINACAO].[dbo].[vw_CorrelacaoMunicipioPacienteEstabelecimento]", conn)
distribuicao_nacionalidade_pacientes = pd.read_sql("SELECT * FROM [DB_VACINACAO].[dbo].[vw_DistribuicaoNacionalidadePacientes]", conn)
distribuicao_vacinas_por_estado = pd.read_sql("SELECT * FROM [DB_VACINACAO].[dbo].[vw_DistribuicaoVacinasPorEstado]", conn)
pacientes_por_faixa_etaria = pd.read_sql("SELECT * FROM [DB_VACINACAO].[dbo].[vw_PacientesPorFaixaEtaria]", conn)
paciente_por_genero = pd.read_sql("SELECT * FROM [DB_VACINACAO].[dbo].[vw_PacientesPorGenero]", conn)
proporcao_indigenas = pd.read_sql("SELECT * FROM [DB_VACINACAO].[dbo].[vw_ProporcaoIndigenas]", conn)

st.title("Vacinações - Janeiro/2025")


fig1 = px.bar(
    aplicacoes_por_estrategia_vacinacao,
    x="DescricaoEstrategiaVacinacao",
    y="TotalAplicacoes",
    title=f"Aplicações por estratégia de vacinação",
    text_auto=True,
    color="DescricaoEstrategiaVacinacao"
)
fig2 = px.bar(
    distribuicao_raca_cor,
    x="RacaCor",
    y="TotalPacientes",
    title=f"Qual é a distribuição de raça/cor entre os vacinados?",
    text_auto=True,
    color="RacaCor"
)

fig3 = px.bar(
    distribuicao_condicao_maternal_pacientes,
    x="CondicaoMaternal",
    y="TotalPacientes",
    title=f"Qual é a distribuição de vacinados por condição maternal (gestantes, puérperas)?",
    text_auto=True,
    color="CondicaoMaternal"
)

fig4 = px.bar(
    aplicacoes_por_natureza_juridica,
    x="DescricaoNaturezaEstabelecimento",
    y="TotalAplicacoes",
    title=f"Distribuição de aplicações por natureza jurídica",
    text_auto=True,
    color="DescricaoNaturezaEstabelecimento"
)

fig5 = px.pie(
    correlacao_municipio_paciente_estabelecimento,
    names="TipoCorrelacao",
    values="TotalAplicacoes",
    title=f"Correlação entre município do paciente e do estabelecimento",
    color="TipoCorrelacao"
)

fig6 = px.bar(
    distribuicao_nacionalidade_pacientes,
    x="NomePaisPaciente",
    y="TotalPacientes",
    title=f"Qual a nacionalidade predominante entre os pacientes vacinados?",
    text_auto=True,
    color="NomePaisPaciente"
)

fig7 = px.bar(
    distribuicao_vacinas_por_estado,
    x="NomeUfEstabelecimento",
    y="TotalVacinas",
    title=f"Como está a distribuição das vacinas por estado e município?",
    text_auto=True,
    color="NomeUfEstabelecimento"
)

fig8 = px.bar(
    pacientes_por_faixa_etaria,
    x="FaixaEtaria",
    y="TotalPacientes",
    title=f"Distribuição de pacientes por faixa etária ",
    text_auto=True,
    color="FaixaEtaria"
)

fig9 = px.bar(
    paciente_por_genero,
    x="TipoSexoPaciente",
    y="Total",
    title=f"Total de pacientes vacinados agrupados por gênero",
    text_auto=True,
    color="TipoSexoPaciente"
)

fig10 = px.bar(
    proporcao_indigenas,
    x="Grupo",
    y="TotalPacientes",
    title=f"Proporção de pacientes indígenas vs não indígenas",
    text_auto=True,
    color="Grupo"
)

charts = [fig1, fig2, fig3, fig4, fig5, fig6, fig7, fig8, fig9, fig10]

tab_labels = [f"{i}-{i+1}" for i in range(1, len(charts), 2)] 

tabs = st.tabs(tab_labels)

for index, tab in enumerate(tabs):
    with tab:
        col1, col2 = st.columns(2)
        
        i = index * 2
        col1.plotly_chart(charts[i], key=f"chart_{i}_1")

        if i + 1 < len(charts):  
            col2.plotly_chart(charts[i + 1], key=f"chart_{i}_2")
    