//PROCEDURE LOCALIZACAO

CREATE OR REPLACE PROCEDURE sp_inserir_localizacao(
    p_id_abrigo IN VARCHAR2,
    p_identificacao IN VARCHAR2,
    p_latitude IN VARCHAR2,
    p_longitude IN VARCHAR2,
    p_rua IN VARCHAR2
) AS
BEGIN
    INSERT INTO TB_LOCALIZACAO (
        id_abrigo, 
        identificacao_unica_abriga, 
        latitude_abrigo, 
        longitude_abrigo, 
        rua_abrigo
    ) VALUES (
        p_id_abrigo,
        p_identificacao,
        p_latitude,
        p_longitude,
        p_rua
    );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Localiza��o inserida com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir localiza��o: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_atualizar_localizacao(
    p_id_abrigo IN VARCHAR2,
    p_identificacao IN VARCHAR2,
    p_latitude IN VARCHAR2,
    p_longitude IN VARCHAR2,
    p_rua IN VARCHAR2
) AS
BEGIN
    UPDATE TB_LOCALIZACAO
    SET identificacao_unica_abriga = p_identificacao,
        latitude_abrigo = p_latitude,
        longitude_abrigo = p_longitude,
        rua_abrigo = p_rua
    WHERE id_abrigo = p_id_abrigo;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para atualiza��o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Localiza��o atualizada com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar localiza��o: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_excluir_localizacao(
    p_id_abrigo IN VARCHAR2
) AS
BEGIN
    DELETE FROM TB_LOCALIZACAO
    WHERE id_abrigo = p_id_abrigo;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para exclus�o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Localiza��o exclu�da com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir localiza��o: ' || SQLERRM);
END;
/













//PROCEDURE ABRIGO

CREATE OR REPLACE PROCEDURE sp_inserir_abrigo(
    p_id_abrigo IN VARCHAR2,
    p_nome IN VARCHAR2,
    p_capacidade IN NUMBER,
    p_email IN VARCHAR2
) AS
BEGIN
    INSERT INTO TB_ABRIGO (
        id_abrigo,
        nome_abrigo,
        capacidade_suportada_abrigo,
        email_abrigo
    ) VALUES (
        p_id_abrigo,
        p_nome,
        p_capacidade,
        p_email
    );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Abrigo inserido com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir abrigo: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_atualizar_abrigo(
    p_id_abrigo IN VARCHAR2,
    p_nome IN VARCHAR2,
    p_capacidade IN NUMBER,
    p_email IN VARCHAR2
) AS
BEGIN
    UPDATE TB_ABRIGO
    SET nome_abrigo = p_nome,
        capacidade_suportada_abrigo = p_capacidade,
        email_abrigo = p_email
    WHERE id_abrigo = p_id_abrigo;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para atualiza��o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Abrigo atualizado com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar abrigo: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_excluir_abrigo(
    p_id_abrigo IN VARCHAR2
) AS
BEGIN
    DELETE FROM TB_ABRIGO
    WHERE id_abrigo = p_id_abrigo;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para exclus�o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Abrigo exclu�do com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir abrigo: ' || SQLERRM);
END;
/















//PROCEDURE USUARIO

CREATE OR REPLACE PROCEDURE sp_inserir_usuario(
    p_id_usuario IN VARCHAR2,
    p_nome IN VARCHAR2,
    p_email IN VARCHAR2,
    p_senha IN VARCHAR2,
    p_cpf IN VARCHAR2,
    p_telefone IN VARCHAR2,
    p_data_nascimento IN TIMESTAMP
) AS
BEGIN
    INSERT INTO TB_USUARIO (
        id_usuario,
        nome_usuario,
        email_usuario,
        senha_usuario,
        cpf_usuario,
        telefone_usuario,
        data_nascimento,
        data_criacao_usuario
    ) VALUES (
        p_id_usuario,
        p_nome,
        p_email,
        p_senha,
        p_cpf,
        p_telefone,
        p_data_nascimento,
        SYSTIMESTAMP
    );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Usu�rio inserido com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir usu�rio: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_atualizar_usuario(
    p_id_usuario IN VARCHAR2,
    p_nome IN VARCHAR2,
    p_email IN VARCHAR2,
    p_senha IN VARCHAR2,
    p_telefone IN VARCHAR2
) AS
BEGIN
    UPDATE TB_USUARIO
    SET nome_usuario = p_nome,
        email_usuario = p_email,
        senha_usuario = p_senha,
        telefone_usuario = p_telefone
    WHERE id_usuario = p_id_usuario;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para atualiza��o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Usu�rio atualizado com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar usu�rio: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_excluir_usuario(
    p_id_usuario IN VARCHAR2
) AS
BEGIN
    DELETE FROM TB_USUARIO
    WHERE id_usuario = p_id_usuario;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para exclus�o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Usu�rio exclu�do com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir usu�rio: ' || SQLERRM);
END;
/

















//PROCEDURE TIPO EMERGENCIA

CREATE OR REPLACE PROCEDURE sp_inserir_tipo_emergencia(
    p_id_tipo IN NUMBER,
    p_tipo IN VARCHAR2
) AS
BEGIN
    INSERT INTO TB_TIPO_EMERGENCIA (
        id_tipo_emergencia,
        tipo_emergencia
    ) VALUES (
        p_id_tipo,
        p_tipo
    );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Tipo de emerg�ncia inserido com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir tipo de emerg�ncia: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_atualizar_tipo_emergencia(
    p_id_tipo IN NUMBER,
    p_tipo IN VARCHAR2
) AS
BEGIN
    UPDATE TB_TIPO_EMERGENCIA
    SET tipo_emergencia = p_tipo
    WHERE id_tipo_emergencia = p_id_tipo;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para atualiza��o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Tipo de emerg�ncia atualizado com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar tipo de emerg�ncia: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_excluir_tipo_emergencia(
    p_id_tipo IN NUMBER
) AS
BEGIN
    DELETE FROM TB_TIPO_EMERGENCIA
    WHERE id_tipo_emergencia = p_id_tipo;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para exclus�o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Tipo de emerg�ncia exclu�do com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir tipo de emerg�ncia: ' || SQLERRM);
END;
/















//PROCEDURE ABRIGO TIPO EMERGENCIA


CREATE OR REPLACE PROCEDURE sp_inserir_abrigo_tipo_emergencia(
    p_id_abrigo IN VARCHAR2,
    p_id_tipo IN NUMBER
) AS
BEGIN
    INSERT INTO TB_ABRIGO_TIPO_EMERGENCIA (
        id_abrigo,
        id_tipo_emergencia
    ) VALUES (
        p_id_abrigo,
        p_id_tipo
    );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Rela��o abrigo-tipo emerg�ncia inserida com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir rela��o abrigo-tipo emerg�ncia: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE sp_excluir_abrigo_tipo_emergencia(
    p_id_abrigo IN VARCHAR2,
    p_id_tipo IN NUMBER
) AS
BEGIN
    DELETE FROM TB_ABRIGO_TIPO_EMERGENCIA
    WHERE id_abrigo = p_id_abrigo
    AND id_tipo_emergencia = p_id_tipo;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para exclus�o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Rela��o abrigo-tipo emerg�ncia exclu�da com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir rela��o abrigo-tipo emerg�ncia: ' || SQLERRM);
END;
/