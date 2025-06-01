-- Relatório de Capacidade por Tipo de Emergência

SELECT 
    te.tipo_emergencia,
    COUNT(DISTINCT a.id_abrigo) AS total_abrigos,
    SUM(a.capacidade_suportada_abrigo) AS capacidade_total,
    AVG(a.capacidade_suportada_abrigo) AS capacidade_media,
    MIN(a.capacidade_suportada_abrigo) AS capacidade_minima,
    MAX(a.capacidade_suportada_abrigo) AS capacidade_maxima
FROM  TB_TIPO_EMERGENCIA te
LEFT JOIN TB_ABRIGO_TIPO_EMERGENCIA ate 
    ON te.id_tipo_emergencia = ate.id_tipo_emergencia
LEFT JOIN TB_ABRIGO a 
    ON ate.id_abrigo = a.id_abrigo
GROUP BY te.tipo_emergencia
HAVING COUNT(DISTINCT a.id_abrigo) > 0
ORDER BY capacidade_total DESC;


-- Abrigos que Atendem Mais de 2 Tipos de Emergência
SELECT 
    a.nome_abrigo,
    COUNT(ate.id_tipo_emergencia) AS tipos_emergencia_atendidos,
    LISTAGG(te.tipo_emergencia, ', ') WITHIN GROUP (ORDER BY te.tipo_emergencia) AS tipos_emergencia,
    a.capacidade_suportada_abrigo
FROM TB_ABRIGO a
LEFT JOIN TB_ABRIGO_TIPO_EMERGENCIA ate 
    ON a.id_abrigo = ate.id_abrigo
LEFT JOIN TB_TIPO_EMERGENCIA te 
    ON ate.id_tipo_emergencia = te.id_tipo_emergencia
GROUP BY a.id_abrigo, a.nome_abrigo, a.capacidade_suportada_abrigo
HAVING COUNT(ate.id_tipo_emergencia) > 1
ORDER BY tipos_emergencia_atendidos DESC, a.capacidade_suportada_abrigo DESC;


-- Distribuição Geográfica dos Abrigos por Região
SELECT 
    CASE 
        WHEN l.latitude_abrigo < '-23.550000' THEN 'Zona Norte'
        WHEN l.latitude_abrigo > '-23.550000' THEN 'Zona Sul'
        ELSE 'Zona Central'
    END AS regiao,
    COUNT(a.id_abrigo) AS total_abrigos,
    ROUND(COUNT(a.id_abrigo) * 100.0 / (SELECT COUNT(*) FROM TB_ABRIGO), 2) AS percentual,
    SUM(a.capacidade_suportada_abrigo) AS capacidade_total
FROM TB_ABRIGO a
LEFT JOIN TB_LOCALIZACAO l ON a.id_abrigo = l.id_abrigo
GROUP BY 
    CASE 
        WHEN l.latitude_abrigo < '-23.550000' THEN 'Zona Norte'
        WHEN l.latitude_abrigo > '-23.550000' THEN 'Zona Sul'
        ELSE 'Zona Central'
    END
ORDER BY 
    total_abrigos DESC;
    
-- Tipos de Emergência com Capacidade Insuficiente

SELECT 
    te.tipo_emergencia,
    COUNT(a.id_abrigo) AS total_abrigos,
    AVG(a.capacidade_suportada_abrigo) AS capacidade_media,
    (SELECT AVG(capacidade_suportada_abrigo) FROM TB_ABRIGO) AS capacidade_media_geral,
    CASE 
        WHEN AVG(a.capacidade_suportada_abrigo) < (SELECT AVG(capacidade_suportada_abrigo) FROM TB_ABRIGO) 
        THEN 'Abaixo da média'
        ELSE 'Acima da média'
    END AS status_capacidade
FROM TB_TIPO_EMERGENCIA te
LEFT JOIN TB_ABRIGO_TIPO_EMERGENCIA ate 
    ON te.id_tipo_emergencia = ate.id_tipo_emergencia
LEFT JOIN TB_ABRIGO a 
    ON ate.id_abrigo = a.id_abrigo
GROUP BY te.tipo_emergencia
HAVING 
    AVG(a.capacidade_suportada_abrigo) < (SELECT AVG(capacidade_suportada_abrigo) FROM TB_ABRIGO)
    OR COUNT(a.id_abrigo) < (SELECT AVG(cnt) FROM (
        SELECT COUNT(*) as cnt 
        FROM TB_ABRIGO_TIPO_EMERGENCIA 
        GROUP BY id_tipo_emergencia
    ))
ORDER BY capacidade_media;
    
-- Relatório Completo de Abrigos com Detalhes

SELECT 
    a.id_abrigo,
    a.nome_abrigo,
    a.capacidade_suportada_abrigo,
    a.email_abrigo,
    l.rua_abrigo,
    l.latitude_abrigo,
    l.longitude_abrigo,
    (SELECT COUNT(*) FROM TB_ABRIGO_TIPO_EMERGENCIA WHERE id_abrigo = a.id_abrigo) AS tipos_emergencia_atendidos,
    (SELECT LISTAGG(te.tipo_emergencia, ', ') WITHIN GROUP (ORDER BY te.tipo_emergencia)
        FROM TB_ABRIGO_TIPO_EMERGENCIA ate
        JOIN TB_TIPO_EMERGENCIA te ON ate.id_tipo_emergencia = te.id_tipo_emergencia
        WHERE ate.id_abrigo = a.id_abrigo) AS tipos_emergencia
FROM TB_ABRIGO a
LEFT JOIN TB_LOCALIZACAO l 
    ON a.id_abrigo = l.id_abrigo
WHERE 
    a.capacidade_suportada_abrigo > 50
    AND EXISTS (
        SELECT 1 
        FROM TB_ABRIGO_TIPO_EMERGENCIA ate3
        WHERE ate3.id_abrigo = a.id_abrigo
    )
ORDER BY 
    a.capacidade_suportada_abrigo DESC, 
    (SELECT COUNT(*) FROM TB_ABRIGO_TIPO_EMERGENCIA WHERE id_abrigo = a.id_abrigo) DESC;