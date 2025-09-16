BULK INSERT vacinacao_jan_2025    
FROM 'D:\vacinacao_jan_2025.csv' -- Caminho do arquivo CSV (Exemplo)
WITH (
    FIELDTERMINATOR = ';',    -- Separador de campos 
    ROWTERMINATOR = '0x0d0a', -- quebra de linha em formato hexadecimal
    FIRSTROW = 2,             -- Ignora a primeira linha (cabeçalho)
    TABLOCK,                  -- Otimiza a inserção em lote
    CODEPAGE = '1252'         -- Necesssário para tratar os dados (Acentos e etc)

);
