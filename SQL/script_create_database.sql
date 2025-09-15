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

DROP TABLE IF EXISTS AplicacaoVacinaEstabelecimento;
DROP TABLE IF EXISTS VacinaLocalAplicacao;
DROP TABLE IF EXISTS VacinaFabricanteVacina;
DROP TABLE IF EXISTS AplicacaoVacina;
DROP TABLE IF EXISTS VacinaDoseVacina;
DROP TABLE IF EXISTS VacinaViaAdmnistracao;

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
    CodigoPaciente UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    TipoSexoPaciente CHAR(1),
    CodigoRacaCorPaciente INT FOREIGN KEY REFERENCES RacaCorPaciente(CodigoRacaCorPaciente),
    CodigoMunicipioPaciente INT FOREIGN KEY REFERENCES MunicipioPaciente(CodigoMunicipioPaciente),
    CodigoPaisPaciente INT FOREIGN KEY REFERENCES PaisPaciente(CodigoPaisPaciente),
    CodigoEtniaIndigenaPaciente CHAR(4) NULL FOREIGN KEY REFERENCES EtniaIndigenaPaciente(CodigoEtniaIndigenaPaciente),
    NumeroIdadePaciente INT,
    CodigoCondicaoMaternal INT NULL FOREIGN KEY REFERENCES CondicaoMaternal(CodigoCondicaoMaternal),
    DescricaoNacionalidadePaciente VARCHAR(100),
    NumeroCepPaciente VARCHAR(8)
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
    CodigoCnesEstabelecimento INT PRIMARY KEY,
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
    DescricaoOrigemRegistro VARCHAR(100)
);

CREATE TABLE EstrategiaVacinacao (
    CodigoEstrategiaVacinacao INT PRIMARY KEY,
    DescricaoEstrategiaVacinacao VARCHAR(150)
);

CREATE TABLE Documento (
    CodigoDocumento UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CodigoPaciente UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Paciente(CodigoPaciente),
    CodigoTrocaDocumento UNIQUEIDENTIFIER NULL,
    StDocumento VARCHAR(20),
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
    CodigoVacina INT PRIMARY KEY,
    DescricaoVacina VARCHAR(150),
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
    IdAplicacao INT IDENTITY PRIMARY KEY,
    CodigoDocumento UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Documento(CodigoDocumento),
    CodigoPaciente UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Paciente(CodigoPaciente),
    CodigoCnesEstabelecimento INT FOREIGN KEY REFERENCES Estabelecimento(CodigoCnesEstabelecimento),
    CodigoVacina INT FOREIGN KEY REFERENCES Vacina(CodigoVacina),
    DataVacina DATE
);


CREATE TABLE VacinaFabricanteVacina (
    CodigoVacinaFabricante INT NOT NULL,
    CodigoVacina INT NOT NULL,
    
    CONSTRAINT PK_VacinaFabricanteVacina PRIMARY KEY (CodigoVacinaFabricante, CodigoVacina),
    CONSTRAINT FK_VacinaFabricanteVacina_Fabricante FOREIGN KEY (CodigoVacinaFabricante) REFERENCES VacinaFabricante (CodigoVacinaFabricante),
    CONSTRAINT FK_VacinaFabricanteVacina_Vacina FOREIGN KEY (CodigoVacina) REFERENCES Vacina (CodigoVacina)
);

CREATE TABLE AplicacaoVacinaEstabelecimento (
    CodigoCnesEstabelecimento INT NOT NULL,
    IdAplicacao INT NOT NULL,
    CONSTRAINT PK_AplicacaoVacinaEstabelecimento PRIMARY KEY (CodigoCnesEstabelecimento, IdAplicacao),  
    CONSTRAINT FK_AplicacaoVacinaEstabelecimento_Estabelecimento FOREIGN KEY (CodigoCnesEstabelecimento) REFERENCES Estabelecimento(CodigoCnesEstabelecimento),
    CONSTRAINT FK_AplicacaoVacinaEstabelecimento_AplicacaoVacina FOREIGN KEY (IdAplicacao) REFERENCES AplicacaoVacina(IdAplicacao) 

);

CREATE TABLE VacinaLocalAplicacao (
    CodigoLocalAplicacao INT NOT NULL,
    CodigoVacina INT NOT NULL,
    CONSTRAINT PK_VacinaLocalAplicacao PRIMARY KEY (CodigoLocalAplicacao, CodigoVacina),
    CONSTRAINT FK_VacinaLocalAplicacao_LocalAplicacao FOREIGN KEY (CodigoLocalAplicacao) REFERENCES LocalAplicacao(CodigoLocalAplicacao), -- << Altere se o nome da tabela/coluna for outro   
    CONSTRAINT FK_VacinaLocalAplicacao_Vacina FOREIGN KEY (CodigoVacina) REFERENCES Vacina(CodigoVacina)
);

CREATE TABLE VacinaDoseVacina(
    CodigoVacina INT NOT NULL,
    CodigoDoseVacina INT NOT NULL,
    CONSTRAINT PK_VacinaDoseVacina PRIMARY KEY (CodigoVacina,CodigoDoseVacina),
    CONSTRAINT FK_VacinaDoseVacina_Vacina FOREIGN KEY (CodigoVacina) REFERENCES Vacina(CodigoVacina),
    CONSTRAINT FK_VacinaDoseVacina_CodigoDoseVacina FOREIGN KEY (CodigoDoseVacina) REFERENCES DoseVacina(CodigoDoseVacina)
);

CREATE TABLE VacinaViaAdmnistracao(
    CodigoVacina INT NOT NULL,
    CodigoViaAdministracao INT NOT NULL,
    CONSTRAINT PK_VacinaViaAdmnistracao PRIMARY KEY (CodigoVacina,CodigoViaAdministracao),
    CONSTRAINT FK_VacinaViaAdmnistracao_Vacina FOREIGN KEY (CodigoVacina) REFERENCES Vacina(CodigoVacina),
    CONSTRAINT FK_VacinaViaAdmnistracao_CodigoViaAdministracao FOREIGN KEY (CodigoViaAdministracao) REFERENCES ViaAdministracao(CodigoViaAdministracao)

);
