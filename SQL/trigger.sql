-- Criação da tabela de log
CREATE TABLE LogOperacoes (
    IdLog INT IDENTITY(1,1) PRIMARY KEY,
    NomeTabela VARCHAR(100),
    TipoOperacao VARCHAR(20),
    DataOperacao DATETIME2,
    UsuarioOperacao VARCHAR(100),
    Detalhes VARCHAR(MAX)
);
GO

-- Trigger para RacaCorPaciente
CREATE OR ALTER TRIGGER TR_RacaCorPaciente_Insert
ON RacaCorPaciente
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'RacaCorPaciente',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova raça/cor inserida - Código: ', i.CodigoRacaCorPaciente, 
               ', Nome: ', i.NomeRacaCorPaciente)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela RacaCorPaciente';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para PaisPaciente
CREATE OR ALTER TRIGGER TR_PaisPaciente_Insert
ON PaisPaciente
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'PaisPaciente',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Novo país inserido - Código: ', i.CodigoPaisPaciente, 
               ', Nome: ', i.NomePaisPaciente)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela PaisPaciente';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para EtniaIndigenaPaciente
CREATE OR ALTER TRIGGER TR_EtniaIndigenaPaciente_Insert
ON EtniaIndigenaPaciente
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'EtniaIndigenaPaciente',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova etnia indígena inserida - Código: ', i.CodigoEtniaIndigenaPaciente, 
               ', Nome: ', i.NomeEtniaIndigenaPaciente)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela EtniaIndigenaPaciente';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para CondicaoMaternal
CREATE OR ALTER TRIGGER TR_CondicaoMaternal_Insert
ON CondicaoMaternal
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'CondicaoMaternal',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova condição maternal inserida - Código: ', i.CodigoCondicaoMaternal, 
               ', Descrição: ', i.DescricaoCondicaoMaternal)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela CondicaoMaternal';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para MunicipioPaciente
CREATE OR ALTER TRIGGER TR_MunicipioPaciente_Insert
ON MunicipioPaciente
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'MunicipioPaciente',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Novo município inserido - Código: ', i.CodigoMunicipioPaciente, 
               ', Nome: ', i.NomeMunicipioPaciente,
               ', UF: ', i.SgUfPaciente)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela MunicipioPaciente';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para Paciente
CREATE OR ALTER TRIGGER TR_Paciente_Insert
ON Paciente
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'Paciente',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Novo paciente inserido - ID: ', i.CodigoPaciente, 
               ', Sexo: ', i.TipoSexoPaciente,
               ', Idade: ', i.NumeroIdadePaciente)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela Paciente';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para MunicipioEstabelecimento
CREATE OR ALTER TRIGGER TR_MunicipioEstabelecimento_Insert
ON MunicipioEstabelecimento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'MunicipioEstabelecimento',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Novo município estabelecimento inserido - Código: ', i.CodigoMunicipioEstabelecimento, 
               ', Nome: ', i.NomeMunicipioEstabelecimento,
               ', UF: ', i.SgUfEstabelecimento)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela MunicipioEstabelecimento';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para TipoEstabelecimento
CREATE OR ALTER TRIGGER TR_TipoEstabelecimento_Insert
ON TipoEstabelecimento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'TipoEstabelecimento',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Novo tipo estabelecimento inserido - Código: ', i.CodigoTipoEstabelecimento, 
               ', Descrição: ', i.DescricaoTipoEstabelecimento)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela TipoEstabelecimento';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para NaturezaEstabelecimento
CREATE OR ALTER TRIGGER TR_NaturezaEstabelecimento_Insert
ON NaturezaEstabelecimento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'NaturezaEstabelecimento',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova natureza estabelecimento inserida - Código: ', i.CodigoNaturezaEstabelecimento, 
               ', Descrição: ', i.DescricaoNaturezaEstabelecimento)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela NaturezaEstabelecimento';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para Estabelecimento
CREATE OR ALTER TRIGGER TR_Estabelecimento_Insert
ON Estabelecimento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'Estabelecimento',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Novo estabelecimento inserido - CNES: ', i.CodigoCnesEstabelecimento, 
               ', Nome: ', i.NomeRazaoSocialEstabelecimento)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela Estabelecimento';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para SistemaOrigem
CREATE OR ALTER TRIGGER TR_SistemaOrigem_Insert
ON SistemaOrigem
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'SistemaOrigem',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Novo sistema origem inserido - Código: ', i.CodigoSistemaOrigem, 
               ', Descrição: ', i.DescricaoSistemaOrigem)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela SistemaOrigem';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para OrigemRegistro
CREATE OR ALTER TRIGGER TR_OrigemRegistro_Insert
ON OrigemRegistro
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'OrigemRegistro',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova origem registro inserida - Código: ', i.CodigoOrigemRegistro, 
               ', Descrição: ', i.DescricaoOrigemRegistro)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela OrigemRegistro';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para EstrategiaVacinacao
CREATE OR ALTER TRIGGER TR_EstrategiaVacinacao_Insert
ON EstrategiaVacinacao
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'EstrategiaVacinacao',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova estratégia vacinação inserida - Código: ', i.CodigoEstrategiaVacinacao, 
               ', Descrição: ', i.DescricaoEstrategiaVacinacao)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela EstrategiaVacinacao';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para Documento
CREATE OR ALTER TRIGGER TR_Documento_Insert
ON Documento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'Documento',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Novo documento inserido - ID: ', i.CodigoDocumento, 
               ', Status: ', i.StDocumento,
               ', Data Entrada: ', i.DataEntradaRnDescricao)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela Documento';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para DoseVacina
CREATE OR ALTER TRIGGER TR_DoseVacina_Insert
ON DoseVacina
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'DoseVacina',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova dose vacina inserida - Código: ', i.CodigoDoseVacina, 
               ', Descrição: ', i.DescricaoDoseVacina)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela DoseVacina';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para LocalAplicacao
CREATE OR ALTER TRIGGER TR_LocalAplicacao_Insert
ON LocalAplicacao
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'LocalAplicacao',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Novo local aplicação inserido - Código: ', i.CodigoLocalAplicacao, 
               ', Descrição: ', i.DescricaoLocalAplicacao)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela LocalAplicacao';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para ViaAdministracao
CREATE OR ALTER TRIGGER TR_ViaAdministracao_Insert
ON ViaAdministracao
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'ViaAdministracao',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova via administração inserida - Código: ', i.CodigoViaAdministracao, 
               ', Descrição: ', i.DescricaoViaAdministracao)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela ViaAdministracao';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para VacinaFabricante
CREATE OR ALTER TRIGGER TR_VacinaFabricante_Insert
ON VacinaFabricante
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'VacinaFabricante',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Novo fabricante vacina inserido - Código: ', i.CodigoVacinaFabricante, 
               ', Descrição: ', i.DescricaoVacinaFabricante)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela VacinaFabricante';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para GrupoAtendimento
CREATE OR ALTER TRIGGER TR_GrupoAtendimento_Insert
ON GrupoAtendimento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'GrupoAtendimento',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Novo grupo atendimento inserido - Código: ', i.CodigoVacinaGrupoAtendimento, 
               ', Descrição: ', i.DescricaoVacinaGrupoAtendimento)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela GrupoAtendimento';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para CategoriaAtendimento
CREATE OR ALTER TRIGGER TR_CategoriaAtendimento_Insert
ON CategoriaAtendimento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'CategoriaAtendimento',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova categoria atendimento inserida - Código: ', i.CodigoVacinaCategoriaAtendimento, 
               ', Descrição: ', i.DescricaoVacinaCategoriaAtendimento)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela CategoriaAtendimento';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para Vacina
CREATE OR ALTER TRIGGER TR_Vacina_Insert
ON Vacina
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'Vacina',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova vacina inserida - Código: ', i.CodigoVacina, 
               ', Descrição: ', i.DescricaoVacina)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela Vacina';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para AplicacaoVacina
CREATE OR ALTER TRIGGER TR_AplicacaoVacina_Insert
ON AplicacaoVacina
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'AplicacaoVacina',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova aplicação de vacina - Documento: ', i.CodigoDocumento, 
               ', Paciente: ', i.CodigoPaciente,
               ', Data: ', i.DataVacina)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela AplicacaoVacina';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

CREATE OR ALTER TRIGGER TR_VacinaFabricanteVacina_Insert
ON VacinaFabricanteVacina
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'VacinaFabricanteVacina',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova relação vacina-fabricante inserida - Código Fabricante: ', i.CodigoVacinaFabricante, 
               ', Código Vacina: ', i.CodigoVacina)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela VacinaFabricanteVacina';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para AplicacaoVacinaEstabelecimento
CREATE OR ALTER TRIGGER TR_AplicacaoVacinaEstabelecimento_Insert
ON AplicacaoVacinaEstabelecimento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'AplicacaoVacinaEstabelecimento',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova relação aplicação-estabelecimento inserida - CNES: ', i.CodigoCnesEstabelecimento, 
               ', ID Aplicação: ', i.IdAplicacao)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela AplicacaoVacinaEstabelecimento';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para VacinaLocalAplicacao
CREATE OR ALTER TRIGGER TR_VacinaLocalAplicacao_Insert
ON VacinaLocalAplicacao
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'VacinaLocalAplicacao',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova relação vacina-local inserida - Código Local: ', i.CodigoLocalAplicacao, 
               ', Código Vacina: ', i.CodigoVacina)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela VacinaLocalAplicacao';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para VacinaDoseVacina
CREATE OR ALTER TRIGGER TR_VacinaDoseVacina_Insert
ON VacinaDoseVacina
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'VacinaDoseVacina',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova relação vacina-dose inserida - Código Vacina: ', i.CodigoVacina, 
               ', Código Dose: ', i.CodigoDoseVacina)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela VacinaDoseVacina';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para VacinaViaAdministracao
CREATE OR ALTER TRIGGER TR_VacinaViaAdministracao_Insert
ON VacinaViaAdministracao
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'VacinaViaAdministracao',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova relação vacina-via inserida - Código Vacina: ', i.CodigoVacina, 
               ', Código Via: ', i.CodigoViaAdministracao)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela VacinaViaAdministracao';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para VacinaGrupoAtendimento
CREATE OR ALTER TRIGGER TR_VacinaGrupoAtendimento_Insert
ON VacinaGrupoAtendimento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'VacinaGrupoAtendimento',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova relação vacina-grupo inserida - Código Vacina: ', i.CodigoVacina, 
               ', Código Grupo: ', i.CodigoVacinaGrupoAtendimento)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela VacinaGrupoAtendimento';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para VacinaCategoriaAtendimento
CREATE OR ALTER TRIGGER TR_VacinaCategoriaAtendimento_Insert
ON VacinaCategoriaAtendimento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'VacinaCategoriaAtendimento',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova relação vacina-categoria inserida - Código Vacina: ', i.CodigoVacina, 
               ', Código Categoria: ', i.CodigoVacinaCategoriaAtendimento)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela VacinaCategoriaAtendimento';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para EstabelecimentoTipoEstabelecimento
CREATE OR ALTER TRIGGER TR_EstabelecimentoTipoEstabelecimento_Insert
ON EstabelecimentoTipoEstabelecimento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'EstabelecimentoTipoEstabelecimento',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova relação estabelecimento-tipo inserida - CNES: ', i.CodigoCnesEstabelecimento, 
               ', Código Tipo: ', i.CodigoTipoEstabelecimento)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela EstabelecimentoTipoEstabelecimento';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO

-- Trigger para EstabelecimentoNaturezaEstabelecimento
CREATE OR ALTER TRIGGER TR_EstabelecimentoNaturezaEstabelecimento_Insert
ON EstabelecimentoNaturezaEstabelecimento
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO LogOperacoes (NomeTabela, TipoOperacao, DataOperacao, UsuarioOperacao, Detalhes)
    SELECT 
        'EstabelecimentoNaturezaEstabelecimento',
        'INSERT',
        GETDATE(),
        SYSTEM_USER,
        CONCAT('Nova relação estabelecimento-natureza inserida - CNES: ', i.CodigoCnesEstabelecimento, 
               ', Código Natureza: ', i.CodigoNaturezaEstabelecimento)
    FROM inserted i;

    PRINT 'Um novo registro foi inserido na tabela EstabelecimentoNaturezaEstabelecimento';
    SELECT * FROM LogOperacoes WHERE IdLog = SCOPE_IDENTITY();
END;
GO