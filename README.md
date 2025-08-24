# Projeto de Gerenciamento de Dados de Vacinação

Este repositório contém scripts e documentação para o gerenciamento de um banco de dados relacional voltado ao armazenamento e análise de dados de vacinação.

## Contexto
O projeto utiliza um dataset real de vacinação, contendo informações detalhadas sobre pacientes, vacinas, estabelecimentos de saúde, doses aplicadas e outros dados relevantes para o controle e análise da imunização.

## Fonte do Dataset

Dados Gov: [https://dados.gov.br/dados/conjuntos-dados/doses-aplicadas-pelo-programa-de-nacional-de-imunizacoes-pni-2025](https://dados.gov.br/dados/conjuntos-dados/doses-aplicadas-pelo-programa-de-nacional-de-imunizacoes-pni-2025)

### Exemplo de colunas do dataset:
- co_documento
- co_paciente
- tp_sexo_paciente
- co_raca_cor_paciente
- no_raca_cor_paciente
- co_municipio_paciente
- co_pais_paciente
- no_municipio_paciente
- no_pais_paciente
- sg_uf_paciente
- nu_cep_paciente
- ds_nacionalidade_paciente
- no_etnia_indigena_paciente
- co_etnia_indigena_paciente
- co_cnes_estabelecimento
- no_razao_social_estabelecimento
- no_fantasia_estalecimento
- co_municipio_estabelecimento
- no_municipio_estabelecimento
- sg_uf_estabelecimento
- co_troca_documento
- co_vacina
- sg_vacina
- dt_vacina
- co_dose_vacina
- ds_dose_vacina
- co_local_aplicacao
- ds_local_aplicacao
- co_via_administracao
- ds_via_administracao
- co_lote_vacina
- ds_vacina_fabricante
- dt_entrada_rnds
- co_sistema_origem
- ds_sistema_origem
- st_documento
- co_estrategia_vacinacao
- ds_estrategia_vacinacao
- co_origem_registro
- ds_origem_registro
- co_vacina_grupo_atendimento
- ds_vacina_grupo_atendimento
- co_vacina_categoria_atendimento
- ds_vacina_categoria_atendimento
- co_vacina_fabricante
- ds_vacina
- ds_condicao_maternal
- co_tipo_estabelecimento
- ds_tipo_estabelecimento
- co_natureza_estabelecimento
- ds_natureza_estabelecimento
- nu_idade_paciente
- co_condicao_maternal
- no_uf_paciente
- no_uf_estabelecimento
- dt_deletado_rnds

### Exemplo dos dois primeiros registros:

```
1ca8b58f-ac77-473c-826d-6b874712a41f-i0b0;6588faac8a98a6958ec8e6cf1f8c8edaf6630e04f823c9d839a0ab2865902256;M;01;BRANCA;330550;10;SAQUAREMA;BRASIL;RJ;28997;B;;;0271136;SECRETARIA MUNICIPAL DE SAUDE DE SAQUAREMA;ESF JACONE;330550;SAQUAREMA;RJ;;1;IGHT;2025-01-09;13;Tratamento com três doses;0;Sem registro no sistema de informação de origem;0;Sem registro no sistema de informação de origem;0414122;SERUM INSTITUTE;2025-02-22;18602;ESUS APS - NACIONAL (OFFLINE);final;2;Especial;;;;;;;;Imunoglobulina humana antitetano;;02;CENTRO DE SAUDE/UNIDADE BASICA;1;ADMINISTRACAO PUBLICA;26;;RIO DE JANEIRO;RIO DE JANEIRO;
1b12eab2-e9ab-466d-aff4-55a8ac45ee6b-i0b0;cc6158d350c4092e8d748bee6d7c3a21a7ef858eb151b943952324443a4cb5cb;F;01;BRANCA;420420;10;CHAPECO;BRASIL;SC;89805;B;;;7319428;MUNICIPIO DE CHAPECO;UNIDADE DE PRONTO ATENDIMENTO UPA 24H;420420;CHAPECO;SC;;1;IGHT;2025-01-26;59;Profilaxia com 1 frasco-ampola/ampola;8;Ferimento Local;10863;Bucal;p100478096;FUNDACAO BUTANTAN;2025-01-26;40114;IDS Saude;final;2;Especial;99;;000210;Faixa Etária;2;Faixa Etária;152;Imunoglobulina humana antitetano;Nenhuma;73;PRONTO ATENDIMENTO;1;ADMINISTRACAO PUBLICA;61;1;SANTA CATARINA;SANTA CATARINA;
```

## Estrutura do Repositório
- `script_create_database.db`: Script SQL para criação do banco de dados e tabelas relacionadas ao dataset de vacinação.

## Objetivo
O objetivo deste projeto é facilitar o armazenamento, consulta e análise dos dados de vacinação, permitindo estudos epidemiológicos, geração de relatórios e integração com sistemas de saúde.

## Como usar
1. Execute o script SQL para criar o banco de dados e as tabelas.
2. Importe o dataset de vacinação para as tabelas correspondentes.
3. Utilize consultas SQL para análise dos dados conforme a necessidade do projeto.

---

Projeto acadêmico para a disciplina de Gerenciamento de Banco de Dados.


## Perguntas que agregam o dataset

**1. Pacientes**
- Qual o perfil demográfico dos vacinados (idade, sexo, localização)?

<br>

**2. Vacinas**
- Qual vacina é mais utilizada em cada região?
 
<br>

**3. Doses**
- Quantos pacientes completaram o ciclo vacinal?
- Qual o intervalo médio entre as doses?

<br>

**4. Unidades_Saude**
- Quais unidades de saúde aplicaram mais doses?
 
<br>

**5. Profissionais**
- Qual profissional aplicou mais vacinas?

<br>

**6. Eventos_Adversos**
- Qual a taxa de eventos adversos por tipo de vacina?

<br>

**7. Campanhas_Vacinacao**
- Qual campanha resultou em maior adesão?

<br>

**8. Participacao_Campanha**
- Quantos pacientes participaram de cada campanha?

<br>

**9. Estoque_Vacinas**
- Qual o nível de estoque atual de cada vacina por unidade?

<br>

**10. Lotes_Vacinas**
- Algum lote de vacina está próximo do vencimento?

<br>

**11. Movimentacao_Estoque**
- Qual unidade teve maior movimentação de vacinas no último mês?

<br>

**12. Enderecos_Pacientes**
- Qual bairro/cidade tem maior cobertura vacinal?

<br>

**13. Grupos_Risco**
- Qual grupo de risco foi mais vacinado?

<br>

**14. Paciente_Grupo_Risco**
- Qual a taxa de vacinação entre pacientes de grupos de risco?
