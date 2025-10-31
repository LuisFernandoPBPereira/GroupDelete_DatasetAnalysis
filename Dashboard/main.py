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
aplicacoes_por_estrategia_vacinacao = pd.read_sql("SELECT * FROM [DB_VACINACAO].[dbo].[vw_AplicacoesPorEstrategiaVacinacao]", conn)
distribuicao_raca_cor = pd.read_sql("SELECT *FROM [DB_VACINACAO].[dbo].[vw_DistribuicaoRacaCorPacientes]", conn)
distribuicao_condicao_maternal_pacientes = pd.read_sql("SELECT * FROM [DB_VACINACAO].[dbo].[vw_DistribuicaoCondicaoMaternalPacientes]", conn)

st.title("Vacinações - Janeiro/2025")


fig1 = px.bar(
    aplicacoes_por_estrategia_vacinacao,
    x="DescricaoEstrategiaVacinacao",
    y="TotalAplicacoes",
    title=f"",
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

# Criar lista de abas de 2 em 2 até 23
tab_labels = [f"{i}-{i+1}" for i in range(1, 24, 2)] 

# Criar as abas
tabs = st.tabs(tab_labels)


with tabs[0]:
    col1, col2 = st.columns(2)
    col1.plotly_chart(fig1)
    col2.plotly_chart(fig2)
