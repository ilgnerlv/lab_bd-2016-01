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

CREATE TABLE Calendario {
	data_inicio 	DATE NOT NULL,
	data_fim 		DATE,
	dias_letivos 	INTEGER NOT NULL,
	aprovado 		BOOLEAN NOT NULL DEFAULT FALSE,
	reuniao_pauta 	CHAR[100],
	reuniao_data	DATE,
	reuniao_numero	INTEGER,
	data_anterior	DATE,
	CONSTRAINT Calendario_pk PRIMARY KEY (data_inicio)
};

CREATE TABLE C_Pres {
	data_inicio		DATE,
	CONSTRAINT Pres_Calendario_fk FOREIGN KEY (data_inicio) REFERENCES Calendario(data_inicio),
	CONSTRAINT Pres_pk PRIMARY KEY (data_inicio)
};

CREATE TABLE C_EaD {
	data_inicio		DATE,
	CONSTRAINT EaD_Calendario_fk FOREIGN KEY (data_inicio) REFERENCES Calendario(data_inicio),
	CONSTRAINT EaD_pk PRIMARY KEY (data_inicio)
};

CREATE TABLE C_Adm {
	data_inicio		DATE,
	CONSTRAINT Adm_Calendario_fk FOREIGN KEY (data_inicio) REFERENCES Calendario(data_inicio),
	CONSTRAINT Adm_pk PRIMARY KEY (data_inicio)
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


