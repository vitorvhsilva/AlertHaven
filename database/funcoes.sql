--Fun??o para Calcular Capacidade Media dos Abrigos por Tipo de Emerg?ncia
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
        DBMS_OUTPUT.PUT_LINE('Erro ao calcular capacidade m?dia: ' || SQLERRM);
        RETURN NULL;
END;
/
-- Bloco sql para teste da funcao de calcular a capacidade m?dia
DECLARE
    v_tipo_emergencia VARCHAR2(100) := 'Furac?o'; -- Substitua pelo tipo de emerg?ncia desejado
    v_capacidade_media NUMBER;
BEGIN
    -- Chamar a fun??o e armazenar o resultado
    v_capacidade_media := fn_capacidade_media_por_emergencia(p_tipo_emergencia => v_tipo_emergencia);
    
    -- Exibir o resultado
    DBMS_OUTPUT.PUT_LINE('Capacidade m?dia para emerg?ncias do tipo ' || 
                         v_tipo_emergencia || ': ' || 
                         v_capacidade_media || ' pessoas');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao executar a fun??o: ' || SQLERRM);
END;
/

-- Funcao para Verificar Disponibilidade de Vagas em Abrigos

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
        RETURN 'Capacidade n?o informada';
    ELSIF (v_capacidade - v_vagas_ocupadas) <= 0 THEN
        RETURN 'Lotado';
    ELSIF (v_capacidade - v_vagas_ocupadas) < (v_capacidade * 0.2) THEN
        RETURN 'Quase lotado - ' || (v_capacidade - v_vagas_ocupadas) || ' vagas';
    ELSE
        RETURN 'Dispon?vel - ' || (v_capacidade - v_vagas_ocupadas) || ' vagas';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Abrigo n?o encontrado';
    WHEN OTHERS THEN
        RETURN 'Erro ao verificar disponibilidade: ' || SUBSTR(SQLERRM, 1, 100);
END;
/

-- Bloco para testar a funcao de verificacao de disponibilidade
DECLARE
    v_id_abrigo VARCHAR2(100) := 'ABR-20250606-Pvw'; -- Substitua pelo ID do abrigo desejado
    v_resultado VARCHAR2(200);
BEGIN
    -- Chamar a fun??o e armazenar o resultado
    v_resultado := fn_vagas_disponiveis_abrigo(p_id_abrigo => v_id_abrigo);
    
    -- Exibir o resultado
    DBMS_OUTPUT.PUT_LINE('Status do abrigo ' || v_id_abrigo || ': ' || v_resultado);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao executar o bloco: ' || SQLERRM);
END;
/

