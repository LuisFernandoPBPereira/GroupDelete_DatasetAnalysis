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
8. [Guia de Importação de Dados](#-guia-de-importação-de-dados)

   
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
- **Dicionário de Dados (do projeto)**: [Dicionário de Dados](https://www.notion.so/Dicion-rio-de-Dados-29ad1f25e22f80709753e991a5beebd4?source=copy_link)
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

📄 Para a lista completa, consulte o [dicionário de dados](https://www.notion.so/Dicion-rio-de-Dados-29ad1f25e22f80709753e991a5beebd4?source=copy_link).  

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

<img width="6980" height="2852" alt="Diagrama modelo Físico" src="https://github.com/user-attachments/assets/e578e102-9d29-4292-bf5b-92104c8f476f" />

 

## 📋 Guia de Importação de Dados

Este guia demonstra como carregar dados de um arquivo **CSV** para uma tabela no **SQL Server** utilizando o comando `BULK INSERT`.

---

## 🔹 Passo a Passo da Importação

### 1️⃣ Criar a Tabela no SQL Server

Antes de importar os dados, certifique-se de que a tabela **destino** já exista no banco de dados.  

➡️ Utilize o script SQL disponível em:  
📄 [create_geral.sql](https://github.com/LuisFernandoPBPereira/GroupDelete_DatasetAnalysis/blob/main/SQL/create_geral.sql)

---

### 2️⃣ Importar os Dados do Arquivo CSV

Com a tabela criada, você pode importar os dados do arquivo **CSV** utilizando o comando `BULK INSERT`.  

📄 Exemplo disponível no arquivo [`bulk_insert.sql`](https://github.com/LuisFernandoPBPereira/GroupDelete_DatasetAnalysis/blob/main/SQL/bulk_insert.sql).  

⚠️ **Atenção**: verifique se o caminho de importação definido no comando é o mesmo do arquivo CSV no seu sistema.  

```sql
BULK INSERT vacinacao_jan_2025    
FROM 'D:\vacinacao_jan_2025.csv' -- Caminho do arquivo CSV (Exemplo)
WITH (
    FIELDTERMINATOR = ';',    -- Separador de campos 
    ROWTERMINATOR = '0x0d0a', -- quebra de linha em formato hexadecimal
    FIRSTROW = 2,             -- Ignora a primeira linha (cabeçalho)
    TABLOCK,                  -- Otimiza a inserção em lote
    CODEPAGE = '1252'         -- Necesssário para tratar os dados (Acentos e etc)

);

