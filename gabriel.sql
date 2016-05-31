DROP TABLE PertenceDD;
DROP TABLE Turma;
DROP TABLE Sala;

CREATE TABLE PertenceDD(
	nome_departamento character varying(100),
	codigo_disciplina CHAR(10),
	CONSTRAINT pertencedd_nome_departamento foreign key (nome_departamento) references Departamento(dep_nome),
	CONSTRAINT pertencedd_codigo_disciplina foreign key (codigo_disciplina) references Disciplina(Codigo),
	CONSTRAINT pertencedd_pk PRIMARY KEY (nome_departamento,codigo_disciplina_disciplina)
 );
 
 CREATE TABLE Turma(
 	id_turma CHAR(1),
 	vagas int,
 	codigo_disciplina CHAR(10),
 	codigo_docente CHAR(10),
 	CONSTRAINT turma_codigo_disciplina foreign key (codigo_disciplina) references Disciplina(Codigo),
 	CONSTRAINT turma_codigo_docente foreign key (codigo_docente) references Docente(Codigo),
 	CONSTRAINT turma_pk primary key (codigo_disciplina, id_turma)
 );

 CREATE TABLE Sala(
 	id_turma CHAR(1),
 	codigo_disciplina CHAR(10),
 	sala char(20),
 	CONSTRAINT sala_turma_fk foreign key (id_turma, codigo_disciplina) references Turma(id_turma, codigo_disciplina),
 	CONSTRAINT sala_pk PRIMARY KEY (id_turma, codigo_disciplina, sala)
 );

INSERT INTO PertenceDD VALUES(
	,--nome_departamento
	'08806'
);

INSERT INTO PertenceDD VALUES(
	,--nome_departamento
	'562312'
);

INSERT INTO Turma VALUES(
	'A',
	30,
	,--cod_disciplina
	--cod_docente
);

INSERT INTO Turma VALUES(
	'B',
	25,
	,--cod_disciplina
	--cod_docente
);

INSERT INTO Turma VALUES(
	'A',
	60,
	,--cod_disciplina
	--cod_docente
);

INSERT INTO Sala VALUES(
	'A',
	,--cod_disciplina
	'AT9-129'
);

INSERT INTO Sala VALUES(
	'B',
	,--cod_disciplina
	'AT5-100'
);

INSERT INTO Sala VALUES(
	'A',
	,--cod_disciplina
	'AT9-131'
);