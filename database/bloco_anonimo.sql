-- Análise de Abrigos por Tipo de Emergência

DECLARE
    v_tipo_emergencia VARCHAR2(50);
    v_media_capacidade NUMBER;
    v_total_abrigos NUMBER;
    v_status VARCHAR2(100);
    
    CURSOR c_emergencias IS
        SELECT te.tipo_emergencia, COUNT(a.id_abrigo) as total_abrigos
        FROM TB_TIPO_EMERGENCIA te
        LEFT JOIN TB_ABRIGO_TIPO_EMERGENCIA ate ON te.id_tipo_emergencia = ate.id_tipo_emergencia
        LEFT JOIN TB_ABRIGO a ON ate.id_abrigo = a.id_abrigo
        GROUP BY te.tipo_emergencia
        HAVING COUNT(a.id_abrigo) > 0
        ORDER BY total_abrigos DESC;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== ANÁLISE DE ABRIGOS POR TIPO DE EMERGÊNCIA ===');
    DBMS_OUTPUT.PUT_LINE('');
    
    FOR reg IN c_emergencias LOOP
        SELECT AVG(capacidade_suportada_abrigo)
        INTO v_media_capacidade
        FROM TB_ABRIGO a
        JOIN TB_ABRIGO_TIPO_EMERGENCIA ate ON a.id_abrigo = ate.id_abrigo
        JOIN TB_TIPO_EMERGENCIA te ON ate.id_tipo_emergencia = te.id_tipo_emergencia
        WHERE te.tipo_emergencia = reg.tipo_emergencia;
        
        IF v_media_capacidade > 100 THEN
            v_status := 'Alta capacidade';
        ELSIF v_media_capacidade > 50 THEN
            v_status := 'Média capacidade';
        ELSE
            v_status := 'Baixa capacidade';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('Tipo: ' || reg.tipo_emergencia);
        DBMS_OUTPUT.PUT_LINE('  - Total de abrigos: ' || reg.total_abrigos);
        DBMS_OUTPUT.PUT_LINE('  - Capacidade média: ' || NVL(ROUND(v_media_capacidade, 2), 0));
        DBMS_OUTPUT.PUT_LINE('  - Status: ' || v_status);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    END LOOP;
END;
/




-- Análise Estatística de Abrigos e Emergências
DECLARE
    v_total_abrigos NUMBER;
    v_abrigos_multiplas_emergencias NUMBER;
    v_tipo_mais_comum VARCHAR2(100);
    v_media_tipos_por_abrigo NUMBER(10,2);
    v_capacidade_media NUMBER(10,2);
    v_abrigos_sem_localizacao NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== ESTATÍSTICAS GERAIS DO SISTEMA DE ABRIGOS ===');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- 1. Contagem total de abrigos
    SELECT COUNT(*) INTO v_total_abrigos FROM TB_ABRIGO;
    
    -- 2. Abrigos que atendem múltiplas emergências
    SELECT COUNT(*) INTO v_abrigos_multiplas_emergencias
    FROM (
        SELECT id_abrigo
        FROM TB_ABRIGO_TIPO_EMERGENCIA
        GROUP BY id_abrigo
        HAVING COUNT(*) > 1
    );
    
    -- 3. Tipo de emergência mais comum
    SELECT tipo_emergencia INTO v_tipo_mais_comum
    FROM (
        SELECT te.tipo_emergencia, COUNT(*) as total
        FROM TB_TIPO_EMERGENCIA te
        JOIN TB_ABRIGO_TIPO_EMERGENCIA ate ON te.id_tipo_emergencia = ate.id_tipo_emergencia
        GROUP BY te.tipo_emergencia
        ORDER BY total DESC
    ) WHERE ROWNUM = 1;
    
    -- 4. Média de tipos de emergência por abrigo
    SELECT AVG(cnt) INTO v_media_tipos_por_abrigo
    FROM (
        SELECT COUNT(*) as cnt
        FROM TB_ABRIGO_TIPO_EMERGENCIA
        GROUP BY id_abrigo
    );
    
    -- 5. Capacidade média dos abrigos
    SELECT AVG(capacidade_suportada_abrigo) 
    INTO v_capacidade_media
    FROM TB_ABRIGO
    WHERE capacidade_suportada_abrigo IS NOT NULL;
    
    -- 6. Abrigos sem localização cadastrada
    SELECT COUNT(*) INTO v_abrigos_sem_localizacao
    FROM TB_ABRIGO a
    WHERE NOT EXISTS (
        SELECT 1 FROM TB_LOCALIZACAO l 
        WHERE l.id_abrigo = a.id_abrigo
    );
    
    -- Exibição dos resultados
    DBMS_OUTPUT.PUT_LINE('1. Total de abrigos cadastrados: ' || v_total_abrigos);
    DBMS_OUTPUT.PUT_LINE('2. Abrigos que atendem múltiplas emergências: ' || v_abrigos_multiplas_emergencias);
    DBMS_OUTPUT.PUT_LINE('3. Tipo de emergência mais atendido: ' || v_tipo_mais_comum);
    DBMS_OUTPUT.PUT_LINE('4. Média de tipos de emergência por abrigo: ' || ROUND(v_media_tipos_por_abrigo, 2));
    DBMS_OUTPUT.PUT_LINE('5. Capacidade média dos abrigos: ' || ROUND(v_capacidade_media, 2) || ' pessoas');
    
    IF v_abrigos_sem_localizacao > 0 THEN
        DBMS_OUTPUT.PUT_LINE('6. ALERTA: ' || v_abrigos_sem_localizacao || ' abrigos sem localização cadastrada!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('6. Todos os abrigos possuem localização cadastrada.');
    END IF;
END;
/