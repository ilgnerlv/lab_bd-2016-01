--Database: "Prograd"
DROP TABLE Endereco
DROP TABLE Telefone
DROP TABLE RealizaACE
DROP TABLE AtComp
DROP TABLE Departamento
DROP TABLE Centro
DROP TABLE Campus

CREATE DATABASE "Prograd"
	WITH OWNER = postgres
		ENCODING = 'UTF8'	
   		TABLESPACE = pg_default
   		LC_COLLATE = 'Portuguese_Brazil.1252'
   		LC_CTYPE = 'Portuguese_Brazil.1252'
   		CONNECTION LIMIT = -1;

-- Campus
CREATE TABLE Campus (
	campus_nome 	CHAR(100),
	campus_website 	CHAR(50),
	campus_sigla 	CHAR(50) NOT NULL,

	CONSTRAINT campus_pk PRIMARY KEY (campus_sigla)
);

-- Centro
CREATE TABLE Centro (
	centro_nome 	CHAR(100),
	centro_website 	CHAR(50),
	centro_geo	POINT,
	centro_sigla 	CHAR(50) NOT NULL,

	CONSTRAINT campus_pk PRIMARY KEY (centro_sigla)
);

-- Departamento
CREATE TABLE Departamento (
	dep_nome 	CHAR(100),
	dep_website 	CHAR(50),
	dep_sigla 	CHAR(50) NOT NULL,

	CONSTRAINT departamento_pk PRIMARY KEY (dep_sigla)
);

-- Atividade Complementar
CREATE TABLE AtComp (
	at_creditos 	INTEGER,
	at_nome 	CHAR(100) NOT NULL,

	CONSTRAINT departamento_pk PRIMARY KEY (at_nome)
);

-- Realiza (Atividade_Complementar x Estudante)
CREATE TABLE RealizaACE (
	RA 	INTEGER,
	Nome	CHARACTER VARYING(100),

	CONSTRAINT aceRA_pk FOREIGN KEY (RA_estudante) REFERENCES Estudante(RA),
	CONSTRAINT aceNome_pk FOREIGN KEY (nome_estudante) REFERENCES Estudante(Nome)
	
);

-- Atributo multivalorado Telefone
CREATE TABLE Telefone (
	tel_num	INTEGER,
    	tel_tipo    CHAR(10),
    	tel_ramal   INTEGER,
    	tel_origem  CHAR(10), --Cidade de origem, cidade atual...
    	tel_DDD     INTEGER,
	dep_sigla 	CHAR(50),
	campus_sigla 	CHAR(50),

	CONSTRAINT telcampus_pk FOREIGN KEY (campus_sigla) REFERENCES Campus(campus_sigla),
	CONSTRAINT teldep_pk FOREIGN KEY (dep_sigla) REFERENCES Departamento(dep_sigla)

);

-- Atributo multivalorado Endereco
CREATE TABLE Endereco (
    	end_tipo	CHAR(10),
    	end_rua		CHARACTER VARYING(50),
	end_num		INTEGER,
    	end_complemento	CHARACTER VARYING(50),
    	end_bairro	CHARACTER VARYING(50),
    	end_cidade	CHARACTER VARYING(50),
    	end_uf		CHAR(2),
    	end_pais	CHARACTER VARYING(50),
    	end_cep		CHARACTER VARYING(50),

	CONSTRAINT endcampus_pk FOREIGN KEY (campus_sigla) REFERENCES Campus(campus_sigla),
	CONSTRAINT enddep_pk FOREIGN KEY (dep_sigla) REFERENCES Departamento(dep_sigla)

);