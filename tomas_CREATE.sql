CREATE TABLE PossuiCCND
(
	conselho_id VARCHAR(10),
	nucleo_docente_codigo VARCHAR(10)

	CONSTRAINT possuiccnd_pk PRIMARY KEY (conselho_id, nucleo_docente_codigo)
	CONSTRAINT conselhoid_fk FOREIGN KEY (conselho_id)
		REFERENCES Conselho_curso (id_conselho) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT nucleodocentecodigo_fk FOREIGN KEY (nucleo_docente_codigo)
		REFERENCES Nucleo_Docente (Codigo_NDocente) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION

);