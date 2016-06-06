-------------
-----edna----
-------------
create table pessoa
(
  rg varchar(9) not null,
  pre_nome varchar(20),
  meio_nome varchar(20),
  ultimo_nome varchar(20),
  email varchar(20),
  email_Institucional varchar(20),
  etnia varchar(15),
  sexo char,
  dataNascimento date,
  nome_mae varchar(20),
  nome_pai varchar(20),
  cidadeNata_nome varchar(20),
  cod_rec_curso varchar(10) ,
  pais_origem varchar(20),
  nacionalidade varchar(15),
     CONSTRAINT pessoa_pk PRIMARY KEY (rg),
 CONSTRAINT Reconhecimento_de_curso_tabela_pessoa_fk FOREIGN KEY (cod_rec_curso)
	REFERENCES public.reconhecimento_de_curso (cod_rec_curso) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION
     );


create table pessoa_endereco
(
     num_casa int not null,
     rg  varchar(9) not null,
     rua varchar(15),
     complemento varchar(15),
     bairro varchar(15),
     uf varchar(2),
     cep int, 
     CONSTRAINT pessoa_fk FOREIGN KEY (rg)
	REFERENCES public.pessoa (rg) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION,
        constraint  Pessoa_endereco_pk primary key (rg,num_casa,cep)
 
     );
create table pessoa_contato(
     ddd int not null, 
     numero int not null,
     tipo varchar(6) not null,
     ramal int not null,
     rg varchar(9) not null,
    
      CONSTRAINT pessoa_fk FOREIGN KEY (rg)
	REFERENCES public.pessoa (rg) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION,
 constraint  contato_pk primary key (rg,ddd,numero,ramal,tipo)
    ); 
	
-------------
----Ilgner---
-------------
--Rever a PK de Curso para verificar se os dados são correspondestes
CREATE TABLE Enade (
	
	Realizacao DATE not null CONSTRAINT Enade_PK primary key,
	RA int NOT NULL,
	Nota numeric,
	
	CONSTRAINT Enade_FK_Estudante  Foreign key (RA)        references Estudante (RA),
	CONSTRAINT Enade_FK_Curso      Foreign key (Cod_Curso) references Curso     (Cod_Curso)
);

-------------
--Luciano----
-------------
create table Conselho_Curso(  
	representante varchar(20),
	cod int not null,
	CONSTRAINT CLIENTE_PK PRIMARY KEY(cod) 

);

--rever os nomes das PK que foram instanciadas como Foreign Key
create table pertenceCP( categoria varchar2(20), 
	data date,
	rg int,
	cod int,
	CONSTRAINT Pertence_FK FOREIGN KEY(rg) REFERENCES Pessoa(rg),
	CONSTRAINT Pertence_FK FOREIGN KEY(cod) REFERENCES Conselho_curso(cod),
    CONSTRAINT pertence_PK PRIMARY KEY(rg, cod)
	
);


-------------------
----Guilhermer-----
-------------------


CREATE TABLE reconhecimento_de_curso(
cod_rec_curso varchar(10) PRIMARY KEY
);

CREATE TABLE visita(
data date NOT NULL,
cod_rec_curso varchar(10) REFERENCES reconhecimento_de_curso(cod_rec_curso),
comite_avaliador varchar(400),
itens varchar(400),
PRIMARY KEY(data, cod_rec_curso)
);

CREATE TABLE fase(
documentos varchar(400),
data date,
fase_id varchar(10) NOT NULL,
cod_rec_curso varchar(10) REFERENCES  reconhecimento_de_curso(cod_rec_curso),
PRIMARY KEY(fase_id)
);
