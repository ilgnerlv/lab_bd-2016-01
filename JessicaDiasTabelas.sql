CREATE TABLE public.campus
(
  campus_nome character varying(100),
  campus_website character varying(50),
  campus_sigla character varying(50) NOT NULL,
  CONSTRAINT campus_pk PRIMARY KEY (campus_sigla)
)

CREATE TABLE public.centro
(
  centro_nome character varying(100),
  centro_website character varying(50),
  centro_geo point,
  centro_sigla character varying(50) NOT NULL,
  CONSTRAINT centro_pk PRIMARY KEY (centro_sigla)
)

CREATE TABLE public.departamento
(
  dep_nome character varying(100),
  dep_website character varying(50),
  dep_sigla character varying(50) NOT NULL,
  campus_sigla character varying(50),
  CONSTRAINT departamento_pk PRIMARY KEY (dep_sigla),
  CONSTRAINT depcampus_fk FOREIGN KEY (campus_sigla)
	REFERENCES public.campus (campus_sigla) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION
)

-- Atividade complementar
CREATE TABLE public.atcomp
(
  at_creditos integer,
  at_nome character varying(100) NOT NULL,
  CONSTRAINT atcomp_pk PRIMARY KEY (at_nome)
)

-- Relacionamento Realiza (Atividade_Complementar x Estudante)
CREATE TABLE public.realizaace
(
  ra integer,
  nome character varying(100),
  at_nome character varying(100),
  --Inserir var do estudante

  CONSTRAINT realizaace_pk PRIMARY KEY (RA_estudante, at_nome),
  CONSTRAINT raestudante_fk FOREIGN KEY (RA_estudante)
      REFERENCES public.estudante (RA_estudante) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT atnome_fk FOREIGN KEY (at_nome)
      REFERENCES public.atcomp (at_nome) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)

-- Atributo multivalorado Endereco
CREATE TABLE public.endereco
(
  end_tipo character varying(10),
  end_rua character varying(50),
  end_num integer,
  end_complemento character varying(50),
  end_bairro character varying(50),
  end_cidade character varying(50),
  end_uf character varying(2),
  end_pais character varying(50),
  end_cep character varying(50),
  dep_sigla character varying(50) NOT NULL,
  campus_sigla character varying(50) NOT NULL,
  CONSTRAINT endereco_pk PRIMARY KEY (campus_sigla, dep_sigla),
  CONSTRAINT endcampus_fk FOREIGN KEY (campus_sigla)
      REFERENCES public.campus (campus_sigla) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT enddep_fk FOREIGN KEY (dep_sigla)
      REFERENCES public.departamento (dep_sigla) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)

-- Atributo multivalorado Telefone
CREATE TABLE public.telefone
(
  tel_num integer,
  tel_tipo character varying(10),
  tel_ramal integer,
  tel_origem character varying(10),  --Cidade de origem, cidade atual...
  tel_ddd integer,
  dep_sigla character varying(50) NOT NULL,
  campus_sigla character varying(50) NOT NULL,
  CONSTRAINT telefone_pk PRIMARY KEY (campus_sigla, dep_sigla),
  CONSTRAINT telcampus_fk FOREIGN KEY (campus_sigla)
      REFERENCES public.campus (campus_sigla) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT teldep_fk FOREIGN KEY (dep_sigla)
      REFERENCES public.departamento (dep_sigla) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
