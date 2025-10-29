
 -- Qual é a distribuição de raça/cor entre os vacinados? 
CREATE OR ALTER VIEW vw_DistribuicaoRacaCorPacientes AS
SELECT 
    rcp.NomeRacaCorPaciente AS RacaCor,
    COUNT(p.CodigoPaciente) AS TotalPacientes,
    CASE 
        WHEN (COUNT(p.CodigoPaciente) * 100.0 / (SELECT COUNT(*) FROM Paciente)) < 0.01 THEN '< 1%'
        ELSE FORMAT(CAST(COUNT(p.CodigoPaciente) * 100.0 / (SELECT COUNT(*) FROM Paciente) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM Paciente p 
INNER JOIN RacaCorPaciente rcp ON p.CodigoRacaCorPaciente = rcp.CodigoRacaCorPaciente
GROUP BY rcp.NomeRacaCorPaciente;

GO

-- Qual é a distribuição de vacinados por condição maternal (gestantes, puérperas)?
CREATE OR ALTER VIEW vw_DistribuicaoCondicaoMaternalPacientes AS
SELECT 
    CASE 
		WHEN cm.DescricaoCondicaoMaternal IS NULL THEN 'Não Informado' 
		ELSE cm.DescricaoCondicaoMaternal 
	END AS CondicaoMaternal,
    COUNT(p.CodigoPaciente) AS TotalPacientes,
    CASE 
        WHEN (COUNT(p.CodigoPaciente) * 100.0 / (SELECT COUNT(*) FROM Paciente WHERE TipoSexoPaciente = 'F')) < 0.01 THEN '< 1%'
        ELSE FORMAT(CAST(COUNT(p.CodigoPaciente) * 100.0 / (SELECT COUNT(*) FROM Paciente WHERE TipoSexoPaciente = 'F') AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM Paciente p
LEFT JOIN CondicaoMaternal cm ON p.CodigoCondicaoMaternal = cm.CodigoCondicaoMaternal
WHERE p.TipoSexoPaciente = 'F'
GROUP BY cm.DescricaoCondicaoMaternal;

GO

-- Qual a nacionalidade predominante entre os pacientes vacinados?
CREATE OR ALTER VIEW vw_DistribuicaoNacionalidadePacientes AS
SELECT 
    ISNULL(pp.NomePaisPaciente,'Não Informado') AS NomePaisPaciente,
    COUNT(p.CodigoPaciente) AS TotalPacientes,
    CASE 
        WHEN (COUNT(p.CodigoPaciente) * 100.0 / (SELECT COUNT(*) FROM Paciente)) < 0.01 THEN '< 1%'
        ELSE FORMAT(CAST(COUNT(p.CodigoPaciente) * 100.0 / (SELECT COUNT(*) FROM Paciente) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM Paciente p 
LEFT JOIN PaisPaciente pp ON p.CodigoPaisPaciente = pp.CodigoPaisPaciente
GROUP BY ISNULL(pp.NomePaisPaciente,'Não Informado');

GO



-- Quem são os vacinados em termos de idade, gênero e outras características populacionais?
-- Média de idade dos pacientes vacinados
CREATE OR ALTER VIEW vw_MediaIdadePacientes AS
SELECT 
    FORMAT(AVG(p.NumeroIdadePaciente), 'N2', 'pt-BR') AS MediaIdade
FROM Paciente p;

GO

-- Registros de vacinação por sistema de origem (assume Documento -> SistemaOrigem)
CREATE OR ALTER VIEW vw_RegistrosPorSistemaOrigem AS
SELECT 
    so.DescricaoSistemaOrigem,
    COUNT(d.CodigoDocumento) AS TotalRegistros,
    CASE 
        WHEN (COUNT(d.CodigoDocumento) * 100.0 / (SELECT COUNT(*) FROM Documento)) < 0.01 THEN '< 1%'
        ELSE FORMAT(CAST(COUNT(d.CodigoDocumento) * 100.0 / (SELECT COUNT(*) FROM Documento) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM Documento d
INNER JOIN SistemaOrigem so ON d.CodigoSistemaOrigem = so.CodigoSistemaOrigem
GROUP BY so.DescricaoSistemaOrigem;

GO

-- Aplicações por grupo e categoria de atendimento (assume relação AplicacaoVacina -> GrupoAtendimento & CategoriaAtendimento via códigos)
CREATE OR ALTER VIEW vw_AplicacoesPorGrupoCategoriaAtendimento AS
SELECT 
    ga.DescricaoVacinaGrupoAtendimento,
    ca.DescricaoVacinaCategoriaAtendimento,
    COUNT(av.IdAplicacao) AS TotalAplicacoes,
    CASE 
        WHEN (COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 THEN '< 1%'
        ELSE FORMAT(CAST(COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM AplicacaoVacina av
INNER JOIN VacinaGrupoAtendimento vga ON av.CodigoVacina = vga.CodigoVacina
INNER JOIN GrupoAtendimento ga ON vga.CodigoVacinaGrupoAtendimento = ga.CodigoVacinaGrupoAtendimento
INNER JOIN VacinaCategoriaAtendimento vca ON av.CodigoVacina = vca.CodigoVacina
INNER JOIN CategoriaAtendimento ca ON vca.CodigoVacinaCategoriaAtendimento = ca.CodigoVacinaCategoriaAtendimento
GROUP BY ga.DescricaoVacinaGrupoAtendimento, ca.DescricaoVacinaCategoriaAtendimento;

GO

-- Aplicações por estratégia de vacinação (assume Documento relaciona AplicacaoVacina e EstrategiaVacinacao)
CREATE OR ALTER VIEW vw_AplicacoesPorEstrategiaVacinacao AS
SELECT 
    ev.DescricaoEstrategiaVacinacao,
    COUNT(av.IdAplicacao) AS TotalAplicacoes,
    CASE 
        WHEN (COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 THEN '< 1%'
        ELSE FORMAT(CAST(COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM Documento d
INNER JOIN AplicacaoVacina av ON d.CodigoDocumento = av.CodigoDocumento
INNER JOIN EstrategiaVacinacao ev ON d.CodigoEstrategiaVacinacao = ev.CodigoEstrategiaVacinacao
GROUP BY ev.DescricaoEstrategiaVacinacao;

GO

-- Ranking de estabelecimentos por total de aplicações
CREATE OR ALTER VIEW vw_RankingEstabelecimentosAplicacoes AS
SELECT 
    e.CodigoCnesEstabelecimento,
    ISNULL(e.NomeFantasiaEstalecimento,'Sem Nome') AS NomeEstabelecimento,
    COUNT(av.IdAplicacao) AS TotalAplicacoes,
    RANK() OVER (ORDER BY COUNT(av.IdAplicacao) DESC) AS RankDesc
FROM Estabelecimento e
INNER JOIN AplicacaoVacinaEstabelecimento ave ON e.CodigoCnesEstabelecimento = ave.CodigoCnesEstabelecimento
INNER JOIN AplicacaoVacina av ON ave.IdAplicacao = av.IdAplicacao
GROUP BY e.CodigoCnesEstabelecimento, ISNULL(e.NomeFantasiaEstalecimento,'Sem Nome');

GO

-- Distribuição de aplicações por natureza jurídica (assume ponte EstabelecimentoNaturezaEstabelecimento)
CREATE OR ALTER VIEW vw_AplicacoesPorNaturezaJuridica AS
SELECT 
    ne.DescricaoNaturezaEstabelecimento,
    COUNT(av.IdAplicacao) AS TotalAplicacoes,
    CASE 
        WHEN (COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 THEN '< 1%'
        ELSE FORMAT(CAST(COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM NaturezaEstabelecimento ne
INNER JOIN EstabelecimentoNaturezaEstabelecimento ene ON ne.CodigoNaturezaEstabelecimento = ene.CodigoNaturezaEstabelecimento
INNER JOIN AplicacaoVacinaEstabelecimento ave ON ene.CodigoCnesEstabelecimento = ave.CodigoCnesEstabelecimento
INNER JOIN AplicacaoVacina av ON ave.IdAplicacao = av.IdAplicacao
GROUP BY ne.DescricaoNaturezaEstabelecimento;

GO

-- Correlação entre município do paciente e do estabelecimento (mesmo município vs diferente)
-- Assumindo relação AplicacaoVacina -> Paciente via CodigoPaciente
CREATE OR ALTER VIEW vw_CorrelacaoMunicipioPacienteEstabelecimento AS
SELECT 
    CASE WHEN mp.CodigoMunicipioPaciente = me.CodigoMunicipioEstabelecimento THEN 'Mesmo Município' ELSE 'Município Diferente' END AS TipoCorrelacao,
    COUNT(av.IdAplicacao) AS TotalAplicacoes,
    CASE 
        WHEN (COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 THEN '< 1%'
        ELSE FORMAT(CAST(COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM AplicacaoVacina av
INNER JOIN Paciente p ON av.CodigoPaciente = p.CodigoPaciente
INNER JOIN MunicipioPaciente mp ON p.CodigoMunicipioPaciente = mp.CodigoMunicipioPaciente
INNER JOIN AplicacaoVacinaEstabelecimento ave ON av.IdAplicacao = ave.IdAplicacao
INNER JOIN Estabelecimento e ON ave.CodigoCnesEstabelecimento = e.CodigoCnesEstabelecimento
INNER JOIN MunicipioEstabelecimento me ON e.CodigoMunicipioEstabelecimento = me.CodigoMunicipioEstabelecimento
GROUP BY CASE WHEN mp.CodigoMunicipioPaciente = me.CodigoMunicipioEstabelecimento THEN 'Mesmo Município' ELSE 'Município Diferente' END;

GO

-- Ranking de municípios por total de aplicações (usar AplicacaoVacinaEstabelecimento -> Estabelecimento -> MunicipioEstabelecimento)
CREATE OR ALTER VIEW vw_RankingMunicipiosAplicacoes AS
SELECT 
    me.NomeMunicipioEstabelecimento,
    me.SgUfEstabelecimento,
    COUNT(av.IdAplicacao) AS TotalAplicacoes,
    RANK() OVER (ORDER BY COUNT(av.IdAplicacao) DESC) AS RankDesc,
    RANK() OVER (ORDER BY COUNT(av.IdAplicacao) ASC) AS RankAsc
FROM MunicipioEstabelecimento me
INNER JOIN Estabelecimento e ON me.CodigoMunicipioEstabelecimento = e.CodigoMunicipioEstabelecimento
INNER JOIN AplicacaoVacinaEstabelecimento ave ON e.CodigoCnesEstabelecimento = ave.CodigoCnesEstabelecimento
INNER JOIN AplicacaoVacina av ON ave.IdAplicacao = av.IdAplicacao
GROUP BY me.NomeMunicipioEstabelecimento, me.SgUfEstabelecimento;

GO

-- Total de pacientes vacinados agrupados por gênero
CREATE OR ALTER VIEW vw_PacientesPorGenero AS
SELECT 
    CASE
        When p.TipoSexoPaciente = 'M' Then 'Masculino'
        When p.TipoSexoPaciente = 'F' Then 'Feminino'
        When p.TipoSexoPaciente = 'I' Then 'Indeterminado'
    END AS TipoSexoPaciente,
    COUNT(*) AS Total,
    CASE 
        WHEN (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Paciente)) < 0.01 
            THEN '< 1%' 
        ELSE FORMAT(CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Paciente) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS Proporcao
FROM Paciente p
GROUP BY p.TipoSexoPaciente;

GO

-- Qual a proporção de pacientes indígenas vacinados e como estão distribuídos por etnias?
CREATE OR ALTER VIEW vw_PacientesIndigenasPorEtnia AS
SELECT 
    eip.NomeEtniaIndigenaPaciente, 
    COUNT(p.CodigoPaciente) AS TotalPacientes,
    CASE 
        WHEN (COUNT(p.CodigoPaciente) * 100.0 / (SELECT COUNT(*) FROM Paciente)) < 0.01 
            THEN '< 1%' 
        ELSE FORMAT(CAST(COUNT(p.CodigoPaciente) * 100.0 / (SELECT COUNT(*) FROM Paciente) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM Paciente p 
INNER JOIN EtniaIndigenaPaciente eip 
    ON p.CodigoEtniaIndigenaPaciente = eip.CodigoEtniaIndigenaPaciente
GROUP BY eip.NomeEtniaIndigenaPaciente;

GO

-- Como está a distribuição das vacinas por estado e município?
-- Por estado
CREATE OR ALTER VIEW vw_DistribuicaoVacinasPorEstado AS
SELECT 
    me.NomeUfEstabelecimento,
    COUNT(av.CodigoVacina) AS TotalVacinas,
    CASE 
        WHEN (COUNT(av.CodigoVacina) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 
            THEN '< 1%' 
        ELSE FORMAT(CAST(COUNT(av.CodigoVacina) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM MunicipioEstabelecimento me 
INNER JOIN Estabelecimento e ON me.CodigoMunicipioEstabelecimento = e.CodigoMunicipioEstabelecimento 
INNER JOIN AplicacaoVacinaEstabelecimento ave ON e.CodigoCnesEstabelecimento = ave.CodigoCnesEstabelecimento
INNER JOIN AplicacaoVacina av ON ave.IdAplicacao = av.IdAplicacao
GROUP BY me.NomeUfEstabelecimento;

GO

-- Por município
CREATE OR ALTER VIEW vw_DistribuicaoVacinasPorMunicipio AS
SELECT 
    me.NomeMunicipioEstabelecimento,
    me.SgUfEstabelecimento,
    COUNT(av.CodigoVacina) AS TotalVacinas,
    CASE 
        WHEN (COUNT(av.CodigoVacina) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 
            THEN '< 1%' 
        ELSE FORMAT(CAST(COUNT(av.CodigoVacina) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM MunicipioEstabelecimento me 
INNER JOIN Estabelecimento e ON me.CodigoMunicipioEstabelecimento = e.CodigoMunicipioEstabelecimento 
INNER JOIN AplicacaoVacinaEstabelecimento ave ON e.CodigoCnesEstabelecimento = ave.CodigoCnesEstabelecimento
INNER JOIN AplicacaoVacina av ON ave.IdAplicacao = av.IdAplicacao
GROUP BY me.NomeMunicipioEstabelecimento, me.SgUfEstabelecimento;

GO

-- Qual a quantidade de doses aplicadas por fase (1ª, 2ª e reforço)?
CREATE OR ALTER VIEW vw_DosesAplicadasPorFase AS
SELECT 
    dv.DescricaoDoseVacina,
    COUNT(av.IdAplicacao) AS TotalVacinasAplicadasPorDose,
    CASE 
        WHEN (COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 
            THEN '< 1%' 
        ELSE FORMAT(CAST(COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM DoseVacina dv 
INNER JOIN VacinaDoseVacina vdv ON dv.CodigoDoseVacina = vdv.CodigoDoseVacina
INNER JOIN AplicacaoVacina av ON av.CodigoVacina = vdv.CodigoVacina
GROUP BY dv.DescricaoDoseVacina;

GO

-- Quais vacinas são mais utilizadas e qual a participação de cada fabricante?
CREATE OR ALTER VIEW vw_VacinasPorFabricante AS
WITH AplicacaoComFabricante AS (
    SELECT 
        av.IdAplicacao,
        av.CodigoVacina,
        MIN(vfv.CodigoVacinaFabricante) AS CodigoVacinaFabricante
    FROM AplicacaoVacina av
    INNER JOIN VacinaFabricanteVacina vfv 
        ON av.CodigoVacina = vfv.CodigoVacina
    GROUP BY av.IdAplicacao, av.CodigoVacina
)
SELECT 
    vf.DescricaoVacinaFabricante,
    v.DescricaoVacina,
    COUNT(*) AS TotalAplicacaoDaVacina,
    CASE 
        WHEN (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 
            THEN '< 1%' 
        ELSE FORMAT(CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM AplicacaoComFabricante acf
INNER JOIN VacinaFabricante vf ON acf.CodigoVacinaFabricante = vf.CodigoVacinaFabricante
INNER JOIN Vacina v ON acf.CodigoVacina = v.CodigoVacina
GROUP BY vf.DescricaoVacinaFabricante, v.DescricaoVacina;

GO

-- Como se distribuem as aplicações entre UBS, hospitais e outros estabelecimentos?
CREATE OR ALTER VIEW vw_AplicacoesPorTipoEstabelecimento AS
SELECT 
    te.DescricaoTipoEstabelecimento, 
    COUNT(ave.IdAplicacao) AS TotalAplicacoes,
    CASE 
        WHEN (COUNT(ave.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 
            THEN '< 1%' 
        ELSE FORMAT(CAST(COUNT(ave.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM TipoEstabelecimento te 
INNER JOIN EstabelecimentoTipoEstabelecimento ete ON te.CodigoTipoEstabelecimento = ete.CodigoTipoEstabelecimento
INNER JOIN AplicacaoVacinaEstabelecimento ave ON ete.CodigoCnesEstabelecimento = ave.CodigoCnesEstabelecimento
GROUP BY te.DescricaoTipoEstabelecimento;

GO

-- Como o número de doses aplicadas evoluiu ao longo do tempo?
CREATE OR ALTER VIEW vw_EvolucaoVacinasAoLongoDoTempo AS
SELECT 
    av.DataVacina, 
    COUNT(*) AS TotalVacinasAplicadas,
    CASE 
        WHEN (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 
            THEN '< 1%' 
        ELSE FORMAT(CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM AplicacaoVacina av
GROUP BY av.DataVacina;

GO

-- Proporção de pacientes indígenas vs não indígenas (considera indígenas quando CodigoEtniaIndigenaPaciente IS NOT NULL)
CREATE OR ALTER VIEW vw_ProporcaoIndigenas AS
SELECT 
    CASE 
        WHEN p.CodigoEtniaIndigenaPaciente IS NOT NULL THEN 'Indígena' 
        ELSE 'Não Indígena' 
    END AS Grupo,
    COUNT(*) AS TotalPacientes,
    CASE 
        WHEN (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Paciente)) < 0.01 THEN '< 1%' 
        ELSE FORMAT(CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Paciente) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%' 
    END AS ProporcaoPorcentagem
FROM Paciente p
GROUP BY CASE WHEN p.CodigoEtniaIndigenaPaciente IS NOT NULL THEN 'Indígena' ELSE 'Não Indígena' END;

GO

-- Distribuição de pacientes por faixa etária 
CREATE OR ALTER VIEW vw_PacientesPorFaixaEtaria AS
WITH Faixas AS (
    SELECT 
        CASE 
            WHEN p.NumeroIdadePaciente BETWEEN 0 AND 4 THEN '00-04'
            WHEN p.NumeroIdadePaciente BETWEEN 5 AND 11 THEN '05-11'
            WHEN p.NumeroIdadePaciente BETWEEN 12 AND 17 THEN '12-17'
            WHEN p.NumeroIdadePaciente BETWEEN 18 AND 29 THEN '18-29'
            WHEN p.NumeroIdadePaciente BETWEEN 30 AND 39 THEN '30-39'
            WHEN p.NumeroIdadePaciente BETWEEN 40 AND 49 THEN '40-49'
            WHEN p.NumeroIdadePaciente BETWEEN 50 AND 59 THEN '50-59'
            WHEN p.NumeroIdadePaciente BETWEEN 60 AND 69 THEN '60-69'
            WHEN p.NumeroIdadePaciente BETWEEN 70 AND 79 THEN '70-79'
            WHEN p.NumeroIdadePaciente >= 80 THEN '80+'
            ELSE 'Não Informado'
        END AS FaixaEtaria
    FROM Paciente p
)
SELECT 
    FaixaEtaria,
    COUNT(*) AS TotalPacientes,
    CASE 
        WHEN (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Paciente)) < 0.01 THEN '< 1%' 
        ELSE FORMAT(CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Paciente) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%' 
    END AS ProporcaoPorcentagem
FROM Faixas
GROUP BY FaixaEtaria;

GO

-- Locais de aplicação mais comuns (redefinido após correção de corrupção)
CREATE OR ALTER VIEW vw_LocaisAplicacaoMaisComuns AS
SELECT 
    la.DescricaoLocalAplicacao,
    COUNT(av.IdAplicacao) AS TotalAplicacoes,
    CASE 
        WHEN (COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 THEN '< 1%'
        ELSE FORMAT(CAST(COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM AplicacaoVacina av
INNER JOIN Vacina v ON av.CodigoVacina = v.CodigoVacina
INNER JOIN VacinaLocalAplicacao vla ON v.CodigoVacina = vla.CodigoVacina
INNER JOIN LocalAplicacao la ON vla.CodigoLocalAplicacao = la.CodigoLocalAplicacao
GROUP BY la.DescricaoLocalAplicacao;

GO

-- Vias de administração mais comuns (redefinido após correção de corrupção)
CREATE OR ALTER VIEW vw_ViasAdministracaoMaisComuns AS
SELECT 
    va.DescricaoViaAdministracao,
    COUNT(av.IdAplicacao) AS TotalAplicacoes,
    CASE 
        WHEN (COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 THEN '< 1%'
        ELSE FORMAT(CAST(COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM AplicacaoVacina av
INNER JOIN Vacina v ON av.CodigoVacina = v.CodigoVacina
INNER JOIN VacinaViaAdministracao vva ON v.CodigoVacina = vva.CodigoVacina
INNER JOIN ViaAdministracao va ON vva.CodigoViaAdministracao = va.CodigoViaAdministracao
GROUP BY va.DescricaoViaAdministracao;

GO

-- Usando views
SELECT * FROM vw_AplicacoesPorTipoEstabelecimento ORDER BY TotalAplicacoes DESC;
SELECT * FROM vw_DistribuicaoVacinasPorEstado ORDER BY TotalVacinas DESC;
SELECT * FROM vw_DistribuicaoVacinasPorMunicipio ORDER BY TotalVacinas DESC;
SELECT * FROM vw_DosesAplicadasPorFase ORDER BY DescricaoDoseVacina;
SELECT * FROM vw_EvolucaoVacinasAoLongoDoTempo ORDER BY DataVacina;
SELECT * FROM vw_MediaIdadePacientes;
SELECT * FROM vw_PacientesIndigenasPorEtnia ORDER BY TotalPacientes DESC;
SELECT * FROM vw_PacientesPorGenero ORDER BY Total DESC;
SELECT * FROM vw_VacinasPorFabricante ORDER BY TotalAplicacaoDaVacina DESC;
SELECT * FROM vw_ProporcaoIndigenas;
SELECT * FROM vw_PacientesPorFaixaEtaria ORDER BY FaixaEtaria;
SELECT TOP 10 * FROM vw_RankingMunicipiosAplicacoes ORDER BY TotalAplicacoes DESC; -- Top 10 maiores
SELECT TOP 10 * FROM vw_RankingMunicipiosAplicacoes ORDER BY TotalAplicacoes ASC; -- Top 10 menores
SELECT * FROM vw_CorrelacaoMunicipioPacienteEstabelecimento;
SELECT * FROM vw_ViasAdministracaoMaisComuns ORDER BY TotalAplicacoes DESC;
SELECT * FROM vw_LocaisAplicacaoMaisComuns ORDER BY TotalAplicacoes DESC;
SELECT * FROM vw_AplicacoesPorNaturezaJuridica ORDER BY TotalAplicacoes DESC;
SELECT TOP 20 * FROM vw_RankingEstabelecimentosAplicacoes ORDER BY TotalAplicacoes DESC; -- Top 20 estabelecimentos
SELECT * FROM vw_AplicacoesPorEstrategiaVacinacao ORDER BY TotalAplicacoes DESC;
SELECT * FROM vw_AplicacoesPorGrupoCategoriaAtendimento ORDER BY TotalAplicacoes DESC;
SELECT * FROM vw_RegistrosPorSistemaOrigem ORDER BY TotalRegistros DESC;
SELECT * FROM vw_DistribuicaoRacaCorPacientes ORDER BY TotalPacientes DESC;
SELECT * FROM vw_DistribuicaoCondicaoMaternalPacientes ORDER BY TotalPacientes DESC;
SELECT * FROM vw_DistribuicaoNacionalidadePacientes ORDER BY TotalPacientes DESC;


