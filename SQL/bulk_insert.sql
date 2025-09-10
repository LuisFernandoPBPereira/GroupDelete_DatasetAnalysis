BULK INSERT vacinacao_jan_2025 -- Caso seja necessário alterar o nome da tabela, primeiro atualize o arquivo create_geral e, em seguida, ajuste também neste local.
FROM 'C:\caminho\arquivo.csv'  -- Caminho do arquivo CSV
WITH (
    FIELDTERMINATOR = ';',   -- Separador de campos (padrão: `;`)
    ROWTERMINATOR = '\n',    -- Separador de linhas
    FIRSTROW = 2,            -- Ignora a primeira linha (cabeçalho)
    TABLOCK                  -- Otimiza a inserção em lote
);
