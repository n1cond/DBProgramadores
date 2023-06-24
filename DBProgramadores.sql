use master 
go
if Exists(select * from sys.sysdatabases where name='DBProgramadores')
drop database DBProgramadores
go
create Database DBProgramadores
go
use DBProgramadores
go

--creacion de tablas
create table Programadores(
	Nombre_Entrada varchar(60) unique not null, --probablemente esta debería ser la PK
	Codigo varchar(40) not null,
	primary key (Codigo, Nombre_Entrada)
);
go

create table LenguajesProgramacion(
	ID int identity(1,1) primary key,
	Nombre varchar(60)
);
go

create table Usuarios(
	ID int identity(1,1) primary key,
	Nombre_Entrada varchar(60),
);
go

create table Programas(
	ID int identity(1,1) primary key,
	Descripcion varchar(60),
	Num_Version varchar(20),
	Fecha date,
	Fk_Nombre_Entrada varchar(60) foreign key references Programadores(Nombre_Entrada) not null,
	Fk_CodProgramador varchar(40) foreign key references Programadores(Codigo) not null,
	Fk_ID_Lenguaje int foreign key references LenguajesProgramacion(ID) not null,
	Consulta_DBMS bit
);
go

create table Llamadas(
	Fk_ID_Llama int foreign key references Programas(ID) not null,
	Fk_ID_EsLlamado int foreign key references Programas(ID) not null,
	constraint ukID unique (Fk_ID_Llama, Fk_ID_EsLlamado)
);
go

create table Prog_Usu(
	ID_Programa int foreign key references Programas(ID) not null,
	ID_Usuario int foreign key references Usuarios(ID) not null
);
go

insert Programadores values('DanielaBallon', 'dani123');
insert Programadores values('mtrescher', 'marce123');
insert Programadores values('n1cond', 'nel123');
insert Programadores values('Matias-S1lva', 'mati123');

insert LenguajesProgramacion values('Javascript');
insert LenguajesProgramacion values('Java');
insert LenguajesProgramacion values('C#');
insert LenguajesProgramacion values('Python');
insert LenguajesProgramacion values('Ruby');

insert Usuarios values('carlos');
insert Usuarios values('juana');
insert Usuarios values('eduardo');
insert Usuarios values('flor');

insert Programas values('QuickSort', '1.0', '2023-04-20', 'DanielaBallon', 'dani123', 1, 0);
insert Programas values('ABMC Productos', '0.8.1', '2023-05-02', 'mtrescher', 'marce', 3, 1);
insert Programas values('PartidoStats', '0.3', '2022-09-12', 'n1cond', 'nel123', 4, 1);
insert Programas values('DNSCheck', '1.0', '2023-01-15', 'Matias-S1lva', 'mati123', 5, 0);

insert Llamadas values (2, 1);
insert Llamadas values (3, 1);
insert Llamadas values (4, 4);

insert Prog_Usu values (2, 3);
insert Prog_Usu values (3, 2);
insert Prog_Usu values (4, 4);
insert Prog_Usu values (1, 1);