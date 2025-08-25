# 📊 Projeto de Gerenciamento de Dados de Vacinação
Este repositório contém **scripts SQL** e **documentação** para o gerenciamento de um banco de dados relacional voltado ao armazenamento e análise de dados de vacinação.  

O projeto visa **extrair insights valiosos e responder a perguntas de negócio cruciais relacionadas à demografia dos pacientes, distribuição geográfica, características das vacinas e dos estabelecimentos de saúde, e às estratégias de vacinação**, utilizando dados públicos de vacinação.

---

## 📖 Índice

1. [Contexto](#-contexto)  
2. [Fontes de Dados](#-fontes-de-dados)  
3. [Planejamento](#️-planejamento)  
4. [Estrutura do Dataset](#-estrutura-do-dataset)  
5. [Objetivo](#-objetivo)
   
---

## 📌 Contexto

O projeto utiliza um **dataset real de vacinação**, contendo informações detalhadas sobre:  
- Pacientes  
- Vacinas  
- Estabelecimentos de saúde  
- Doses aplicadas  
- Estratégias de imunização  
- Outros dados relevantes para o controle da vacinação  

---

## 🔗 Fontes de Dados

- **Dataset**: [PNI - Programa Nacional de Imunizações (2025)](https://dados.gov.br/dados/conjuntos-dados/doses-aplicadas-pelo-programa-de-nacional-de-imunizacoes-pni-2025)  
- **Dicionário de Dados**: [Documento oficial PDF](https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/dbbni/Dicionario_tb_ria_rotina.pdf)  

---

## 🗂️ Planejamento

- **Trello**: [Board do Projeto](https://trello.com/b/12suGTkF/delete-storytelling)  

---

## 🧩 Estrutura do Dataset

O dataset possui diversas colunas representando informações sobre pacientes, vacinas e unidades de saúde.  

📄 Para a lista completa, consulte o [dicionário de dados](https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/dbbni/Dicionario_tb_ria_rotina.pdf).  

### Exemplos de colunas:
- `co_documento`  
- `co_paciente`  
- `tp_sexo_paciente`  
- `co_municipio_paciente`  
- `sg_uf_paciente`  
- `ds_vacina`  
- `co_dose_vacina`  
- `ds_dose_vacina`  
- `co_cnes_estabelecimento`  
- `no_razao_social_estabelecimento`  
- `dt_vacina`  

## 🎯 Objetivo
- Facilitar o armazenamento, consulta e análise dos dados de vacinação.  
- Permitir estudos epidemiológicos e comparativos.  
- Apoiar a tomada de decisão em saúde pública.

  




