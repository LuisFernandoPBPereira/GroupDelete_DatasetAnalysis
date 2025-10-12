-- TODO: Criar uma procedure para a seguinte questão:
-- Quais cidades apresentam os maiores e os menores números de aplicações?
-- 10 cidades com maiores números de aplicações
SELECT TOP 10
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
GROUP BY me.NomeMunicipioEstabelecimento, me.SgUfEstabelecimento
ORDER BY TotalVacinas DESC;
-- 10 cidades com menores números de aplicações
SELECT TOP 10
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
GROUP BY me.NomeMunicipioEstabelecimento, me.SgUfEstabelecimento
ORDER BY TotalVacinas ASC;