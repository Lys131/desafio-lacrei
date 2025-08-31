-- Crianção da base de dados:
DROP DATABASE IF EXISTS planos_dominio;
CREATE DATABASE planos_dominio;
\c planos_dominio;

-- Criação da tabela Profissional:
CREATE TABLE Profissional (
    id_profissional INTEGER(10) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    telefone VARCHAR(12),
    email VARCHAR(100) UNIQUE,
    endereco VARCHAR(100),
    cidade VARCHAR(50),
    CPF VARCHAR(11) UNIQUE CHECK (CPF ~ '^[0-9]{11}$'),
    CNPJ VARCHAR(18) UNIQUE CHECK (CNPJ ~ '^[0-9]{14,18}$')
);

-- Criação de índice:
CREATE INDEX idx_profissional_especialidade ON Profissional(especialidade);

-- Criação da tabela PlanodeSaude:
CREATE TABLE PlanodeSaude (
    id_plano INTEGER(10) PRIMARY KEY,
    nome VARCHAR(200) NOT NULL UNIQUE,
    telefone VARCHAR(12),
    email VARCHAR(100) UNIQUE,
    registro_ANS VARCHAR(6) UNIQUE,
    CNPJ VARCHAR(18) UNIQUE CHECK (CNPJ ~ '^[0-9]{14,18}$')
);

-- Criação de índice:
CREATE INDEX idx_planosaude_nome ON PlanodeSaude(nome);

-- Criação tabela de domínio Profissional_Plano:
CREATE TABLE Profissional_Plano (
    id_contrato INTEGER(10) PRIMARY KEY,
    id_profissional INT NOT NULL REFERENCES Profissional(id_profissional) ON DELETE CASCADE,
    id_plano INT NOT NULL REFERENCES PlanoDeSaude(id_plano) ON DELETE CASCADE,
    status_contrato CHAR(1) NOT NULL CHECK (status_contrato IN ('A','I')),
    data_inicio_contrato DATE NOT NULL,
    data_fim_contrato DATE,
    condicoes_atendimento VARCHAR(300), 
	UNIQUE (id_profissional, id_plano)
);

-- Criação de índices:
CREATE INDEX idx_profissionalplano_profissional ON Profissional_Plano(id_profissional);
CREATE INDEX idx_profissionalplano_plano ON Profissional_Plano(id_plano);
CREATE INDEX idx_profissionalplano_status ON Profissional_Plano(status_contrato);
