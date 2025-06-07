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
        identificacao_unica_abrigo, 
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
    DBMS_OUTPUT.PUT_LINE('Localiza??o inserida com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir localiza??o: ' || SQLERRM);
END;
/
-- Bloco do procedure para inserir localiza??o:
DECLARE
    v_id_abrigo VARCHAR2(100) := '6ba7b810-9dad-11d1-80b4-00c04fd430c0';
    v_identificacao VARCHAR2(100) := '08321332';
    v_latitude VARCHAR2(50) := '-23.550520';
    v_longitude VARCHAR2(50) := '-46.633308';
    v_rua VARCHAR2(200) := 'Rua S?o Francisco, 123';
    v_id_localizacao VARCHAR2(36);
BEGIN
    -- Gerar novo UUID
    v_id_localizacao := SYS_GUID();
    
    -- Inser??o direta na tabela
    INSERT INTO TB_LOCALIZACAO (
        ID_LOCALIZACAO,
        id_abrigo, 
        identificacao_unica_abrigo, 
        latitude_abrigo, 
        longitude_abrigo, 
        rua_abrigo
    ) VALUES (
        v_id_localizacao,
        v_id_abrigo,
        v_identificacao,
        v_latitude,
        v_longitude,
        v_rua
    );
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Localiza??o inserida com sucesso. ID: ' || v_id_localizacao);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro durante a execu??o: ' || SQLERRM);
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
    SET identificacao_unica_abrigo = p_identificacao,
        latitude_abrigo = p_latitude,
        longitude_abrigo = p_longitude,
        rua_abrigo = p_rua
    WHERE id_abrigo = p_id_abrigo;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para atualiza??o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Localiza??o atualizada com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar localiza??o: ' || SQLERRM);
END;
/

-- Bloco para testar o procedure de atualizar localiza??o
DECLARE
    -- Vari?veis com os dados para atualiza??o
    v_id_abrigo VARCHAR2(100) := '6ba7b810-9dad-11d1-80b4-00c04fd430c0'; -- ID do abrigo a ser atualizado
    v_identificacao VARCHAR2(100) := 'LOC-2023-001-UPD'; -- Nova identifica??o
    v_latitude VARCHAR2(50) := '-23.550521'; -- Nova latitude (alterado ?ltimo d?gito)
    v_longitude VARCHAR2(50) := '-46.633309'; -- Nova longitude (alterado ?ltimo d?gito)
    v_rua VARCHAR2(200) := 'Rua S?o Francisco, 123 - Alt'; -- Novo endere?o
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando atualiza??o de localiza??o...');
    
    -- Chamada da procedure
    sp_atualizar_localizacao(
        p_id_abrigo => v_id_abrigo,
        p_identificacao => v_identificacao,
        p_latitude => v_latitude,
        p_longitude => v_longitude,
        p_rua => v_rua
    );
    
    DBMS_OUTPUT.PUT_LINE('Opera??o conclu?da.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro durante a execu??o: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_excluir_localizacao(
    p_id_abrigo IN VARCHAR2
) AS
BEGIN
    DELETE FROM TB_LOCALIZACAO
    WHERE id_abrigo = p_id_abrigo;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para exclus?o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Localiza??o exclu?da com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir localiza??o: ' || SQLERRM);
END;
/

-- Bloco para testar o procedure de excluir
DECLARE
    v_id_abrigo VARCHAR2(100) := '6ba7b810-9dad-11d1-80b4-00c04fd430c0'; -- Substitua pelo ID real
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando exclus?o de localiza??o...');
    
    -- Chamada da procedure
    sp_excluir_localizacao(
        p_id_abrigo => v_id_abrigo
    );
    
    DBMS_OUTPUT.PUT_LINE('Opera??o conclu?da.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro durante a execu??o: ' || SQLERRM);
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
-- Bloco para testar o procedure de inserir o abrigo
DECLARE
    v_id_abrigo VARCHAR2(100) := 'ABR-' || TO_CHAR(SYSDATE, 'YYYYMMDD') || '-' || DBMS_RANDOM.STRING('A', 3);
    v_nome VARCHAR2(100) := 'Abrigo Nova Esperan?a';
    v_capacidade NUMBER := 150;
    v_email VARCHAR2(100) := 'abrigo.novaesperanca@example.com';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando inser??o de novo abrigo...');
    
    sp_inserir_abrigo(
        p_id_abrigo => v_id_abrigo,
        p_nome => v_nome,
        p_capacidade => v_capacidade,
        p_email => v_email
    );
    
    DBMS_OUTPUT.PUT_LINE('Opera??o conclu?da. ID do novo abrigo: ' || v_id_abrigo);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro durante a execu??o: ' || SQLERRM);
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
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para atualiza??o.');
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

-- Bloco para testar a procedure de atualizar abrigo
DECLARE
    -- Valores fixos para atualiza??o
    v_id_abrigo VARCHAR2(100) := 'ABR-20250606-Pvw'; -- ID do abrigo a ser atualizado
    v_nome VARCHAR2(100) := 'Abrigo Esperan?a Renovada';
    v_capacidade NUMBER := 200; -- Nova capacidade
    v_email VARCHAR2(100) := 'esperanca.renovada@abrigos.org'; -- Novo e-mail
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando atualiza??o do abrigo...');
    DBMS_OUTPUT.PUT_LINE('ID do abrigo: ' || v_id_abrigo);
    DBMS_OUTPUT.PUT_LINE('Novo nome: ' || v_nome);
    DBMS_OUTPUT.PUT_LINE('Nova capacidade: ' || v_capacidade);
    DBMS_OUTPUT.PUT_LINE('Novo e-mail: ' || v_email);
    
    -- Chamada da procedure
    sp_atualizar_abrigo(
        p_id_abrigo => v_id_abrigo,
        p_nome => v_nome,
        p_capacidade => v_capacidade,
        p_email => v_email
    );
    
    DBMS_OUTPUT.PUT_LINE('Opera??o conclu?da.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro durante a execu??o: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_excluir_abrigo(
    p_id_abrigo IN VARCHAR2
) AS
BEGIN
    DELETE FROM TB_ABRIGO
    WHERE id_abrigo = p_id_abrigo;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para exclus?o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Abrigo exclu?do com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir abrigo: ' || SQLERRM);
END;
/
-- Bloco para testar o procedure de excluir abrigo
DECLARE
    v_id_abrigo VARCHAR2(100) := 'ABR-20250606-pMI'; -- ID do abrigo a ser exclu?do
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando exclus?o do abrigo...');
    DBMS_OUTPUT.PUT_LINE('ID do abrigo: ' || v_id_abrigo);
    
    -- Chamada da procedure
    sp_excluir_abrigo(
        p_id_abrigo => v_id_abrigo
    );
    
    DBMS_OUTPUT.PUT_LINE('Opera??o conclu?da.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro durante a execu??o: ' || SQLERRM);
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
    DBMS_OUTPUT.PUT_LINE('Usu?rio inserido com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir usu?rio: ' || SQLERRM);
END;
/

-- Bloco para testar a procedure de inserir usu?rio
DECLARE
    -- Valores fixos para inser??o
    v_id_usuario VARCHAR2(36) := SYS_GUID(); 
    v_nome VARCHAR2(100) := 'Jo?o da Silva';
    v_email VARCHAR2(100) := 'joao.silva@example.com';
    v_senha VARCHAR2(100) := 'Senha@123';
    v_cpf VARCHAR2(14) := '123.456.789-00';
    v_telefone VARCHAR2(15) := '(11) 98765-4321';
    v_data_nascimento TIMESTAMP := TO_TIMESTAMP('15/05/1985', 'DD/MM/YYYY');
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando inser??o de novo usu?rio...');
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_usuario);
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome);
    DBMS_OUTPUT.PUT_LINE('E-mail: ' || v_email);
    DBMS_OUTPUT.PUT_LINE('CPF: ' || v_cpf);
    DBMS_OUTPUT.PUT_LINE('Telefone: ' || v_telefone);
    DBMS_OUTPUT.PUT_LINE('Data de Nascimento: ' || TO_CHAR(v_data_nascimento, 'DD/MM/YYYY'));
    
    -- Chamada da procedure
    sp_inserir_usuario(
        p_id_usuario => v_id_usuario,
        p_nome => v_nome,
        p_email => v_email,
        p_senha => v_senha,
        p_cpf => v_cpf,
        p_telefone => v_telefone,
        p_data_nascimento => v_data_nascimento
    );
    
    DBMS_OUTPUT.PUT_LINE('Opera??o conclu?da com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro durante a execu??o: ' || SQLERRM);
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
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para atualiza??o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Usu?rio atualizado com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar usu?rio: ' || SQLERRM);
END;
/

-- Bloco para testar o procedure de atualizar usu?rio
DECLARE
    -- Valores fixos para atualiza??o
    v_id_usuario VARCHAR2(36) := '36F0508138AA359CE065020C29DF5990'; 
    v_nome VARCHAR2(100) := 'Jo?o da Silva Updated';
    v_email VARCHAR2(100) := 'joao.updated@example.com';
    v_senha VARCHAR2(100) := 'NovaSenha@123';
    v_telefone VARCHAR2(15) := '(11) 98765-0001';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando atualiza??o do usu?rio...');
    DBMS_OUTPUT.PUT_LINE('ID do usu?rio: ' || v_id_usuario);
    
    -- Chamada da procedure
    sp_atualizar_usuario(
        p_id_usuario => v_id_usuario,
        p_nome => v_nome,
        p_email => v_email,
        p_senha => v_senha,
        p_telefone => v_telefone
    );
    
    DBMS_OUTPUT.PUT_LINE('Opera??o conclu?da.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro durante a execu??o: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_excluir_usuario(
    p_id_usuario IN VARCHAR2
) AS
BEGIN
    DELETE FROM TB_USUARIO
    WHERE id_usuario = p_id_usuario;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para exclus?o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Usu?rio exclu?do com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir usu?rio: ' || SQLERRM);
END;
/
-- Bloco para testar o procedure de excluir usu?rio
DECLARE
    v_id_usuario VARCHAR2(36) := '36F0508138AA359CE065020C29DF5990';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando exclus?o do usu?rio...');
    DBMS_OUTPUT.PUT_LINE('ID do usu?rio: ' || v_id_usuario);
    
    -- Chamada da procedure
    sp_excluir_usuario(
        p_id_usuario => v_id_usuario
    );
    
    DBMS_OUTPUT.PUT_LINE('Opera??o conclu?da.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro durante a execu??o: ' || SQLERRM);
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
    DBMS_OUTPUT.PUT_LINE('Tipo de emerg?ncia inserido com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir tipo de emerg?ncia: ' || SQLERRM);
END;
/
-- Bloco para testar o procedure de inserir o tipo de emerg?ncia
DECLARE
    v_id_tipo NUMBER := 10; -- ID do novo tipo de emerg?ncia
    v_tipo VARCHAR2(100) := 'Enchente'; -- Nome do tipo de emerg?ncia
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando inser??o de tipo de emerg?ncia...');
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_tipo || ', Tipo: ' || v_tipo);
    
    -- Chamada da procedure
    sp_inserir_tipo_emergencia(
        p_id_tipo => v_id_tipo,
        p_tipo => v_tipo
    );
    
    DBMS_OUTPUT.PUT_LINE('Opera??o conclu?da com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro durante a execu??o: ' || SQLERRM);
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
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para atualiza??o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Tipo de emerg?ncia atualizado com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar tipo de emerg?ncia: ' || SQLERRM);
END;
/
-- Bloco para testar o procedure de atualizar tipo de emerg?ncia
DECLARE
    v_id_tipo NUMBER := 1; 
    v_novo_tipo VARCHAR2(100) := 'Inunda??o Severa'; -- Novo nome para o tipo
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando atualiza??o do tipo de emerg?ncia...');
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_tipo || ' | Novo tipo: ' || v_novo_tipo);
    
    -- Chamada da procedure
    sp_atualizar_tipo_emergencia(
        p_id_tipo => v_id_tipo,
        p_tipo => v_novo_tipo
    );
    
    DBMS_OUTPUT.PUT_LINE('Opera??o conclu?da.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro durante a execu??o: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_excluir_tipo_emergencia(
    p_id_tipo IN NUMBER
) AS
BEGIN
    DELETE FROM TB_TIPO_EMERGENCIA
    WHERE id_tipo_emergencia = p_id_tipo;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para exclus?o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Tipo de emerg?ncia exclu?do com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir tipo de emerg?ncia: ' || SQLERRM);
END;
/
-- Bloco para testar o procedure de excluir tipo de emerg?ncia
DECLARE
    v_id_tipo NUMBER := 999; 
BEGIN
    DECLARE
        v_existe NUMBER;
        v_dependentes NUMBER;
    BEGIN
        -- Verificar exist?ncia do tipo
        SELECT COUNT(*) INTO v_existe
        FROM TB_TIPO_EMERGENCIA
        WHERE id_tipo_emergencia = v_id_tipo;
        
        IF v_existe = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Tipo de emerg?ncia com ID ' || v_id_tipo || ' n?o encontrado.');
            RETURN;
        END IF;
        
        -- Verificar depend?ncias b?sicas (ajuste conforme suas tabelas)
        SELECT COUNT(*) INTO v_dependentes
        FROM TB_ABRIGO_TIPO_EMERGENCIA
        WHERE id_tipo_emergencia = v_id_tipo;
        
        IF v_dependentes > 0 THEN
            DBMS_OUTPUT.PUT_LINE('N?o ? poss?vel excluir - existem ' || v_dependentes || ' abrigos vinculados.');
            RETURN;
        END IF;
    END;
    
    -- Executar a exclus?o
    DBMS_OUTPUT.PUT_LINE('Iniciando exclus?o do tipo ID: ' || v_id_tipo);
    sp_excluir_tipo_emergencia(p_id_tipo => v_id_tipo);
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
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
    DBMS_OUTPUT.PUT_LINE('Rela??o abrigo-tipo emerg?ncia inserida com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir rela??o abrigo-tipo emerg?ncia: ' || SQLERRM);
END;
/
-- Bloco para testar o procedure de inserir abrigo tipo emerg?ncia 
DECLARE
    -- Valores que existem nas tabelas relacionadas
    v_id_abrigo VARCHAR2(100) := 'ABR-20250606-Pvw'; 
    v_id_tipo NUMBER := 1; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando inser??o de rela??o abrigo-tipo...');
    DBMS_OUTPUT.PUT_LINE('Abrigo: ' || v_id_abrigo || ' | Tipo Emerg?ncia: ' || v_id_tipo);
    
    -- Verificar exist?ncia dos registros pais
    DECLARE
        v_abrigo_existe NUMBER;
        v_tipo_existe NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_abrigo_existe
        FROM TB_ABRIGO
        WHERE id_abrigo = v_id_abrigo;
        
        SELECT COUNT(*) INTO v_tipo_existe
        FROM TB_TIPO_EMERGENCIA
        WHERE id_tipo_emergencia = v_id_tipo;
        
        IF v_abrigo_existe = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Abrigo n?o encontrado.');
            RETURN;
        ELSIF v_tipo_existe = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Tipo de emerg?ncia n?o encontrado.');
            RETURN;
        END IF;
    END;
    
    -- Chamada segura da procedure
    sp_inserir_abrigo_tipo_emergencia(
        p_id_abrigo => v_id_abrigo,
        p_id_tipo => v_id_tipo
    );
    
    DBMS_OUTPUT.PUT_LINE('Opera??o conclu?da com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro durante a execu??o: ' || SQLERRM);
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
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para exclus?o.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Rela??o abrigo-tipo emerg?ncia exclu?da com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir rela??o abrigo-tipo emerg?ncia: ' || SQLERRM);
END;
/

-- Bloco para testar o procedure de excluir abrigo_tipo_emergencia
DECLARE
    v_id_abrigo VARCHAR2(100) := 'ABR-20250606-Pvw'; 
    v_id_tipo NUMBER := 1;                 
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando exclus?o da rela??o abrigo-tipo...');
    DBMS_OUTPUT.PUT_LINE('Abrigo: ' || v_id_abrigo || ' | Tipo Emerg?ncia: ' || v_id_tipo);
    
    -- Verificar exist?ncia da rela??o antes de excluir
    DECLARE
        v_relacao_existe NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_relacao_existe
        FROM TB_ABRIGO_TIPO_EMERGENCIA
        WHERE id_abrigo = v_id_abrigo
        AND id_tipo_emergencia = v_id_tipo;
        
        IF v_relacao_existe = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Aviso: Esta rela??o n?o existe na base de dados.');
            RETURN;
        END IF;
    END;
    
    -- Executar a exclus?o
    sp_excluir_abrigo_tipo_emergencia(
        p_id_abrigo => v_id_abrigo,
        p_id_tipo => v_id_tipo
    );
    
    DBMS_OUTPUT.PUT_LINE('Opera??o conclu?da.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro durante a execu??o: ' || SQLERRM);
END;
/