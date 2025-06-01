set verify off;
set serveroutput on;

DROP TABLE TB_LOCALIZACAO CASCADE CONSTRAINTS;
DROP TABLE TB_ABRIGO CASCADE CONSTRAINTS;
DROP TABLE TB_USUARIO CASCADE CONSTRAINTS;
DROP TABLE TB_TIPO_EMERGENCIA CASCADE CONSTRAINTS;
DROP TABLE TB_ABRIGO_TIPO_EMERGENCIA CASCADE CONSTRAINTS;

CREATE TABLE TB_LOCALIZACAO (
    id_abrigo VARCHAR(255),
    identificacao_unica_abriga VARCHAR(255) NOT NULL,
    latitude_abrigo VARCHAR(255),
    longitude_abrigo VARCHAR(255),
    rua_abrigo VARCHAR(255) NOT NULL,
    CONSTRAINT tb_localizacao_id_abrigo_pk PRIMARY KEY(id_abrigo),
    CONSTRAINT ck_localizacao_latitude 
        CHECK (REGEXP_LIKE(latitude_abrigo, '^-?\d+(\.\d+)?$')),
    CONSTRAINT ck_localizacao_longitude 
        CHECK (REGEXP_LIKE(longitude_abrigo, '^-?\d+(\.\d+)?$'))
);

CREATE TABLE TB_ABRIGO (
    id_abrigo VARCHAR(255),
    nome_abrigo VARCHAR(255) NOT NULL,
    capacidade_suportada_abrigo NUMBER,
    email_abrigo VARCHAR(255) NOT NULL,
    CONSTRAINT tb_abrigo_id_abrigo_pk PRIMARY KEY(id_abrigo),
    CONSTRAINT ck_abrigo_email 
        CHECK (REGEXP_LIKE(email_abrigo, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'))
);

CREATE TABLE TB_USUARIO (
    id_usuario VARCHAR(255),
    nome_usuario VARCHAR(255) NOT NULL,
    email_usuario VARCHAR(255) NOT NULL UNIQUE,
    senha_usuario VARCHAR(255) NOT NULL,
    cpf_usuario VARCHAR(255) NOT NULL UNIQUE,
    telefone_usuario VARCHAR(255) NOT NULL, 
    data_nascimento TIMESTAMP NOT NULL,
    data_criacao_usuario TIMESTAMP NOT NULL,
    CONSTRAINT tb_usuario_id_usuario_pk PRIMARY KEY (id_usuario),
    CONSTRAINT ck_usuario_email 
        CHECK (REGEXP_LIKE(email_usuario, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')),
    CONSTRAINT ck_usuario_cpf 
        CHECK (REGEXP_LIKE(cpf_usuario, '^\d{11}$')),
    CONSTRAINT ck_usuario_telefone 
        CHECK (REGEXP_LIKE(telefone_usuario, '^[0-9]{10,11}$'))
);

CREATE TABLE TB_TIPO_EMERGENCIA (
    id_tipo_emergencia NUMBER,
    tipo_emergencia VARCHAR(255) NOT NULL,
    CONSTRAINT tb_tipo_emergencia_id_tipo_emergencia_pk PRIMARY KEY(id_tipo_emergencia),
    CONSTRAINT ck_tipo_emergencia_valido 
        CHECK (tipo_emergencia IN ('ALAGAMENTO', 'TERREMOTO', 'ONDA_DE_CALOR', 'CHUVA_FORTE', 'FURACAO'))
);

CREATE TABLE TB_ABRIGO_TIPO_EMERGENCIA (
    id_abrigo VARCHAR(255),
    id_tipo_emergencia NUMBER,
    CONSTRAINT tb_abrigo_tipo_emergencia_id_abrigo_fk FOREIGN KEY(id_abrigo)
        REFERENCES TB_ABRIGO(id_abrigo),
    CONSTRAINT tb_abrigo_tipo_emergencia_id_tipo_emergencia_fk FOREIGN KEY(id_tipo_emergencia)
        REFERENCES TB_TIPO_EMERGENCIA(id_tipo_emergencia)
);