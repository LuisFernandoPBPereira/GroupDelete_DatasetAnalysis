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

GO
DROP TABLE IF EXISTS EstabelecimentoNaturezaEstabelecimento;
DROP TABLE IF EXISTS EstabelecimentoTipoEstabelecimento; 
DROP TABLE IF EXISTS PacientePaisPaciente;
DROP TABLE IF EXISTS PacienteRacaCorPaciente;
DROP TABLE IF EXISTS PacienteCondicaoMaternal;
DROP TABLE IF EXISTS PacienteEtniaIndigenaPaciente
DROP TABLE IF EXISTS PacienteMunicipioPaciente;
DROP TABLE IF EXISTS VacinaCategoriaAtendimento;
DROP TABLE IF EXISTS VacinaGrupoAtendimento;
DROP TABLE IF EXISTS AplicacaoVacinaEstabelecimento;
DROP TABLE IF EXISTS VacinaLocalAplicacao;
DROP TABLE IF EXISTS VacinaFabricanteVacina;
DROP TABLE IF EXISTS AplicacaoVacina;
DROP TABLE IF EXISTS VacinaDoseVacina;
DROP TABLE IF EXISTS VacinaViaAdministracao;

DROP TABLE IF EXISTS Vacina;
DROP TABLE IF EXISTS CategoriaAtendimento;
DROP TABLE IF EXISTS GrupoAtendimento;
DROP TABLE IF EXISTS VacinaFabricante;
DROP TABLE IF EXISTS ViaAdministracao;
DROP TABLE IF EXISTS LocalAplicacao;
DROP TABLE IF EXISTS DoseVacina;

DROP TABLE IF EXISTS Documento;
DROP TABLE IF EXISTS EstrategiaVacinacao;
DROP TABLE IF EXISTS OrigemRegistro;
DROP TABLE IF EXISTS SistemaOrigem;
DROP TABLE IF EXISTS Estabelecimento;
DROP TABLE IF EXISTS NaturezaEstabelecimento;
DROP TABLE IF EXISTS TipoEstabelecimento;
DROP TABLE IF EXISTS MunicipioEstabelecimento;
DROP TABLE IF EXISTS Paciente;
DROP TABLE IF EXISTS MunicipioPaciente;
DROP TABLE IF EXISTS CondicaoMaternal;
DROP TABLE IF EXISTS EtniaIndigenaPaciente;
DROP TABLE IF EXISTS PaisPaciente;
DROP TABLE IF EXISTS RacaCorPaciente;

CREATE TABLE RacaCorPaciente (
    CodigoRacaCorPaciente INT PRIMARY KEY,
    NomeRacaCorPaciente VARCHAR(50)
);

CREATE TABLE PaisPaciente (
    CodigoPaisPaciente INT PRIMARY KEY,
    NomePaisPaciente VARCHAR(100)
);

CREATE TABLE EtniaIndigenaPaciente (
    CodigoEtniaIndigenaPaciente CHAR(4) PRIMARY KEY,
    NomeEtniaIndigenaPaciente VARCHAR(100)
);

CREATE TABLE CondicaoMaternal (
    CodigoCondicaoMaternal INT PRIMARY KEY,
    DescricaoCondicaoMaternal VARCHAR(100)
);

CREATE TABLE MunicipioPaciente (
    CodigoMunicipioPaciente INT PRIMARY KEY,
    NomeMunicipioPaciente VARCHAR(50),
    SgUfPaciente CHAR(2),
    NomeUfPaciente VARCHAR(50)
);

CREATE TABLE Paciente (
    CodigoPaciente CHAR(64) PRIMARY KEY DEFAULT NEWID(),
    TipoSexoPaciente CHAR(1),
    NumeroIdadePaciente INT
);

CREATE TABLE MunicipioEstabelecimento (
    CodigoMunicipioEstabelecimento INT PRIMARY KEY,
    NomeMunicipioEstabelecimento VARCHAR(50),
    SgUfEstabelecimento CHAR(2),
    NomeUfEstabelecimento VARCHAR(50)
);

CREATE TABLE TipoEstabelecimento (
    CodigoTipoEstabelecimento INT PRIMARY KEY,
    DescricaoTipoEstabelecimento VARCHAR(100)
);

CREATE TABLE NaturezaEstabelecimento (
    CodigoNaturezaEstabelecimento INT PRIMARY KEY,
    DescricaoNaturezaEstabelecimento VARCHAR(100)
);

CREATE TABLE Estabelecimento (
    CodigoCnesEstabelecimento CHAR(7) PRIMARY KEY,
    NomeRazaoSocialEstabelecimento VARCHAR(255),
    NomeFantasiaEstalecimento VARCHAR(255),
    CodigoMunicipioEstabelecimento INT FOREIGN KEY REFERENCES MunicipioEstabelecimento(CodigoMunicipioEstabelecimento),
);

CREATE TABLE SistemaOrigem (
    CodigoSistemaOrigem INT PRIMARY KEY,
    DescricaoSistemaOrigem VARCHAR(150)
);

CREATE TABLE OrigemRegistro (
    CodigoOrigemRegistro INT PRIMARY KEY,
    DescricaoOrigemRegistro VARCHAR(100)
);

CREATE TABLE EstrategiaVacinacao (
    CodigoEstrategiaVacinacao INT PRIMARY KEY,
    DescricaoEstrategiaVacinacao VARCHAR(150)
);

CREATE TABLE Documento (
    CodigoDocumento CHAR(41) PRIMARY KEY,
    CodigoPaciente CHAR(64) FOREIGN KEY REFERENCES Paciente(CodigoPaciente),
    CodigoTrocaDocumento CHAR(41) NULL,
    StDocumento VARCHAR(20),
    DataEntradaRnDescricao DATETIME2,
    CodigoSistemaOrigem INT FOREIGN KEY REFERENCES SistemaOrigem(CodigoSistemaOrigem),
    CodigoOrigemRegistro INT FOREIGN KEY REFERENCES OrigemRegistro(CodigoOrigemRegistro),
    CodigoEstrategiaVacinacao INT FOREIGN KEY REFERENCES EstrategiaVacinacao(CodigoEstrategiaVacinacao)
);

CREATE TABLE DoseVacina (
    CodigoDoseVacina INT PRIMARY KEY,
    DescricaoDoseVacina VARCHAR(100)
);

CREATE TABLE LocalAplicacao (
    CodigoLocalAplicacao INT PRIMARY KEY,
    DescricaoLocalAplicacao VARCHAR(150)
);

CREATE TABLE ViaAdministracao (
    CodigoViaAdministracao INT PRIMARY KEY,
    DescricaoViaAdministracao VARCHAR(150)
);

CREATE TABLE VacinaFabricante (
    CodigoVacinaFabricante INT PRIMARY KEY,
    DescricaoVacinaFabricante VARCHAR(150)
);

CREATE TABLE GrupoAtendimento (
    CodigoVacinaGrupoAtendimento INT PRIMARY KEY,
    DescricaoVacinaGrupoAtendimento VARCHAR(150)
);

CREATE TABLE CategoriaAtendimento (
    CodigoVacinaCategoriaAtendimento INT PRIMARY KEY,
    DescricaoVacinaCategoriaAtendimento VARCHAR(150)
);

CREATE TABLE Vacina (
    CodigoVacina INT PRIMARY KEY,
    DescricaoVacina VARCHAR(150)
);

CREATE TABLE AplicacaoVacina (
    IdAplicacao INT IDENTITY PRIMARY KEY,
    CodigoDocumento CHAR(41) FOREIGN KEY REFERENCES Documento(CodigoDocumento),
    CodigoPaciente CHAR(64) FOREIGN KEY REFERENCES Paciente(CodigoPaciente),
    CodigoCnesEstabelecimento CHAR(7) FOREIGN KEY REFERENCES Estabelecimento(CodigoCnesEstabelecimento),
    CodigoVacina INT FOREIGN KEY REFERENCES Vacina(CodigoVacina),
    DataVacina DATE
);

CREATE TABLE VacinaFabricanteVacina (
    CodigoVacinaFabricante INT NOT NULL,
    CodigoVacina INT NOT NULL,
    CONSTRAINT PK_VacinaFabricanteVacina PRIMARY KEY (CodigoVacinaFabricante, CodigoVacina),
    CONSTRAINT FK_VacinaFabricanteVacina_Fabricante 
        FOREIGN KEY (CodigoVacinaFabricante) REFERENCES VacinaFabricante (CodigoVacinaFabricante),
    CONSTRAINT FK_VacinaFabricanteVacina_Vacina 
        FOREIGN KEY (CodigoVacina) REFERENCES Vacina (CodigoVacina)
);

CREATE TABLE AplicacaoVacinaEstabelecimento (
    CodigoCnesEstabelecimento CHAR(7) NOT NULL,
    IdAplicacao INT NOT NULL,
    CONSTRAINT PK_AplicacaoVacinaEstabelecimento PRIMARY KEY (CodigoCnesEstabelecimento, IdAplicacao),
    CONSTRAINT FK_AplicacaoVacinaEstabelecimento_Estabelecimento 
        FOREIGN KEY (CodigoCnesEstabelecimento) REFERENCES Estabelecimento(CodigoCnesEstabelecimento),
    CONSTRAINT FK_AplicacaoVacinaEstabelecimento_AplicacaoVacina 
        FOREIGN KEY (IdAplicacao) REFERENCES AplicacaoVacina(IdAplicacao)
);

CREATE TABLE VacinaLocalAplicacao (
    CodigoLocalAplicacao INT NOT NULL,
    CodigoVacina INT NOT NULL,
    CONSTRAINT PK_VacinaLocalAplicacao PRIMARY KEY (CodigoLocalAplicacao, CodigoVacina),
    CONSTRAINT FK_VacinaLocalAplicacao_LocalAplicacao 
        FOREIGN KEY (CodigoLocalAplicacao) REFERENCES LocalAplicacao(CodigoLocalAplicacao),
    CONSTRAINT FK_VacinaLocalAplicacao_Vacina 
        FOREIGN KEY (CodigoVacina) REFERENCES Vacina(CodigoVacina)
);

CREATE TABLE VacinaDoseVacina (
    CodigoVacina INT NOT NULL,
    CodigoDoseVacina INT NOT NULL,
    CONSTRAINT PK_VacinaDoseVacina PRIMARY KEY (CodigoVacina, CodigoDoseVacina),
    CONSTRAINT FK_VacinaDoseVacina_Vacina 
        FOREIGN KEY (CodigoVacina) REFERENCES Vacina(CodigoVacina),
    CONSTRAINT FK_VacinaDoseVacina_DoseVacina 
        FOREIGN KEY (CodigoDoseVacina) REFERENCES DoseVacina(CodigoDoseVacina)
);

CREATE TABLE VacinaViaAdministracao (
    CodigoVacina INT NOT NULL,
    CodigoViaAdministracao INT NOT NULL,
    CONSTRAINT PK_VacinaViaAdministracao PRIMARY KEY (CodigoVacina, CodigoViaAdministracao),
    CONSTRAINT FK_VacinaViaAdministracao_Vacina 
        FOREIGN KEY (CodigoVacina) REFERENCES Vacina(CodigoVacina),
    CONSTRAINT FK_VacinaViaAdministracao_ViaAdministracao 
        FOREIGN KEY (CodigoViaAdministracao) REFERENCES ViaAdministracao(CodigoViaAdministracao)
);

CREATE TABLE VacinaGrupoAtendimento (
    CodigoVacina INT NOT NULL,
    CodigoVacinaGrupoAtendimento INT NOT NULL,
    CONSTRAINT PK_VacinaGrupoAtendimento PRIMARY KEY (CodigoVacina, CodigoVacinaGrupoAtendimento),
    CONSTRAINT FK_VacinaGrupoAtendimento_Vacina 
        FOREIGN KEY (CodigoVacina) REFERENCES Vacina(CodigoVacina),
    CONSTRAINT FK_VacinaGrupoAtendimento_GrupoAtendimento 
        FOREIGN KEY (CodigoVacinaGrupoAtendimento) REFERENCES GrupoAtendimento(CodigoVacinaGrupoAtendimento)
);

CREATE TABLE VacinaCategoriaAtendimento(
    CodigoVacina INT NOT NULL,
    CodigoVacinaCategoriaAtendimento INT NOT NULL,
    CONSTRAINT PK_VacinaCategoriaAtendimento PRIMARY KEY (CodigoVacina, CodigoVacinaCategoriaAtendimento),
    CONSTRAINT FK_VacinaCategoriaAtendimento_Vacina FOREIGN KEY (CodigoVacina) REFERENCES Vacina(CodigoVacina),
    CONSTRAINT FK_VacinaCategoriaAtendimento_CategoriaAtendimento FOREIGN KEY (CodigoVacinaCategoriaAtendimento) REFERENCES CategoriaAtendimento(CodigoVacinaCategoriaAtendimento)

);

CREATE TABLE PacienteMunicipioPaciente(
    CodigoPaciente CHAR(64) NOT NULL,
    CodigoMunicipioPaciente INT NOT NULL,
    CONSTRAINT FK_PacienteMunicipioPaciente_Paciente FOREIGN KEY (CodigoPaciente) REFERENCES Paciente(CodigoPaciente),
    CONSTRAINT FK_PacienteMunicipioPaciente_MunicipioPaciente FOREIGN KEY (CodigoMunicipioPaciente) REFERENCES MunicipioPaciente(CodigoMunicipioPaciente)

);

CREATE TABLE PacienteRacaCorPaciente(
    CodigoPaciente CHAR(64) NOT NULL,
    CodigoRacaCorPaciente INT NOT NULL,
    CONSTRAINT FK_PacienteRacaCorPaciente_Paciente FOREIGN KEY (CodigoPaciente) REFERENCES Paciente(CodigoPaciente),
    CONSTRAINT FK_PacienteRacaCorPaciente_RacaCorPaciente FOREIGN KEY (CodigoRacaCorPaciente) REFERENCES RacaCorPaciente(CodigoRacaCorPaciente)
);

CREATE TABLE PacienteCondicaoMaternal(
     CodigoPaciente CHAR(64) NOT NULL,
     CodigoCondicaoMaternal INT NOT NULL,
     CONSTRAINT FK_PacienteCondicaoMaternal_Paciente FOREIGN KEY (CodigoPaciente) REFERENCES Paciente(CodigoPaciente),
     CONSTRAINT FK_PacienteCondicaoMaternal_CondicaoMaternal FOREIGN KEY (CodigoCondicaoMaternal) REFERENCES CondicaoMaternal(CodigoCondicaoMaternal)
);

CREATE TABLE PacienteEtniaIndigenaPaciente(
     CodigoPaciente CHAR(64) NOT NULL,
     CodigoEtniaIndigenaPaciente CHAR(4) NOT NULL,
     CONSTRAINT FK_PacienteEtniaIndigenaPaciente_Paciente FOREIGN KEY (CodigoPaciente) REFERENCES Paciente(CodigoPaciente),
     CONSTRAINT FK_PacienteEtniaIndigenaPaciente_EtniaIndigenaPaciente FOREIGN KEY (CodigoEtniaIndigenaPaciente) REFERENCES EtniaIndigenaPaciente(CodigoEtniaIndigenaPaciente)  
);

CREATE TABLE PacientePaisPaciente(
     CodigoPaciente CHAR(64) NOT NULL,
     CodigoPaisPaciente INT NOT NULL,
     CONSTRAINT FK_PacientePaisPaciente_Paciente FOREIGN KEY (CodigoPaciente) REFERENCES Paciente(CodigoPaciente),
     CONSTRAINT FK_PacientePaisPaciente_CodigoPaisPaciente FOREIGN KEY (CodigoPaisPaciente) REFERENCES PaisPaciente (CodigoPaisPaciente)  
);

CREATE TABLE EstabelecimentoTipoEstabelecimento(
    CodigoCnesEstabelecimento CHAR(7) NOT NULL,
    CodigoTipoEstabelecimento INT NOT NULL,
    CONSTRAINT FK_EstabelecimentoTipoEstabelecimento_Estabelecimento FOREIGN KEY (CodigoCnesEstabelecimento) REFERENCES Estabelecimento(CodigoCnesEstabelecimento),
    CONSTRAINT FK_EstabelecimentoTipoEstabelecimento_TipoEstabelecimento FOREIGN KEY (CodigoTipoEstabelecimento) REFERENCES TipoEstabelecimento(CodigoTipoEstabelecimento)
);

CREATE TABLE EstabelecimentoNaturezaEstabelecimento(
    CodigoCnesEstabelecimento CHAR(7) NOT NULL,
    CodigoNaturezaEstabelecimento INT NOT NULL,
    CONSTRAINT FK_EstabelecimentoNaturezaEstabelecimento_Estabelecimento FOREIGN KEY (CodigoCnesEstabelecimento) REFERENCES Estabelecimento (CodigoCnesEstabelecimento),
    CONSTRAINT FK_EstabelecimentoNaturezaEstabelecimento_NaturezaEstabelecimento FOREIGN KEY (CodigoNaturezaEstabelecimento) REFERENCES NaturezaEstabelecimento (CodigoNaturezaEstabelecimento)
);
