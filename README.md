# 📊 Projeto de Gerenciamento de Dados de Vacinação
Este repositório contém **scripts SQL** e **documentação** para o gerenciamento de um banco de dados relacional voltado ao armazenamento e análise de dados de vacinação.  

O projeto visa **extrair insights valiosos e responder a perguntas de negócio cruciais relacionadas à demografia dos pacientes, distribuição geográfica, características das vacinas e dos estabelecimentos de saúde, e às estratégias de vacinação**, utilizando dados públicos de vacinação.

---

## 📖 Índice

1. [Contexto](#-contexto)
2. [Fontes de Dados](#-fontes-de-dados)
3. [Planejamento](-🗂️-Planejamento)
4. [Estrutura do Dataset](#-estrutura-do-dataset)
5. [Objetivo](#-objetivo)
6. [Plano de Análise de Dados](#-plano-de-análise-de-dados)
7. [Modelagem de Dados](#modelagem-de-dados)
8. [Guia de Importação de Dados](#guia-de-importação-de-dados)

   
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
- **Dicionário de Dados (do dataset)**: [Documento Oficial PDF](https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/dbbni/Dicionario_tb_ria_rotina.pdf)
- **Dicionário de Dados (do projeto)**: [Dicionário de Dados](https://www.notion.so/Dicion-rio-de-Dados-25cd1f25e22f80bd83dadac84c6566b2)
- **De/Para**: [Mapeamento do dataset para a base de dados](https://www.notion.so/De-Para-2665f029a09a80d2bb44eb48df10a2a4?source=copy_link)

### 📂 Acesso ao Dataset

Para acessar o dataset, siga um dos caminhos abaixo:

- **Pelo site**:  
  1. Abra o link do Dataset.  
  2. Vá até a aba **Recursos**.  
  3. Localize o dataset **Vacinação - Janeiro 2025 (CSV)**.  

- **Download direto**:  
  [Baixar dataset no Google Drive](https://drive.google.com/file/d/1aBDNPhWdbf-iHiI8nzHYy9YqVGK7SyEw/view?usp=sharing)


---

## 🗂️ Planejamento

- **Trello**: [Board do Projeto](https://trello.com/b/12suGTkF/delete-storytelling)
  
---

## 🧩 Estrutura do Dataset

O dataset possui diversas colunas representando informações sobre pacientes, vacinas e unidades de saúde.  

📄 Para a lista completa, consulte o [dicionário de dados](https://www.notion.so/Dicion-rio-de-Dados-25cd1f25e22f80bd83dadac84c6566b2).  

### Exemplos de colunas:
- `CodigoRacaCorPaciente`  
- `CodigoPaisPaciente `  
- `CodigoEtniaIndigenaPaciente `  
- `NomeMunicipioPaciente `  
- `CodigoPaciente `  
- `CodigoNaturezaEstabelecimento `  
- `CodigoDocumento`  
- `CodigoDoseVacina`  
- `CodigoVacinaFabricante`  

## 🎯 Objetivo
- Facilitar o armazenamento, consulta e análise dos dados de vacinação.  
- Permitir estudos epidemiológicos e comparativos.  
- Apoiar a tomada de decisão em saúde pública.

## 📊 Plano de Análise de Dados  
*Principais Perguntas e Questões a Serem Respondidas*  

1. 👥 **Perfil Demográfico**  
   - Quem são os vacinados em termos de idade, gênero e outras características populacionais?  

2. 🪶 **População Indígena**  
   - Qual a proporção de pacientes indígenas vacinados e como estão distribuídos por etnias?  

3. 🌎 **Cobertura Geográfica**  
   - Como está a distribuição das vacinas por estado e município?  

4. 🏙️ **Municípios em Destaque**  
   - Quais cidades apresentam os maiores e os menores números de aplicações?  

5. 💉 **Etapas da Vacinação**  
   - Qual a quantidade de doses aplicadas por fase (1ª, 2ª e reforço)?  

6. 🏭 **Fabricantes**  
   - Quais vacinas são mais utilizadas e qual a participação de cada fabricante?  

7. 🏥 **Locais de Aplicação**  
   - Como se distribuem as aplicações entre UBS, hospitais e outros estabelecimentos?  

8. 📈 **Evolução Temporal**  
   - Como o número de doses aplicadas evoluiu ao longo do tempo?  

📂 **Material completo**  
Para acessar todas as perguntas detalhadas, junto com as tabelas e fontes de dados relacionadas, consulte o documento completo em: [Plano de Análise de Dados](https://www.notion.so/Plano-de-An-lise-de-Dados-de-Vacina-o-fe0b0b8b117241698e82b01de8811714?t=25b56f88d137807a832c00a9f0ff9442)

 ## Modelagem de Dados

### 📐 Modelo Lógico  
🔗 [Abrir no Lucidchart](https://lucid.app/lucidchart/8ab629d2-3e6f-45cd-ae11-b1170bd3fe49/edit?invitationId=inv_bce83d8d-ac52-4c6e-9e82-f69fbf091324&page=0_0#)  

<img width="800" alt="Diagrama Modelo Lógico" src="https://github.com/user-attachments/assets/dcddc081-3fa0-4eb2-95f3-6b81bf26c09f" />  

---

### 💾 Modelo Físico  
🔗 [Abrir no Lucidchart](https://lucid.app/lucidchart/35e4a992-cc23-4e8a-864d-f4b806ccbcfe/edit?viewport_loc=1626%2C-2755%2C5593%2C3316%2C0_0&invitationId=inv_6fc621f9-b140-4649-afcc-890d184f6fe1)  

<img width="6920" height="2716" alt="Diagrama  modelo Físico" src="https://github.com/user-attachments/assets/876d582d-8697-4bcc-a735-08b4a3f08948" />
 

## 📋 Guia de Importação de Dados

Este guia mostra como carregar dados de um arquivo **CSV** para uma tabela no **SQL Server** utilizando o comando `BULK INSERT`.


### 🔹 Passo a Passo da Importação

#### 1. Criar a Tabela no SQL Server

Precisamos ter a tabela destino dos dados do dataset, para criá-la, utilize o seguinte comando SQL no arquivo `create_geral.sql`:

```sql
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
```

<br>

#### 2. Importar os Dados do Arquivo CSV

Com a tabela criada, podemos importar os dados do arquivo CSV utilizando o comando `BULK INSERT`. Como o exemplo no arquivo `bulk_insert.sql`, temos o seguinte comando:


📌 **Observação**: Se atente para o caminho de importação e o caminho do arquivo CSV serem iguais.

```sql
BULK INSERT vacinacao_jan_2025 -- Caso seja necessário alterar o nome da tabela, primeiro atualize o arquivo create_geral e, em seguida, ajuste também neste local.
FROM 'C:\caminho\arquivo.csv'  -- Caminho do arquivo CSV
WITH (
    FIELDTERMINATOR = ';',   -- Separador de campos (padrão: `;`)
    ROWTERMINATOR = '\n',    -- Separador de linhas
    FIRSTROW = 2,            -- Ignora a primeira linha (cabeçalho)
    TABLOCK                  -- Otimiza a inserção em lote
);
```
