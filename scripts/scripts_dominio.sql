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

-- Criação da tabela PlanodeSaude:
CREATE TABLE PlanodeSaude (
    id_plano INTEGER(10) PRIMARY KEY,
    nome VARCHAR(200) NOT NULL UNIQUE,
    telefone VARCHAR(12),
    email VARCHAR(100) UNIQUE,
    registro_ANS VARCHAR(6) UNIQUE,
    CNPJ VARCHAR(18) UNIQUE CHECK (CNPJ ~ '^[0-9]{14,18}$')
);

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
-- Índices para Profissional:
CREATE INDEX idx_profissional_nome ON Profissional(nome);
CREATE INDEX idx_profissional_cidade ON Profissional(cidade);
CREATE INDEX idx_profissional_cpf ON Profissional(cpf);
CREATE INDEX idx_profissional_cnpj ON Profissional(cnpj);
CREATE INDEX idx_profissional_espec ON Profissional(especialidade);

-- Índices para PlanodeSaude:
CREATE INDEX idx_plano_nome ON PlanodeSaude(nome);
CREATE INDEX idx_plano_registroans ON PlanodeSaude(registro_ans);
CREATE INDEX idx_plano_cnpj ON PlanodeSaude(cnpj);

-- Índices Profissional_Plano:
CREATE INDEX idx_profissionalplano_status ON Profissional_Plano(status_contrato);
CREATE INDEX idx_profissionalplano_data_inicio ON Profissional_Plano(data_inicio_contrato);
CREATE INDEX idx_profissionalplano_data_fim ON Profissional_Plano(data_fim_contrato);
CREATE INDEX idx_profissionalplano_prof_plano ON Profissional_Plano(id_profissional, id_plano);
