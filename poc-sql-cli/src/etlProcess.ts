interface RawData {
    co_documento: string | null;
    co_paciente: string | null;
    tp_sexo_paciente: string | null;
    co_raca_cor_paciente: string | null;
    no_raca_cor_paciente: string | null;
    co_municipio_paciente: string | null;
    no_pais_paciente: string | null;
    sg_uf_paciente: string | null;
    nu_cep_paciente: string | null;
    ds_nacionalidade_paciente: string | null;
    no_etnia_indigena_paciente: string | null;
    co_etnia_indigena_paciente: string | null;
    co_cnes_estabelecimento: string | null;
    no_razao_social_estabelecimento: string | null;
    no_fantasia_estabelecimento: string | null;
    co_municipio_estabelecimento: string | null;
    no_municipio_estabelecimento: string | null;
    sg_uf_estabelecimento: string | null;
    co_troca_documento: string | null;
    co_vacina: string | null;
    sg_vacina: string | null;
    dt_vacina: string | null;
    co_dose_vacina: string | null;
    ds_dose_vacina: string | null;
    co_local_aplicacao: string | null;
    ds_local_aplicacao: string | null;
    co_via_administracao: string | null;
    ds_via_administracao: string | null;
    co_lote_vacina: string | null;
    ds_vacina_fabricante: string | null;
    dt_entrada_rnds: string | null;
    co_sistema_origem: string | null;
    ds_sistema_origem: string | null;
    st_documento: string | null;
    co_estrategia_vacinacao: string | null;
    ds_estrategia_vacinacao: string | null;
    co_origem_registro: string | null;
    ds_origem_registro: string | null;
    co_vacina_grupo_atendimento: string | null;
    ds_vacina_grupo_atendimento: string | null;
    co_vacina_categoria_atendimento: string | null;
    ds_vacina_categoria_atendimento: string | null;
    co_vacina_fabricante: string | null;
    ds_vacina: string | null;
    ds_condicao_maternal: string | null;
    co_tipo_estabelecimento: string | null;
    ds_tipo_estabelecimento: string | null;
    co_natureza_estabelecimento: string | null;
    ds_natureza_estabelecimento: string | null;
    nu_idade_paciente: string | null;
    co_condicao_maternal: string | null;
    no_uf_paciente: string | null;
    no_uf_estabelecimento: string | null;
    dt_deletado_rnds: string | null;
}

interface AplicacaoVacina {
  idAplicacao: number;
  codigoDocumento: number;
  codigoPaciente: number;
  codigoCnesEstabelecimento: number;
  codigoVacina: number;
  dataVacina: Date;
}

interface CategoriaAtendimento {
  codigoVacinaCategoriaAtendimento: number;
  descricaoVacinaCategoriaAtendimento: string | null;
}

interface CondicaoMaternal {
  codigoCondicaoMaternal: number;
  descricaoCondicaoMaternal: string | null;
}

interface Documento {
  codigoDocumento: number;
  codigoPaciente: number;
  codigoTrocaDocumento: number;
  stDocumento: boolean | null;
  dataEntradaRnDescricao: Date | null;
  dataDeletadoRnDescricao: Date | null;
  codigoSistemaOrigem: number | null;
  codigoOrigemRegistro: number | null;
  codigoEstrategiaVacinacao: number | null;
}

interface DoseVacina {
  codigoDoseVacina: number;
  descricaoDoseVacina: string | null;
}


interface Estabelecimento {
  codigoCnesEstabelecimento: number;
  nomeRazaoSocialEstabelecimento: string;
  nomeFantasiaEstalecimento: string;
  codigoMunicipioEstabelecimento: number;
  codigoTipoEstabelecimento: number;
  codigoNaturezaEstabelecimento: number;
}


interface EstrategiaVacinacao {
  codigoEstrategiaVacinacao: number;
  descricaoEstrategiaVacinacao: string;
}


interface EtniaIndigenaPaciente {
  codigoEtniaIndigenaPaciente: number;
  nomeEtniaIndigenaPaciente: string;
}


interface GrupoAtendimento {
  codigoVacinaGrupoAtendimento: number;
  descricaoVacinaGrupoAtendimento: string;
}


interface LocalAplicacao {
  codigoLocalAplicacao: number;
  descricaoLocalAplicacao: string;
}


interface MunicipioEstabelecimento {
  codigoMunicipioEstabelecimento: number;
  nomeMunicipioEstabelecimento: string;
  sgUfEstabelecimento: string;
  nomeUfEstabelecimento: string;
}


interface MunicipioPaciente {
  codigoMunicipioPaciente: number;
  nomeMunicipioPaciente: string;
  sgUfPaciente: string;
  nomeUfPaciente: string;
  numeroCepPaciente: string;
}


interface NaturezaEstabelecimento {
  codigoNaturezaEstabelecimento: number;
  descricaoNaturezaEstabelecimento: string;
}


interface OrigemRegistro {
  codigoOrigemRegistro: number;
  descricaoOrigemRegistro: string;
}


interface Paciente {
  codigoPaciente: number;
  tipoSexoPaciente: string;
  codigoRacaCorPaciente: number;
  codigoMunicipioPaciente: number;
  codigoPaisPaciente: number;
  codigoEtniaIndigenaPaciente?: number | null;
  numeroIdadePaciente: number;
  codigoCondicaoMaternal?: number | null;
  descricaoNacionalidadePaciente: string;
}


interface PaisPaciente {
  codigoPaisPaciente: number;
  nomePaisPaciente: string;
}


interface RacaCor {
  codigoRacaCorPaciente: number;
  nomeRacaCorPaciente: string;
}


interface SistemaOrigem {
  codigoSistemaOrigem: number;
  descricaoSistemaOrigem: string;
}


interface TipoEstabelecimento {
  codigoTipoEstabelecimento: number;
  descricaoTipoEstabelecimento: string;
}


interface Vacina {
  codigoVacina: number;
  sgVacina: string;
  codigoDoseVacina: number;
  codigoLocalAplicacao: number;
  codigoViaAdministracao: number;
  codigoVacinaFabricante: number;
  codigoVacinaGrupoAtendimento: number;
  codigoVacinaCategoriaAtendimento: number;
  codigoLoteVacina: string;
}

interface ViaAdministracao {
  codigoViaAdministracao: number;
  descricaoViaAdministracao: string;
}

interface VacinaFabricante {
  codigoVacinaFabricante: number;
  descricaoVacinaFabricante: string;
}