--Database: "Prograd"
DROP PROCEDURE calcula_data_fim_proc();

DROP TABLE Evento;
DROP TABLE C_Adm;
DROP TABLE C_EaD;
DROP TABLE C_Pres;
DROP TABLE Calendario;

--CREATE DATABASE "Prograd"
--	WITH OWNER = postgres
--		ENCODING = 'UTF8'	
--   		TABLESPACE = pg_default
--   		LC_COLLATE = 'Portuguese_Brazil.1252'
--   		LC_CTYPE = 'Portuguese_Brazil.1252'
--   		CONNECTION LIMIT = -1;

-- reunião
CREATE TABLE Reuniao (
	numero INTEGER NOT NULL UNIQUE,
	pauta VARCHAR[100],
	data_inicio DATE,

	CONSTRAINT Reuniao_pk PRIMARY KEY (numero)
);

-- calendários
CREATE TABLE Calendario (
	data_inicio DATE NOT NULL,
	data_fim DATE,
	dias_letivos INTEGER NOT NULL,
	tipo CHAR NOT NULL, -- atributo discriminatório Graduação Presencial (p), EaD (e) ou Administrativo (a)
	aprovado BOOLEAN DEFAULT FALSE,
	reuniao_numero INTEGER,
	anterior_data DATE,	-- data de início do calendário anterior ao referente
	anterior_tipo CHAR, -- tipo do calendário anterior ao referente

	CONSTRAINT Calendario_Reuniao_fk FOREIGN KEY (reuniao_numero) REFERENCES Reuniao(numero)
		ON DELETE RESTRICT,
	CONSTRAINT Calendario_pk PRIMARY KEY (data_inicio, tipo)
);

-- eventos -> dependem de calendário
CREATE TABLE Evento (
	id_evento SERIAL NOT NULL UNIQUE,
	data_inicio DATE NOT NULL,
	data_fim DATE,
	descricao TEXT,
	calendario_data DATE NOT NULL, -- data de início do calendario ao qual o evento pertence
	calendario_tipo CHAR NOT NULL, -- tipo do calendario ao qual o eento pertence

	CONSTRAINT Evento_Calendario_fk FOREIGN KEY (calendario_data, calendario_tipo) REFERENCES Calendario(data_inicio, tipo)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT Evento_pk PRIMARY KEY (calendario_data, calendario_tipo, id_evento)
);

-- define o auto-relacionamento entre Calendário "anterior" e Calendário "posterior"
ALTER TABLE Calendario ADD FOREIGN KEY (anterior_data, anterior_tipo) REFERENCES Calendario(data_inicio, tipo);

-- trigger para calcular data_fim
CREATE FUNCTION calcula_data_fim_proc() RETURNS trigger AS '
BEGIN 
	NEW.data_fim = NEW.data_inicio + INTERVAL ''1'' DAY * NEW.dias_letivos;
	RETURN NEW;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER calcula_data_fim_trigger BEFORE INSERT OR UPDATE
	ON Calendario FOR EACH ROW
	EXECUTE PROCEDURE calcula_data_fim_proc ();