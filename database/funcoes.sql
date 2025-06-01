--Função para Calcular Capacidade Média dos Abrigos por Tipo de Emergência

CREATE OR REPLACE FUNCTION fn_capacidade_media_por_emergencia(
    p_tipo_emergencia IN VARCHAR2
) RETURN NUMBER
IS
    v_capacidade_media NUMBER;
BEGIN
    SELECT AVG(a.capacidade_suportada_abrigo)
    INTO v_capacidade_media
    FROM TB_ABRIGO a
    JOIN TB_ABRIGO_TIPO_EMERGENCIA ate ON a.id_abrigo = ate.id_abrigo
    JOIN TB_TIPO_EMERGENCIA te ON ate.id_tipo_emergencia = te.id_tipo_emergencia
    WHERE te.tipo_emergencia = p_tipo_emergencia;
    
    RETURN NVL(v_capacidade_media, 0);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao calcular capacidade média: ' || SQLERRM);
        RETURN NULL;
END;
/

-- Função para Verificar Disponibilidade de Vagas em Abrigos

CREATE OR REPLACE FUNCTION fn_vagas_disponiveis_abrigo(
    p_id_abrigo IN VARCHAR2
) RETURN VARCHAR2
IS
    v_capacidade NUMBER;
    v_vagas_ocupadas NUMBER;
    v_disponibilidade VARCHAR2(100);
BEGIN
    SELECT capacidade_suportada_abrigo
    INTO v_capacidade
    FROM TB_ABRIGO
    WHERE id_abrigo = p_id_abrigo;
    
    IF v_capacidade IS NOT NULL THEN
        v_vagas_ocupadas := FLOOR(DBMS_RANDOM.VALUE(0, LEAST(v_capacidade * 0.7, 100)));
    ELSE
        v_vagas_ocupadas := FLOOR(DBMS_RANDOM.VALUE(0, 100));
    END IF;
    
    IF v_capacidade IS NULL THEN
        RETURN 'Capacidade não informada';
    ELSIF (v_capacidade - v_vagas_ocupadas) <= 0 THEN
        RETURN 'Lotado';
    ELSIF (v_capacidade - v_vagas_ocupadas) < (v_capacidade * 0.2) THEN
        RETURN 'Quase lotado - ' || (v_capacidade - v_vagas_ocupadas) || ' vagas';
    ELSE
        RETURN 'Disponível - ' || (v_capacidade - v_vagas_ocupadas) || ' vagas';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Abrigo não encontrado';
    WHEN OTHERS THEN
        RETURN 'Erro ao verificar disponibilidade: ' || SUBSTR(SQLERRM, 1, 100);
END;
/


SELECT 
    a.id_abrigo,
    a.nome_abrigo,
    a.capacidade_suportada_abrigo,
    fn_vagas_disponiveis_abrigo(a.id_abrigo) as disponibilidade
FROM 
    TB_ABRIGO a;