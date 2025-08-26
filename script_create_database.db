CREATE DATABASE DB_VACINACAO;

USE DB_VACINACAO;


CREATE TABLE RacaCorPaciente (
    CodigoRacaCorPaciente INT PRIMARY KEY,
    NomeRacaCorPaciente VARCHAR(100)
);


CREATE TABLE PaisPaciente (
    CodigoPaisPaciente INT PRIMARY KEY,
    NomePaisPaciente VARCHAR(100)
);


CREATE TABLE EtniaIndigenaPaciente (
    CodigoEtniaIndigenaPaciente INT PRIMARY KEY,
    NomeEtniaIndigenaPaciente VARCHAR(150)
);


CREATE TABLE CondicaoMaternal (
    CodigoCondicaoMaternal INT PRIMARY KEY,
    DescricaoCondicaoMaternal VARCHAR(150)
);

CREATE TABLE MunicipioPaciente (
    CodigoMunicipioPaciente INT PRIMARY KEY,
    NomeMunicipioPaciente VARCHAR(150),
    SgUfPaciente CHAR(2),
    NomeUfPaciente VARCHAR(100),
    NumeroCepPaciente VARCHAR(20)
);

CREATE TABLE Paciente (
    CodigoPaciente BIGINT PRIMARY KEY,
    TipoSexoPaciente CHAR(1),
    CodigoRacaCorPaciente INT FOREIGN KEY REFERENCES RacaCorPaciente(CodigoRacaCorPaciente),
    CodigoMunicipioPaciente INT FOREIGN KEY REFERENCES MunicipioPaciente(CodigoMunicipioPaciente),
    CodigoPaisPaciente INT FOREIGN KEY REFERENCES PaisPaciente(CodigoPaisPaciente),
    CodigoEtniaIndigenaPaciente INT NULL FOREIGN KEY REFERENCES EtniaIndigenaPaciente(CodigoEtniaIndigenaPaciente),
    NumeroIdadePaciente INT,
    CodigoCondicaoMaternal INT NULL FOREIGN KEY REFERENCES CondicaoMaternal(CodigoCondicaoMaternal),
    DescricaoNacionalidadePaciente VARCHAR(100)
);

CREATE TABLE MunicipioEstabelecimento (
    CodigoMunicipioEstabelecimento INT PRIMARY KEY,
    NomeMunicipioEstabelecimento VARCHAR(150),
    SgUfEstabelecimento CHAR(2),
    NomeUfEstabelecimento VARCHAR(100)
);

CREATE TABLE TipoEstabelecimento (
    CodigoTipoEstabelecimento INT PRIMARY KEY,
    DescricaoTipoEstabelecimento VARCHAR(150)
);

CREATE TABLE NaturezaEstabelecimento (
    CodigoNaturezaEstabelecimento INT PRIMARY KEY,
    DescricaoNaturezaEstabelecimento VARCHAR(150)
);

CREATE TABLE Estabelecimento (
    CodigoCnesEstabelecimento BIGINT PRIMARY KEY,
    NomeRazaoSocialEstabelecimento VARCHAR(255),
    NomeFantasiaEstalecimento VARCHAR(255),
    CodigoMunicipioEstabelecimento INT FOREIGN KEY REFERENCES MunicipioEstabelecimento(CodigoMunicipioEstabelecimento),
    CodigoTipoEstabelecimento INT FOREIGN KEY REFERENCES TipoEstabelecimento(CodigoTipoEstabelecimento),
    CodigoNaturezaEstabelecimento INT FOREIGN KEY REFERENCES NaturezaEstabelecimento(CodigoNaturezaEstabelecimento)
);

CREATE TABLE SistemaOrigem (
    CodigoSistemaOrigem INT PRIMARY KEY,
    DescricaoSistemaOrigem VARCHAR(150)
);

CREATE TABLE OrigemRegistro (
    CodigoOrigemRegistro INT PRIMARY KEY,
    DescricaoOrigemRegistro VARCHAR(150)
);

CREATE TABLE EstrategiaVacinacao (
    CodigoEstrategiaVacinacao INT PRIMARY KEY,
    DescricaoEstrategiaVacinacao VARCHAR(150)
);

CREATE TABLE Documento (
    CodigoDocumento BIGINT PRIMARY KEY,
    CodigoPaciente BIGINT FOREIGN KEY REFERENCES Paciente(CodigoPaciente),
    CodigoTrocaDocumento BIGINT NULL,
    StDocumento BIT,
    DataEntradaRnDescricao DATETIME,
    DataDeletadoRnDescricao DATETIME NULL,
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
    CodigoVacina BIGINT PRIMARY KEY,
    SgVacina VARCHAR(50),
    CodigoDoseVacina INT FOREIGN KEY REFERENCES DoseVacina(CodigoDoseVacina),
    CodigoLocalAplicacao INT FOREIGN KEY REFERENCES LocalAplicacao(CodigoLocalAplicacao),
    CodigoViaAdministracao INT FOREIGN KEY REFERENCES ViaAdministracao(CodigoViaAdministracao),
    CodigoVacinaFabricante INT FOREIGN KEY REFERENCES VacinaFabricante(CodigoVacinaFabricante),
    CodigoVacinaGrupoAtendimento INT FOREIGN KEY REFERENCES GrupoAtendimento(CodigoVacinaGrupoAtendimento),
    CodigoVacinaCategoriaAtendimento INT FOREIGN KEY REFERENCES CategoriaAtendimento(CodigoVacinaCategoriaAtendimento),
    CodigoLoteVacina VARCHAR(100)
);

CREATE TABLE AplicacaoVacina (
    IdAplicacao BIGINT IDENTITY PRIMARY KEY,
    CodigoDocumento BIGINT FOREIGN KEY REFERENCES Documento(CodigoDocumento),
    CodigoPaciente BIGINT FOREIGN KEY REFERENCES Paciente(CodigoPaciente),
    CodigoCnesEstabelecimento BIGINT FOREIGN KEY REFERENCES Estabelecimento(CodigoCnesEstabelecimento),
    CodigoVacina BIGINT FOREIGN KEY REFERENCES Vacina(CodigoVacina),
    DataVacina DATE
);

