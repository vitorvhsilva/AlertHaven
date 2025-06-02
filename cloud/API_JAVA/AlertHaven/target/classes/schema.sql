DROP TABLE IF EXISTS TB_ABRIGO_TIPO_EMERGENCIA;
DROP TABLE IF EXISTS TB_LOCALIZACAO;
DROP TABLE IF EXISTS TB_USUARIO;
DROP TABLE IF EXISTS TB_TIPO_EMERGENCIA;
DROP TABLE IF EXISTS TB_ABRIGO;

CREATE TABLE TB_USUARIO (
    id_usuario VARCHAR(255) PRIMARY KEY,
    nome_usuario VARCHAR(255) NOT NULL,
    email_usuario VARCHAR(255) NOT NULL,
    senha_usuario VARCHAR(255) NOT NULL,
    cpf_usuario VARCHAR(255) NOT NULL,
    telefone_usuario VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_criacao_usuario TIMESTAMP NOT NULL
);

CREATE TABLE TB_TIPO_EMERGENCIA (
    id_tipo_emergencia INTEGER PRIMARY KEY,
    tipo_emergencia VARCHAR(255)
);

CREATE TABLE TB_ABRIGO (
    id_abrigo VARCHAR(255) PRIMARY KEY,
    nome_abrigo VARCHAR(255) NOT NULL,
    capacidade_suportada_abrigo INTEGER NOT NULL,
    email_abrigo VARCHAR(50) NOT NULL
);

CREATE TABLE TB_LOCALIZACAO (
    id_localizacao VARCHAR(255) PRIMARY KEY,
    identificacao_unica_abrigo VARCHAR(255),
    latitude_abrigo VARCHAR(255),
    longitude_abrigo VARCHAR(255),
    rua_abrigo VARCHAR(255),
    id_abrigo VARCHAR(255) REFERENCES TB_ABRIGO(id_abrigo)
);

CREATE TABLE TB_ABRIGO_TIPO_EMERGENCIA (
    id_abrigo VARCHAR(255) REFERENCES TB_ABRIGO(id_abrigo),
    id_tipo_emergencia INTEGER REFERENCES TB_TIPO_EMERGENCIA(id_tipo_emergencia),
    PRIMARY KEY (id_abrigo, id_tipo_emergencia)
);