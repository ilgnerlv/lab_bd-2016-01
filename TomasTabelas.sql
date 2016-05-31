CREATE TABLE Matriculado
(

grade Varchar2(100),
periodo INTEGER,
status Varchar2(20),
perfil INTEGER,
ano_ingresso INTEGER,
ano_termino INTEGER,

CONSTRAINT FK_Nome_Curso Foreign Key (Nome) REFERENCES curso (Nome),
CONSTRAINT FK_RA Foreign Key (RA) REFERENCES Estudante (RA),


)


CREATE TABLE Cursa
(
semestre INTEGER,
status Varchar2(20),
media Number,
frequencia Number,

CONSTRAINT FK_Id_Turma Foreign Key (Id_Turma) REFERENCES turma (Id_Turma),
CONSTRAINT FK_RA Foreign Key (RA) REFERENCES Estudante (RA),

)