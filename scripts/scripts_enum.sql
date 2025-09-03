-- Criação da base de dados
DROP DATABASE IF EXISTS planos_enum;
CREATE DATABASE planos_enum;
\c planos_enum;

-- Criação de ENUM com planos de saúde:
DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'plano_saude_enum') THEN
        CREATE TYPE plano_saude_enum AS ENUM (
            'Alice',
            'Allianz Saude',
            'Amil',
            'Bradesco Saude',
            'Caixa Saude',
            'Porto Seguro Saude',
            'Prevent Senior',
            'Sul America',
            'Unimed'
        );
    END IF;
END $$;

-- Criação da tabela Profissional:
CREATE TABLE Profissional (
    id_profissional SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    telefone VARCHAR(12),
    email VARCHAR(100) UNIQUE,
    endereco VARCHAR(100),
    cidade VARCHAR(50),
    CPF VARCHAR(11) UNIQUE CHECK (CPF ~ '^[0-9]{11}$'),
    CNPJ VARCHAR(18) UNIQUE CHECK (CNPJ ~ '^[0-9]{14,18}$'),
    planos_aceitos plano_saude_enum[] NOT NULL
);

-- Criação de índices:
-- Índices para profissional de saúde:
CREATE INDEX idx_profissional_nome ON Profissional(nome);
CREATE INDEX idx_profissional_especialidade ON Profissional(especialidade);
CREATE INDEX idx_profissional_telefone ON Profissional(telefone);
CREATE INDEX idx_profissional_email ON Profissional(email);
CREATE INDEX idx_profissional_cidade ON Profissional(cidade);
CREATE INDEX idx_profissional_cpf ON Profissional(cpf);
CREATE INDEX idx_profissional_cnpj ON Profissional(cnpj);

-- Índice GIN para ENUM
CREATE INDEX idx_profissional_planos
    ON Profissional USING GIN (planos_aceitos);
