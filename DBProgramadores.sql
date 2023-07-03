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
	ID int identity(1,1) primary key, --si utilizamos el id como clave primaria permitira que se pueda hacer una modificacion en el codigo o nombre de entrada en caso de error
	Nombre_Entrada varchar(60) not null,
	Codigo varchar(40) unique not null,
	constraint ukprogramadores unique (Nombre_Entrada, Codigo)
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
	Num_Version varchar(20) not null,
	Fecha date,
	Fk_Nombre_Entrada varchar(60) not null,
	Fk_CodProgramador varchar(40) not null,
	foreign key (Fk_Nombre_Entrada, Fk_CodProgramador) references Programadores (Nombre_Entrada, Codigo),
	Fk_ID_Lenguaje int foreign key references LenguajesProgramacion(ID) not null,
	Consulta_DBMS bit
);
go

create table Llamadas(
	Fk_ID_Llama int foreign key references Programas(ID) not null,
	Fk_ID_EsLlamado int foreign key references Programas(ID) not null,
	constraint ukID unique (Fk_ID_Llama, Fk_ID_EsLlamado),
	ID int identity(1,1) primary key
);
go

create table Prog_Usu(
	ID_Programa int foreign key references Programas(ID) not null,
	ID_Usuario int foreign key references Usuarios(ID) not null,
	ID int identity(1,1) primary key
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
insert Programas values('ABMC Productos', '0.8.1', '2023-05-02', 'mtrescher', 'marce123', 3, 1);
insert Programas values('PartidoStats', '0.3', '2022-09-12', 'n1cond', 'nel123', 4, 1);
insert Programas values('DNSCheck', '1.0', '2023-01-15', 'Matias-S1lva', 'mati123', 5, 0);

insert Llamadas values (2, 1);
insert Llamadas values (3, 1);
insert Llamadas values (4, 4);

insert Prog_Usu values (2, 3);
insert Prog_Usu values (3, 2);
insert Prog_Usu values (4, 4);
insert Prog_Usu values (1, 1);

