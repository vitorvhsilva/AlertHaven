// os varchar sao uuids

DELETE FROM TB_LOCALIZACAO;
DELETE FROM TB_ABRIGO_TIPO_EMERGENCIA;
DELETE FROM TB_ABRIGO;
DELETE FROM TB_TIPO_EMERGENCIA;
DELETE FROM TB_USUARIO;


BEGIN
    sp_inserir_tipo_emergencia(1, 'ALAGAMENTO');
    sp_inserir_tipo_emergencia(2, 'TERREMOTO');
    sp_inserir_tipo_emergencia(3, 'ONDA_DE_CALOR');
    sp_inserir_tipo_emergencia(4, 'CHUVA_FORTE');
    sp_inserir_tipo_emergencia(5, 'FURACAO');
    COMMIT;
END;
/
BEGIN
    sp_inserir_abrigo('09cfbcd3-a118-4c62-a340-3eda95554b1f', 'Abrigo Central', 150, 'central@abrigo.com');
    sp_inserir_abrigo('1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d', 'Abrigo Norte', 80, 'norte@abrigo.com');
    sp_inserir_abrigo('2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e', 'Abrigo Sul', 100, 'sul@abrigo.com');
    sp_inserir_abrigo('3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f', 'Abrigo Leste', 60, 'leste@abrigo.com');
    sp_inserir_abrigo('4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a', 'Abrigo Oeste', 120, 'oeste@abrigo.com');
    COMMIT;
END;
/
BEGIN
    sp_inserir_localizacao('09cfbcd3-a118-4c62-a340-3eda95554b1f', 'LOC001', '-23.550520', '-46.633308', 'Rua Central, 100');
    sp_inserir_localizacao('1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d', 'LOC002', '-23.500000', '-46.600000', 'Rua Norte, 200');
    sp_inserir_localizacao('2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e', 'LOC003', '-23.600000', '-46.650000', 'Rua Sul, 300');
    sp_inserir_localizacao('3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f', 'LOC004', '-23.550000', '-46.600000', 'Rua Leste, 400');
    sp_inserir_localizacao('4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a', 'LOC005', '-23.550000', '-46.666667', 'Rua Oeste, 500');
    COMMIT;
END;
/
BEGIN
    sp_inserir_usuario('5e6f7a8b-9c0d-1e2f-3a4b-5c6d7e8f9a0b', 'João Silva', 'joao@email.com', 'senha123', '12345678901', '11987654321', TO_TIMESTAMP('1990-01-15', 'YYYY-MM-DD'));
    sp_inserir_usuario('6f7a8b9c-0d1e-2f3a-4b5c-6d7e8f9a0b1c', 'Maria Souza', 'maria@email.com', 'senha456', '23456789012', '11976543210', TO_TIMESTAMP('1985-05-20', 'YYYY-MM-DD'));
    sp_inserir_usuario('7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d', 'Carlos Oliveira', 'carlos@email.com', 'senha789', '34567890123', '11965432109', TO_TIMESTAMP('1995-10-25', 'YYYY-MM-DD'));
    sp_inserir_usuario('8b9c0d1e-2f3a-4b5c-6d7e-8f9a0b1c2d3e', 'Ana Pereira', 'ana@email.com', 'senha012', '45678901234', '11954321098', TO_TIMESTAMP('1980-03-10', 'YYYY-MM-DD'));
    sp_inserir_usuario('9c0d1e2f-3a4b-5c6d-7e8f-9a0b1c2d3e4f', 'Pedro Santos', 'pedro@email.com', 'senha345', '56789012345', '11943210987', TO_TIMESTAMP('1992-07-30', 'YYYY-MM-DD'));
    COMMIT;
END;
/
BEGIN
    sp_inserir_abrigo_tipo_emergencia('09cfbcd3-a118-4c62-a340-3eda95554b1f', 1);
    sp_inserir_abrigo_tipo_emergencia('09cfbcd3-a118-4c62-a340-3eda95554b1f', 2);
    sp_inserir_abrigo_tipo_emergencia('1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d', 3);
    sp_inserir_abrigo_tipo_emergencia('2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e', 4);
    sp_inserir_abrigo_tipo_emergencia('3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f', 5);
    COMMIT;
END;
/