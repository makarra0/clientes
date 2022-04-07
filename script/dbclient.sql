--
-- File generated with SQLiteStudio v3.3.3 on qui abr 7 10:03:10 2022
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

--DataBase: dbClient.sdb
DROP DATABASE IF EXISTS dbClient;

CREATE DATABASE dbClient;

-- Table: clientes
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id            INTEGER       PRIMARY KEY AUTOINCREMENT,
    name          VARCHAR (200) NOT NULL,
    address       VARCHAR (200),
    number        VARCHAR (50),
    district      VARCHAR (100),
    city          VARCHAR (150),
    state         CHAR (2),
    zip           CHAR (8),
    country       VARCHAR (100),
    phone         VARCHAR (20),
    type          CHAR (1)      NOT NULL
                                DEFAULT F,
    cpf_cnpj      VARCHAR (20)  NOT NULL,
    rg_ie         VARCHAR (20),
    data_cadastro DATE,
    ativo         BOOLEAN       DEFAULT (true) 
);

INSERT INTO clientes (id, name, address, number, district, city, state, zip, country, phone, type, cpf_cnpj, rg_ie, data_cadastro, ativo) VALUES (1, 'Marcos Valverde de Oliveira', 'Rua Dantas Barreto', '241', 'Vila Eduardo', 'Petrolina', 'PE', '56328120', 'Brasil', '87988210009', 'F', '40267172400', '3734324', '2022-04-06', 'true');
INSERT INTO clientes (id, name, address, number, district, city, state, zip, country, phone, type, cpf_cnpj, rg_ie, data_cadastro, ativo) VALUES (2, 'Gustavo Valverde Goes', 'Rua Rio Surubim', '240', 'José e Maria', 'Petrolina', 'PE', '56320120', 'Brasil', '87988271731', 'F', '66863337002', '3423423', '2022-04-07', 0);
INSERT INTO clientes (id, name, address, number, district, city, state, zip, country, phone, type, cpf_cnpj, rg_ie, data_cadastro, ativo) VALUES (3, 'Cia Textil do Vale Ltda', 'Rua Tanzânia', '100', 'Topázio', 'Petrolina', 'PE', '56325100', 'Brasil', '87933219123', 'J', '40903254000134', '123453533', '2022-04-07', 1);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
