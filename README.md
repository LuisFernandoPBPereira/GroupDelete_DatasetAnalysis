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

- **Dataset**: Vacinação - Janeiro 2025 [PNI - Programa Nacional de Imunizações (2025)](https://dados.gov.br/dados/conjuntos-dados/doses-aplicadas-pelo-programa-de-nacional-de-imunizacoes-pni-2025)  
- **Dicionário de Dados**: [Documento oficial PDF](https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/dbbni/Dicionario_tb_ria_rotina.pdf)  

Para acessar o dataset, abra o link, vá até a aba **Recursos**, lá estará o dataset **Vacinação - Janeiro 2025**

---

## 🗂️ Planejamento

- **Trello**: [Board do Projeto](https://trello.com/b/12suGTkF/delete-storytelling)
- **Notion**: [Plano de Análise de Dados](https://www.notion.so/Plano-de-An-lise-de-Dados-de-Vacina-o-fe0b0b8b117241698e82b01de8811714?t=25b56f88d137807a832c00a9f0ff9442)

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

  
## Modelo Lógico
<img width="6920" height="2716" alt="Diagrama Modelo Lógico" src="https://github.com/user-attachments/assets/dcddc081-3fa0-4eb2-95f3-6b81bf26c09f" />
https://lucid.app/lucidchart/8ab629d2-3e6f-45cd-ae11-b1170bd3fe49/edit?invitationId=inv_bce83d8d-ac52-4c6e-9e82-f69fbf091324&page=0_0#

## Modelo Físico
<img width="6920" height="2716" alt="Diagrama  modelo Físico" src="https://github.com/user-attachments/assets/cb5ab105-6a20-4aec-882e-1d491fe1ff72" />
https://lucid.app/lucidchart/35e4a992-cc23-4e8a-864d-f4b806ccbcfe/edit?viewport_loc=1626%2C-2755%2C5593%2C3316%2C0_0&invitationId=inv_6fc621f9-b140-4649-afcc-890d184f6fe1



