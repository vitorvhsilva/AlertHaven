-- An�lise de Abrigos por Tipo de Emerg�ncia

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
    DBMS_OUTPUT.PUT_LINE('=== AN�LISE DE ABRIGOS POR TIPO DE EMERG�NCIA ===');
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
            v_status := 'M�dia capacidade';
        ELSE
            v_status := 'Baixa capacidade';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('Tipo: ' || reg.tipo_emergencia);
        DBMS_OUTPUT.PUT_LINE('  - Total de abrigos: ' || reg.total_abrigos);
        DBMS_OUTPUT.PUT_LINE('  - Capacidade m�dia: ' || NVL(ROUND(v_media_capacidade, 2), 0));
        DBMS_OUTPUT.PUT_LINE('  - Status: ' || v_status);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    END LOOP;
END;
/




-- An�lise Estat�stica de Abrigos e Emerg�ncias
DECLARE
    v_total_abrigos NUMBER;
    v_abrigos_multiplas_emergencias NUMBER;
    v_tipo_mais_comum VARCHAR2(100);
    v_media_tipos_por_abrigo NUMBER(10,2);
    v_capacidade_media NUMBER(10,2);
    v_abrigos_sem_localizacao NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== ESTAT�STICAS GERAIS DO SISTEMA DE ABRIGOS ===');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- 1. Contagem total de abrigos
    SELECT COUNT(*) INTO v_total_abrigos FROM TB_ABRIGO;
    
    -- 2. Abrigos que atendem m�ltiplas emerg�ncias
    SELECT COUNT(*) INTO v_abrigos_multiplas_emergencias
    FROM (
        SELECT id_abrigo
        FROM TB_ABRIGO_TIPO_EMERGENCIA
        GROUP BY id_abrigo
        HAVING COUNT(*) > 1
    );
    
    -- 3. Tipo de emerg�ncia mais comum
    SELECT tipo_emergencia INTO v_tipo_mais_comum
    FROM (
        SELECT te.tipo_emergencia, COUNT(*) as total
        FROM TB_TIPO_EMERGENCIA te
        JOIN TB_ABRIGO_TIPO_EMERGENCIA ate ON te.id_tipo_emergencia = ate.id_tipo_emergencia
        GROUP BY te.tipo_emergencia
        ORDER BY total DESC
    ) WHERE ROWNUM = 1;
    
    -- 4. M�dia de tipos de emerg�ncia por abrigo
    SELECT AVG(cnt) INTO v_media_tipos_por_abrigo
    FROM (
        SELECT COUNT(*) as cnt
        FROM TB_ABRIGO_TIPO_EMERGENCIA
        GROUP BY id_abrigo
    );
    
    -- 5. Capacidade m�dia dos abrigos
    SELECT AVG(capacidade_suportada_abrigo) 
    INTO v_capacidade_media
    FROM TB_ABRIGO
    WHERE capacidade_suportada_abrigo IS NOT NULL;
    
    -- 6. Abrigos sem localiza��o cadastrada
    SELECT COUNT(*) INTO v_abrigos_sem_localizacao
    FROM TB_ABRIGO a
    WHERE NOT EXISTS (
        SELECT 1 FROM TB_LOCALIZACAO l 
        WHERE l.id_abrigo = a.id_abrigo
    );
    
    -- Exibi��o dos resultados
    DBMS_OUTPUT.PUT_LINE('1. Total de abrigos cadastrados: ' || v_total_abrigos);
    DBMS_OUTPUT.PUT_LINE('2. Abrigos que atendem m�ltiplas emerg�ncias: ' || v_abrigos_multiplas_emergencias);
    DBMS_OUTPUT.PUT_LINE('3. Tipo de emerg�ncia mais atendido: ' || v_tipo_mais_comum);
    DBMS_OUTPUT.PUT_LINE('4. M�dia de tipos de emerg�ncia por abrigo: ' || ROUND(v_media_tipos_por_abrigo, 2));
    DBMS_OUTPUT.PUT_LINE('5. Capacidade m�dia dos abrigos: ' || ROUND(v_capacidade_media, 2) || ' pessoas');
    
    IF v_abrigos_sem_localizacao > 0 THEN
        DBMS_OUTPUT.PUT_LINE('6. ALERTA: ' || v_abrigos_sem_localizacao || ' abrigos sem localiza��o cadastrada!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('6. Todos os abrigos possuem localiza��o cadastrada.');
    END IF;
END;
/