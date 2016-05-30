DROP TABLE Evento;
DROP TABLE C_Adm;
DROP TABLE C_EaD;
DROP TABLE C_Pres;
DROP TABLE Calendario;

CREATE DATABASE "Digra"
	WITH OWNER = postgres
		ENCODING = 'UTF8'	
   		TABLESPACE = pg_default
   		LC_COLLATE = 'Portuguese_Brazil.1252'
   		LC_CTYPE = 'Portuguese_Brazil.1252'
   		CONNECTION LIMIT = -1;

-- superclasse de calendários
CREATE TABLE Calendario {
	data_inicio 	DATE NOT NULL,
	data_fim 		DATE,
	dias_letivos 	INTEGER NOT NULL,
	aprovado 		BOOLEAN DEFAULT FALSE,
	reuniao_pauta 	CHAR[100],
	reuniao_data	DATE,
	reuniao_numero	INTEGER,
	data_anterior	DATE,

	CONSTRAINT Calendario_pk PRIMARY KEY (data_inicio)
};

-- subclasse de calendários presenciais
CREATE TABLE C_Pres {
	data_inicio		DATE NOT NULL,

	CONSTRAINT Pres_Calendario_fk FOREIGN KEY (data_inicio) REFERENCES Calendario(data_inicio)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT Pres_pk PRIMARY KEY (data_inicio)
};

-- subclasse de calendários EaD
CREATE TABLE C_EaD {
	data_inicio		DATE NOT NULL,

	CONSTRAINT EaD_Calendario_fk FOREIGN KEY (data_inicio) REFERENCES Calendario(data_inicio)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT EaD_pk PRIMARY KEY (data_inicio)
};

-- subclasse de calendários administrativos
CREATE TABLE C_Adm {
	data_inicio		DATE NOT NULL,

	CONSTRAINT Adm_Calendario_fk FOREIGN KEY (data_inicio) REFERENCES Calendario(data_inicio)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT Adm_pk PRIMARY KEY (data_inicio)
};

-- eventos -> dependem de calendário
CREATE TABLE Evento {
	id_evento		SERIAL NOT NULL UNIQUE,
	data_inicio		DATE NOT NULL,
	data_fim		DATE,
	descricao		VARCHAR(90),
	data_calendario	DATE NOT NULL,

	CONSTRAINT Evento_Calendario_fk FOREIGN KEY (data_calendario) REFERENCES Calendario(data_inicio)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT Evento_pk PRIMARY KEY (data_calendario, id_evento)
};

-- define o auto-relacionamento entre Calendário "anterior" e Calendário "posterior"
ALTER TABLE Calendario ADD FOREIGN KEY (data_anterior) REFERENCES Calendario(data_inicio);

-- trigger para calcular data_fim
CREATE TRIGGER calcula_data_fim 
	BEFORE INSERT 
	ON Calendario 
	FOR EACH ROW
BEGIN
	SET NEW.data_fim = NEW.data_inicio + INTERVAL '1' DAY * NEW.dias_letivos;
END


