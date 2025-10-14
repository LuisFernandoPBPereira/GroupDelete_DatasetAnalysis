-- Quem são os vacinados em termos de idade, gênero e outras características populacionais?
-- Média de idade dos pacientes vacinados
CREATE OR ALTER VIEW vw_MediaIdadePacientes AS
SELECT 
    FORMAT(AVG(p.NumeroIdadePaciente), 'N2', 'pt-BR') AS MediaIdade
FROM Paciente p;

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
            THEN '< 0%' 
        ELSE FORMAT(CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Paciente) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS Proporcao
FROM Paciente p
GROUP BY p.TipoSexoPaciente;

-- Qual a proporção de pacientes indígenas vacinados e como estão distribuídos por etnias?
CREATE OR ALTER VIEW vw_PacientesIndigenasPorEtnia AS
SELECT 
    eip.NomeEtniaIndigenaPaciente, 
    COUNT(p.CodigoPaciente) AS TotalPacientes,
    CASE 
        WHEN (COUNT(p.CodigoPaciente) * 100.0 / (SELECT COUNT(*) FROM Paciente)) < 0.01 
            THEN '< 0%' 
        ELSE FORMAT(CAST(COUNT(p.CodigoPaciente) * 100.0 / (SELECT COUNT(*) FROM Paciente) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM Paciente p 
INNER JOIN EtniaIndigenaPaciente eip 
    ON p.CodigoEtniaIndigenaPaciente = eip.CodigoEtniaIndigenaPaciente
GROUP BY eip.NomeEtniaIndigenaPaciente;

-- Como está a distribuição das vacinas por estado e município?
-- Por estado
CREATE OR ALTER VIEW vw_DistribuicaoVacinasPorEstado AS
SELECT 
    me.NomeUfEstabelecimento,
    COUNT(av.CodigoVacina) AS TotalVacinas,
    CASE 
        WHEN (COUNT(av.CodigoVacina) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 
            THEN '< 0%' 
        ELSE FORMAT(CAST(COUNT(av.CodigoVacina) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM MunicipioEstabelecimento me 
INNER JOIN Estabelecimento e ON me.CodigoMunicipioEstabelecimento = e.CodigoMunicipioEstabelecimento 
INNER JOIN AplicacaoVacinaEstabelecimento ave ON e.CodigoCnesEstabelecimento = ave.CodigoCnesEstabelecimento
INNER JOIN AplicacaoVacina av ON ave.IdAplicacao = av.IdAplicacao
GROUP BY me.NomeUfEstabelecimento;

-- Por município
CREATE OR ALTER VIEW vw_DistribuicaoVacinasPorMunicipio AS
SELECT 
    me.NomeMunicipioEstabelecimento,
    me.SgUfEstabelecimento,
    COUNT(av.CodigoVacina) AS TotalVacinas,
    CASE 
        WHEN (COUNT(av.CodigoVacina) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 
            THEN '< 0%' 
        ELSE FORMAT(CAST(COUNT(av.CodigoVacina) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM MunicipioEstabelecimento me 
INNER JOIN Estabelecimento e ON me.CodigoMunicipioEstabelecimento = e.CodigoMunicipioEstabelecimento 
INNER JOIN AplicacaoVacinaEstabelecimento ave ON e.CodigoCnesEstabelecimento = ave.CodigoCnesEstabelecimento
INNER JOIN AplicacaoVacina av ON ave.IdAplicacao = av.IdAplicacao
GROUP BY me.NomeMunicipioEstabelecimento, me.SgUfEstabelecimento;


-- Qual a quantidade de doses aplicadas por fase (1ª, 2ª e reforço)?
CREATE OR ALTER VIEW vw_DosesAplicadasPorFase AS
SELECT 
    dv.DescricaoDoseVacina,
    COUNT(av.IdAplicacao) AS TotalVacinasAplicadasPorDose,
    CASE 
        WHEN (COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 
            THEN '< 0%' 
        ELSE FORMAT(CAST(COUNT(av.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM DoseVacina dv 
INNER JOIN VacinaDoseVacina vdv ON dv.CodigoDoseVacina = vdv.CodigoDoseVacina
INNER JOIN AplicacaoVacina av ON av.CodigoVacina = vdv.CodigoVacina
GROUP BY dv.DescricaoDoseVacina;

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
            THEN '< 0%' 
        ELSE FORMAT(CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM AplicacaoComFabricante acf
INNER JOIN VacinaFabricante vf ON acf.CodigoVacinaFabricante = vf.CodigoVacinaFabricante
INNER JOIN Vacina v ON acf.CodigoVacina = v.CodigoVacina
GROUP BY vf.DescricaoVacinaFabricante, v.DescricaoVacina;

-- Como se distribuem as aplicações entre UBS, hospitais e outros estabelecimentos?
CREATE OR ALTER VIEW vw_AplicacoesPorTipoEstabelecimento AS
SELECT 
    te.DescricaoTipoEstabelecimento, 
    COUNT(ave.IdAplicacao) AS TotalAplicacoes,
    CASE 
        WHEN (COUNT(ave.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 
            THEN '< 0%' 
        ELSE FORMAT(CAST(COUNT(ave.IdAplicacao) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM TipoEstabelecimento te 
INNER JOIN EstabelecimentoTipoEstabelecimento ete ON te.CodigoTipoEstabelecimento = ete.CodigoTipoEstabelecimento
INNER JOIN AplicacaoVacinaEstabelecimento ave ON ete.CodigoCnesEstabelecimento = ave.CodigoCnesEstabelecimento
GROUP BY te.DescricaoTipoEstabelecimento;

-- Como o número de doses aplicadas evoluiu ao longo do tempo?
CREATE OR ALTER VIEW vw_EvolucaoVacinasAoLongoDoTempo AS
SELECT 
    av.DataVacina, 
    COUNT(*) AS TotalVacinasAplicadas,
    CASE 
        WHEN (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina)) < 0.01 
            THEN '< 0%' 
        ELSE FORMAT(CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM AplicacaoVacina) AS DECIMAL(10,2)), 'N', 'pt-BR') + '%'
    END AS ProporcaoPorcentagem
FROM AplicacaoVacina av
GROUP BY av.DataVacina;


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

