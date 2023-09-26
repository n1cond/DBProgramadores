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
	ID int identity (1,1) primary key,
	Nombre_Entrada varchar(60) unique not null,
	Codigo varchar(40) not null
);
go

create table LenguajesProgramacion(
	ID int identity(1,1) primary key,
	Nombre varchar(60) unique not null
);
go

create table Usuarios(
	ID int identity(1,1) primary key,
	Nombre_Entrada varchar(60) unique not null
);
go

create table Programas(
	ID int identity(1,1) primary key,
	Descripcion varchar(60) not null,
	Num_Version varchar(20) not null,
	Fecha date not null,
	Fk_ID_Programador int foreign key references Programadores(ID) not null,
	Fk_ID_Lenguaje int foreign key references LenguajesProgramacion(ID) not null,
	Consulta_DBMS bit
);
go

create table Llamadas(
	Fk_ID_Llama int foreign key references Programas(ID) not null,
	Fk_ID_EsLlamado int foreign key references Programas(ID) not null,
	primary key (Fk_ID_Llama, Fk_ID_EsLlamado)
);
go

create table Prog_Usu(
	ID_Programa int foreign key references Programas(ID) not null,
	ID_Usuario int foreign key references Usuarios(ID) not null,
	primary key (ID_Programa, ID_Usuario)
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

--1 listar todos los programas
select p.Num_Version, p.Descripcion, p.Fecha, l.Nombre as Lenguaje
from Programas p 
inner join LenguajesProgramacion l ON p.Fk_ID_Lenguaje = l.ID


select Programas.Num_Version, Programas.Descripcion, Programas.Fecha, LenguajesProgramacion.Nombre
from Programas 
join LenguajesProgramacion  ON Programas.Fk_ID_Lenguaje = LenguajesProgramacion.ID


--2 Listar todos los programas escritos entre el 1/1/22 hasta el 31/12/23.
select * from Programas
where fecha between '2022-01-01' and '2023-12-31'

--3 Listar todos los programas escritos en el lenguaje de programación de código=1.
select * from Programas
where Fk_ID_Lenguaje = 1

--4 Listar todos los programas escritos en javascript
select p.Num_Version, l.Nombre as Lenguaje from Programas p 
inner join LenguajesProgramacion l on p.Fk_ID_Lenguaje = l.ID
where l.Nombre = 'javascript'

--5 Indicar la cantidad de programas escritos en Javascript:
select l.nombre, count(*) total from Programas p 
inner join LenguajesProgramacion l on p.Fk_ID_Lenguaje = l.ID
where l.Nombre = 'javascript'
group by l.Nombre


--6 Indicar la cantidad de programas escritos en cada lenguaje
select l.nombre, count(*) total from Programas p 
inner join LenguajesProgramacion l on p.Fk_ID_Lenguaje = l.ID
group by l.Nombre


--7 Indicar la cantidad de programas escritos en cada lenguaje y que hayan sido escritos entre 01/01/2022 y 31/12/2022
select l.nombre, fecha, count(*) total from Programas p
inner join LenguajesProgramacion l on p.Fk_ID_Lenguaje = l.ID
where p.fecha between '2022-01-01' and '2023-12-31'
group by l.Nombre, fecha

--8 Indicar la cantidad de programas, agrupados por programa que no están escritos en PASCAL.
select l.nombre, count(*) total from Programas p
inner join LenguajesProgramacion l on p.Fk_ID_Lenguaje = l.ID
where l.Nombre <> 'Python'-- l.nombre not in ('pascal'), l.nombre not like '%pascal%'
group by l.Nombre

select * from Programas

--9 Listar la cantidad de programas escritos por cada programador en forma ascendente por nombre
select Nombre_Entrada, count(*) from Programas p 
inner join Programadores pr on p.Fk_CodProgramador = pr.Codigo and p.Fk_Nombre_Entrada = pr.Nombre_Entrada
group by Nombre_Entrada
order by Nombre_Entrada asc

--10 Listar la cantidad de programas escritos por cada programador en forma ascendente por nombre durante el 2022
select Nombre_Entrada, p.fecha, count(*) from Programas p 
inner join Programadores pr on p.Fk_CodProgramador = pr.Codigo and p.Fk_Nombre_Entrada = pr.Nombre_Entrada
where year(p.fecha)= 2022
group by Nombre_Entrada, p.fecha
order by Nombre_Entrada asc

--11 Cantidad de programas utilizados por cada usuario agrupados por nombre de usuario
select u.Nombre_Entrada 'Nombre Usuario', count(*) as Programas from Prog_Usu pu
inner join Programas p on pu.ID_Programa = p.ID
inner join Usuarios u on pu.ID_Usuario = u.ID
where pu.ID_Usuario = u.ID
group by u.Nombre_Entrada

--12 Indicar todos los programas que utiliza un usuario determinado, por ejemplo, 2
select u.Nombre_Entrada 'Nombre Usuario', count(*) as Programas from Prog_Usu pu
inner join Programas p on pu.ID_Programa = p.ID
inner join Usuarios u on pu.ID_Usuario = u.ID
where pu.ID_Usuario = 2
group by u.Nombre_Entrada


--13 Indicar todos los programas con que interactúa un programa dado.
select pLlama.Descripcion Programa, pLlamado.Descripcion Llamadas from Llamadas l
inner join Programas pLlama on l.Fk_ID_Llama = pLlama.ID 
inner join Programas pLlamado on l.Fk_ID_EsLlamado = pLlamado.ID
where l.Fk_ID_Llama = pLlama.ID and l.Fk_ID_EsLlamado = pLlamado.ID
group by pLlama.Descripcion, pLlamado.Descripcion
