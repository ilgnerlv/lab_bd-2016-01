--Database: "Prograd"
DROP TABLE Atividade
DROP TABLE Compoe

CREATE DATABASE "Prograd"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Portuguese_Brazil.1252'
       LC_CTYPE = 'Portuguese_Brazil.1252'
       CONNECTION LIMIT = -1;


 CREATE TABLE Atividade(
 	Data_Inicio date CONSTRAINT atividade_PK primary key,
 	Data_Fim date CONSTRAINT,
 	Atributo char(1) -- atributo descriminatório sobre tipo de atividade
 );

CREATE TABLE Compoe(
	Codigo_Disciplina CHAR(10),
	Codigo_Curso CHAR(10),
	Obrigatoriedade BOOLEAN,
	Perfil CHAR(1), -- atributo descriminatório sobre tipo de atividade
	FOREIGN KEY (Codigo_Disciplina) REFERENCES Disciplina (Codigo),
	FOREIGN KEY (Codigo_Curso) REFERENCES Curso (Codigo_Curso),
	CONSTRAINT compoe_PK PRIMARY KEY (Codigo_Disciplina, Codigo_Curso)
);

CREATE TABLE Efetua(
	-- Quais sao as PK?
);