----------------------------------------------MODELO BI----------------------------------------------------
use GD1C2022
go

begin transaction

create table [CEBOLLITA_SUB_CAMPEON].[BI_Escuderia](
escuderia_nombre nvarchar(255) Primary Key,
escuderia_nacionalidad nvarchar(255)
) ON [PRIMARY] 
go

create table [CEBOLLITA_SUB_CAMPEON].[BI_Piloto](
piloto_nombre nvarchar(255),
piloto_apellido nvarchar(255),
piloto_nacionalidad nvarchar(255),
piloto_fecha_nac Date,
constraint [PKBIPILOTO] Primary key (
[piloto_nombre],
[piloto_apellido]
)
) ON [PRIMARY] 
go

create table [CEBOLLITA_SUB_CAMPEON].[BI_Auto](
auto_modelo nvarchar(255),
auto_numero int,
constraint [PKBIAUTO] Primary key (
[auto_modelo],
[auto_numero]
)
)on [PRIMARY]
go

create table [CEBOLLITA_SUB_CAMPEON].[BI_Tipo_Neumatico](
id_tipo_neumatico int Primary Key,
detalle nvarchar(255)
) on [Primary]
go

create Table [CEBOLLITA_SUB_CAMPEON].[BI_Circuito](
circuito_codigo int Primary key,
circuito_pais nvarchar(255),
circuito_nombre nvarchar(255)
) on [Primary]
go

create Table [CEBOLLITA_SUB_CAMPEON].[BI_Tiempo](
año int,
cuatrimestre int
constraint [PKTIEMPO] primary key (
[año],
[cuatrimestre]
)
) on [PRIMARY]
go

create table [CEBOLLITA_SUB_CAMPEON].[BI_Incidente_Tipo](
id_tipo int Primary Key,
tipo nvarchar(255)
)on [Primary]
go

create table [CEBOLLITA_SUB_CAMPEON].[BI_Tipo_Sector](
sector_tipo nvarchar(255) primary key,
)on [PRIMARY]
GO

create table [CEBOLLITA_SUB_CAMPEON].[BI_Sector](
sector int primary key,
)on [PRIMARY]
GO

create table [CEBOLLITA_SUB_CAMPEON].[BI_Vuelta](
vuelta int primary key,
)on [PRIMARY]
GO

CREATE procedure [CEBOLLITA_SUB_CAMPEON].[Cargar_incidentes_tipo_BI]
as
begin transaction
insert into [CEBOLLITA_SUB_CAMPEON].[BI_Incidente_Tipo](
	tipo,
	id_tipo
	
)select
tipo,
id_tipo
from [CEBOLLITA_SUB_CAMPEON].[Incidente_Tipo]
commit
go

exec [CEBOLLITA_SUB_CAMPEON].[Cargar_incidentes_tipo_BI]
go


create procedure [CEBOLLITA_SUB_CAMPEON].[Cargar_Autos_BI]
as
begin transaction
insert into [CEBOLLITA_SUB_CAMPEON].[BI_Auto](
auto_modelo,
auto_numero
)select
auto_modelo,
auto_numero
from [CEBOLLITA_SUB_CAMPEON].[Auto]
commit
go

exec CEBOLLITA_SUB_CAMPEON.Cargar_Autos_BI
go

create procedure [CEBOLLITA_SUB_CAMPEON].[Cargar_sector_tipo_BI]
as 
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.BI_Tipo_Sector(
sector_tipo
)select distinct 
sector_tipo 
from CEBOLLITA_SUB_CAMPEON.Sector
commit
go

exec CEBOLLITA_SUB_CAMPEON.Cargar_sector_tipo_BI
go


create procedure [CEBOLLITA_SUB_CAMPEON].[Cargar_Tiempo_BI]
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.BI_Tiempo(
	año,
	cuatrimestre
) select 
	Year(carrera_fecha),
	DatePart(quarter,carrera_fecha)
from CEBOLLITA_SUB_CAMPEON.Carrera
group by
	Year(carrera_fecha),
	DatePart(quarter,carrera_fecha)
commit
go

exec CEBOLLITA_SUB_CAMPEON.Cargar_Tiempo_BI
go

create procedure [CEBOLLITA_SUB_CAMPEON].[Cargar_circuitos_BI]
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.BI_Circuito(
circuito_codigo,
circuito_nombre,
circuito_pais
) select
	circuito_codigo,
	circuito_nombre,
	circuito_pais
from CEBOLLITA_SUB_CAMPEON.Circuito
commit
go

exec CEBOLLITA_SUB_CAMPEON.Cargar_circuitos_BI
go

create procedure [CEBOLLITA_SUB_CAMPEON].[Cargar_Piloto_BI]
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.BI_Piloto(
	piloto_nombre,
	piloto_fecha_nac,
	piloto_nacionalidad,
	piloto_apellido
)select
	piloto_nombre,
	piloto_fecha_nac,
	piloto_nacionalidad,
	piloto_apellido
from CEBOLLITA_SUB_CAMPEON.Piloto
commit
go

exec CEBOLLITA_SUB_CAMPEON.Cargar_Piloto_BI
go


create procedure [CEBOLLITA_SUB_CAMPEON].[Cargar_escuderia_BI]
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.BI_Escuderia(
	escuderia_nacionalidad,
	escuderia_nombre
)select
	escuderia_nacionalidad,
	escuderia_nombre
from CEBOLLITA_SUB_CAMPEON.Escuderia
commit
go

exec CEBOLLITA_SUB_CAMPEON.Cargar_escuderia_BI
go

create procedure [CEBOLLITA_SUB_CAMPEON].[Cargar_tipo_neumatico_BI]
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.BI_Tipo_Neumatico(
	id_tipo_neumatico,
	detalle
)select	
	id_tipo_neumatico,
	detalle
from CEBOLLITA_SUB_CAMPEON.Tipo_Neumatico
commit
go


exec CEBOLLITA_SUB_CAMPEON.Cargar_tipo_neumatico_BI
go

CREATE PROCEDURE CEBOLLITA_SUB_CAMPEON.Cargar_Sector_BI
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.BI_Sector(
sector
)select distinct
s.codigo_sector
from CEBOLLITA_SUB_CAMPEON.Sector s
commit
go

exec CEBOLLITA_SUB_CAMPEON.Cargar_Sector_BI
go

CREATE PROCEDURE CEBOLLITA_SUB_CAMPEON.Cargar_vueltas_BI
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.BI_Vuelta(
vuelta
) select distinct med_nro_vuelta
from CEBOLLITA_SUB_CAMPEON.Medicion
commit
go

exec CEBOLLITA_SUB_CAMPEON.Cargar_vueltas_BI
go

CREATE TABLE CEBOLLITA_SUB_CAMPEON.BI_Medicion (
	dim_auto_modelo nvarchar(255) ,
	dim_auto_nro int,
	dim_tipo_sector nvarchar(255) FOREIGN KEY REFERENCES CEBOLLITA_SUB_CAMPEON.BI_Tipo_Sector,
	dim_sector int FOREIGN KEY REFERENCES CEBOLLITA_SUB_CAMPEON.BI_Sector,
	dim_escuderia nvarchar(255) FOREIGN KEY REFERENCES CEBOLLITA_SUB_CAMPEON.BI_Escuderia,
	dim_circuito int FOREIGN KEY REFERENCES CEBOLLITA_SUB_CAMPEON.BI_Circuito,
	dim_anio int,
	dim_cuatri int,
	dim_tipo_neumatico int FOREIGN KEY REFERENCES CEBOLLITA_SUB_CAMPEON.BI_Tipo_Neumatico,
	dim_piloto_nombre nvarchar(255),
	dim_piloto_apellido nvarchar(255),
	velocidad decimal(18,2),
	combustible decimal(18,2),
	tiempo_vuelta decimal(18,10),
	dim_vuelta int FOREIGN KEY REFERENCES CEBOLLITA_SUB_CAMPEON.BI_Vuelta,
	Potencia_motor decimal(18,6),
	Desgaste_caja decimal(18,2),
	desgaste_frenos decimal(18,2),
	desgaste_neumaticos decimal(18,6),
	PRIMARY KEY(dim_auto_modelo,dim_auto_nro,dim_tipo_sector,dim_escuderia,dim_anio,dim_cuatri,dim_piloto_nombre,dim_piloto_apellido, dim_vuelta,dim_tipo_neumatico,dim_sector),
	foreign key(dim_anio,dim_cuatri) references CEBOLLITA_SUB_CAMPEON.BI_Tiempo(año, cuatrimestre),
	foreign key(dim_auto_modelo,dim_auto_nro) references CEBOLLITA_SUB_CAMPEON.BI_Auto(auto_modelo,auto_numero),
	foreign key(dim_piloto_nombre,dim_piloto_apellido) references CEBOLLITA_SUB_CAMPEON.BI_Piloto(piloto_nombre,piloto_apellido)
) on [PRIMARY]
go

CREATE FUNCTION CEBOLLITA_SUB_CAMPEON.desgaste_neumaticos(@vuelta int, @carrera int, @automodelo nvarchar(255), @autonumero int, @sector int)
returns  decimal(18,6)
as
begin
	return ((select top 1 sum(n.neumatico_profundidad) from CEBOLLITA_SUB_CAMPEON.Medicion m1 
			join CEBOLLITA_SUB_CAMPEON.Medicion_Neumatico n on m1.codigo_medicion=n.id_medicion 
			where m1.med_nro_vuelta=@vuelta and m1.id_carrera=@carrera and m1.auto_modelo=@automodelo and m1.auto_numero=@autonumero and m1.codigo_sector=@sector
			group by m1.med_tiempo_vuelta
			order by m1.med_tiempo_vuelta asc)-(select top 1 sum(n.neumatico_profundidad) from CEBOLLITA_SUB_CAMPEON.Medicion m1 
			join CEBOLLITA_SUB_CAMPEON.Medicion_Neumatico n on m1.codigo_medicion=n.id_medicion 
			where m1.med_nro_vuelta=@vuelta and m1.id_carrera=@carrera and m1.auto_modelo=@automodelo and m1.auto_numero=@autonumero and m1.codigo_sector=@sector
			group by m1.med_tiempo_vuelta
			order by m1.med_tiempo_vuelta desc))/4
end
go


CREATE FUNCTION CEBOLLITA_SUB_CAMPEON.desgaste_frenos(@vuelta int, @carrera int, @automodelo nvarchar(255), @autonumero int, @sector int)
returns  decimal(18,2)
as
begin
	return ((select top 1 sum(f.freno_grosor_pastilla) from CEBOLLITA_SUB_CAMPEON.Medicion m1 
			join CEBOLLITA_SUB_CAMPEON.Medicion_Freno f on m.codigo_medicion=f.id_medicion 
			where m1.med_nro_vuelta=@vuelta and m1.id_carrera=@carrera and m1.auto_modelo=@automodelo and m1.auto_numero=@autonumero and m1.codigo_sector=@sector
			group by m1.med_tiempo_vuelta 
			order by m1.med_tiempo_vuelta asc)-(select top 1 sum(f.freno_grosor_pastilla) from CEBOLLITA_SUB_CAMPEON.Medicion m1
			join CEBOLLITA_SUB_CAMPEON.Medicion_Freno f on m1.codigo_medicion=f.id_medicion 
			where m1.med_nro_vuelta=@vuelta and m1.id_carrera=@carrera and m1.auto_modelo=@automodelo and m1.auto_numero=@autonumero and m1.codigo_sector=@sector
			group by m1.med_tiempo_vuelta 
			order by m1.med_tiempo_vuelta desc))/4
end
go

CREATE FUNCTION CEBOLLITA_SUB_CAMPEON.tiempo_Sector_por_auto_y_vuelta(@vuelta int, @carrera int, @automodelo nvarchar(255), @autonumero int,@sector int)
returns decimal(18,10)
as
begin
	return (SELECT max(med_tiempo_vuelta)
		FROM CEBOLLITA_SUB_CAMPEON.Medicion
		WHERE med_nro_vuelta = @vuelta AND id_carrera = @carrera AND auto_numero= @autonumero and auto_modelo=@automodelo and codigo_sector=@sector)
		-
		(SELECT min(med_tiempo_vuelta)
		FROM CEBOLLITA_SUB_CAMPEON.Medicion
		WHERE med_nro_vuelta = @vuelta AND id_carrera = @carrera AND auto_numero= @autonumero and auto_modelo=@automodelo and codigo_sector=@sector)
end
go

CREATE FUNCTION CEBOLLITA_SUB_CAMPEON.desgaste_Motor(@vuelta int, @carrera int, @automodelo nvarchar(255), @autonumero int, @sector int)
returns decimal(18,6)
as
begin
	return (select top 1 max(mo.motor_potencia)
			FROM CEBOLLITA_SUB_CAMPEON.Medicion 
			join CEBOLLITA_SUB_CAMPEON.Medicion_Motor mo on codigo_medicion=mo.id_medicion
			WHERE med_nro_vuelta = @vuelta AND id_carrera = @carrera AND auto_numero= @autonumero and auto_modelo=@automodelo and codigo_sector=@sector)
			-
			(select top 1 min(mo.motor_potencia)
			FROM CEBOLLITA_SUB_CAMPEON.Medicion 
			join CEBOLLITA_SUB_CAMPEON.Medicion_Motor mo on codigo_medicion=mo.id_medicion
			WHERE med_nro_vuelta = @vuelta AND id_carrera = @carrera AND auto_numero= @autonumero and auto_modelo=@automodelo and codigo_sector=@sector)
end
go


CREATE FUNCTION CEBOLLITA_SUB_CAMPEON.desgaste_Caja_Por_Vuelta(@vuelta int, @carrera int, @automodelo nvarchar(255), @autonumero int, @sector int)
returns decimal(18,2)
as
begin
	return (select top 1 max(mc.caja_desgaste)
			FROM CEBOLLITA_SUB_CAMPEON.Medicion 
			join CEBOLLITA_SUB_CAMPEON.Medicion_caja mc on codigo_medicion=mc.id_medicion
			WHERE med_nro_vuelta = @vuelta AND id_carrera = @carrera AND auto_numero= @autonumero and auto_modelo=@automodelo and codigo_sector=@sector)
			-
			(select top 1 min(mc.caja_desgaste)
			FROM CEBOLLITA_SUB_CAMPEON.Medicion 
			join CEBOLLITA_SUB_CAMPEON.Medicion_Caja mc on codigo_medicion=mc.id_medicion
			WHERE med_nro_vuelta = @vuelta AND id_carrera = @carrera AND auto_numero= @autonumero and auto_modelo=@automodelo and codigo_sector=@sector)
end
go


CREATE FUNCTION CEBOLLITA_SUB_CAMPEON.GASTO_COMBUSTIBLE_POR_VUELTA(@vuelta int, @carrera int, @automodelo nvarchar(255), @autonumero int, @sector int)
returns decimal(18,2)
as
begin

	return (SELECT max(med_combustible)
			FROM CEBOLLITA_SUB_CAMPEON.Medicion
			WHERE med_nro_vuelta = @vuelta AND id_carrera = @carrera AND auto_numero= @autonumero and auto_modelo=@automodelo and codigo_sector=@sector)
			-
			(SELECT min(med_combustible)
			FROM CEBOLLITA_SUB_CAMPEON.Medicion
			wHERE med_nro_vuelta = @vuelta AND id_carrera = @carrera AND auto_numero= @autonumero and auto_modelo=@automodelo and codigo_sector=@sector)
end
GO

CREATE FUNCTION CEBOLLITA_SUB_CAMPEON.MEJOR_VELOCIDAD_EN_SECTOR_EN_VUELTA(@vuelta int, @carrera int, @automodelo nvarchar(255), @autonumero int, @sector int)
returns decimal(18,2)
as
begin
		return (SELECT max(med_velocidad)
		FROM CEBOLLITA_SUB_CAMPEON.Medicion
		WHERE med_nro_vuelta = @vuelta AND id_carrera = @carrera AND auto_numero= @autonumero and auto_modelo=@automodelo and codigo_sector=@sector)
end
go


CREATE FUNCTION CEBOLLITA_SUB_CAMPEON.Obtener_Tipo_neumatico_BI(@vuelta int, @carrera int, @automodelo nvarchar(255), @autonumero int, @sector int)
returns int
as
begin
	return (select top 1 tn.id_tipo_neumatico from CEBOLLITA_SUB_CAMPEON.Medicion m2
	join CEBOLLITA_SUB_CAMPEON.Medicion_Neumatico mn on
		mn.id_medicion = m2.codigo_medicion
	join CEBOLLITA_SUB_CAMPEON.Neumatico n on
		n.neumatico_serie = mn.id_neumatico
	join CEBOLLITA_SUB_CAMPEON.BI_Tipo_Neumatico tn on
		n.neumatico_tipo = tn.id_tipo_neumatico
	where m2.auto_modelo = @automodelo and m2.auto_numero = @autonumero and m2.id_carrera = @carrera and m2.codigo_sector = @sector and m2.med_nro_vuelta = @vuelta)
end
go


create procedure CEBOLLITA_SUB_CAMPEON.Cargar_mediciones_BI
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.BI_Medicion(
	combustible,
	dim_vuelta,
	velocidad,
	tiempo_vuelta,
	dim_auto_modelo,
	dim_auto_nro,
	dim_circuito,
	dim_anio,
	dim_cuatri,
	dim_tipo_sector,
	dim_sector,
	dim_escuderia,
	dim_piloto_nombre,
	dim_piloto_apellido,
	Potencia_motor,
	Desgaste_caja,
	desgaste_frenos,
	desgaste_neumaticos,
	dim_tipo_neumatico
)
select 
(SELECT max(m1.med_combustible)
			FROM CEBOLLITA_SUB_CAMPEON.Medicion m1
			WHERE m1.med_nro_vuelta = m.med_nro_vuelta AND m1.id_carrera = m.id_carrera AND m1.auto_numero= m.auto_numero and m1.auto_modelo=m.auto_modelo and m1.codigo_sector=s.codigo_sector)
			-
			(SELECT min(m1.med_combustible)
			FROM CEBOLLITA_SUB_CAMPEON.Medicion m1
			wHERE m1.med_nro_vuelta = m.med_nro_vuelta AND m1.id_carrera = m.id_carrera AND m1.auto_numero= m.auto_numero and m1.auto_modelo=m.auto_modelo and m1.codigo_sector=s.codigo_sector),
m.med_nro_vuelta,
(SELECT max(med_velocidad)
		FROM CEBOLLITA_SUB_CAMPEON.Medicion
		WHERE med_nro_vuelta = m.med_nro_vuelta AND id_carrera = m.id_carrera AND auto_numero= m.auto_numero and auto_modelo=m.auto_modelo and codigo_sector=s.codigo_sector),
(SELECT max(med_tiempo_vuelta)
		FROM CEBOLLITA_SUB_CAMPEON.Medicion
		WHERE med_nro_vuelta = m.med_nro_vuelta AND id_carrera = m.id_carrera AND auto_numero= m.auto_numero and auto_modelo=m.auto_modelo and codigo_sector=s.codigo_sector)
		-
		(SELECT min(med_tiempo_vuelta)
		FROM CEBOLLITA_SUB_CAMPEON.Medicion
		WHERE med_nro_vuelta = m.med_nro_vuelta AND id_carrera = m.id_carrera AND auto_numero= m.auto_numero and auto_modelo=m.auto_modelo and codigo_sector=s.codigo_sector),
m.auto_modelo,
m.auto_numero,
m.id_carrera,
year(c.carrera_fecha),
DATEPART(QUARTER,c.carrera_fecha),
s.sector_tipo,
s.codigo_sector,
a.escuderia,
a.auto_piloto_nombre,
a.auto_piloto_apellido,
(select top 1 max(mo.motor_potencia)
			FROM CEBOLLITA_SUB_CAMPEON.Medicion m3 
			join CEBOLLITA_SUB_CAMPEON.Medicion_Motor mo on m3.codigo_medicion=mo.id_medicion
			WHERE m3.med_nro_vuelta = m.med_nro_vuelta AND m3.id_carrera = m.id_carrera AND m3.auto_numero= m.auto_numero and m3.auto_modelo=m.auto_modelo and m3.codigo_sector=s.codigo_sector)
			-
			(select top 1 min(mo.motor_potencia)
			FROM CEBOLLITA_SUB_CAMPEON.Medicion m3
			join CEBOLLITA_SUB_CAMPEON.Medicion_Motor mo on m3.codigo_medicion=mo.id_medicion
			WHERE m3.med_nro_vuelta = m.med_nro_vuelta AND m3.id_carrera = m.id_carrera AND m3.auto_numero= m.auto_numero and m3.auto_modelo=m.auto_modelo and m3.codigo_sector=s.codigo_sector),
(select top 1 max(mc.caja_desgaste)
			FROM CEBOLLITA_SUB_CAMPEON.Medicion m4
			join CEBOLLITA_SUB_CAMPEON.Medicion_caja mc on m4.codigo_medicion=mc.id_medicion
			WHERE m4.med_nro_vuelta = m.med_nro_vuelta AND m4.id_carrera = m.id_carrera AND m4.auto_numero= m.auto_numero and m4.auto_modelo=m.auto_modelo and m4.codigo_sector=s.codigo_sector)
			-
			(select top 1 min(mc.caja_desgaste)
			FROM CEBOLLITA_SUB_CAMPEON.Medicion m4
			join CEBOLLITA_SUB_CAMPEON.Medicion_Caja mc on m4.codigo_medicion=mc.id_medicion
			WHERE m4.med_nro_vuelta = m.med_nro_vuelta AND m4.id_carrera = m.id_carrera AND m4.auto_numero= m.auto_numero and m4.auto_modelo=m.auto_modelo and m4.codigo_sector=s.codigo_sector),
((select top 1 sum(f.freno_grosor_pastilla) from CEBOLLITA_SUB_CAMPEON.Medicion m1 
			join CEBOLLITA_SUB_CAMPEON.Medicion_Freno f on m1.codigo_medicion=f.id_medicion 
			where m1.med_nro_vuelta=m.med_nro_vuelta and m1.id_carrera=m.id_carrera and m1.auto_modelo=m.auto_modelo and m1.auto_numero=m.auto_numero and m1.codigo_sector=s.codigo_sector
			group by m1.med_tiempo_vuelta 
			order by m1.med_tiempo_vuelta asc)-(select top 1 sum(f.freno_grosor_pastilla) from CEBOLLITA_SUB_CAMPEON.Medicion m1
			join CEBOLLITA_SUB_CAMPEON.Medicion_Freno f on m1.codigo_medicion=f.id_medicion 
			where m1.med_nro_vuelta=m.med_nro_vuelta and m1.id_carrera=m.id_carrera and m1.auto_modelo=m.auto_modelo and m1.auto_numero=m.auto_numero and m1.codigo_sector=s.codigo_sector
			group by m1.med_tiempo_vuelta 
			order by m1.med_tiempo_vuelta desc))/4,
((select top 1 sum(n.neumatico_profundidad) from CEBOLLITA_SUB_CAMPEON.Medicion m1 
			join CEBOLLITA_SUB_CAMPEON.Medicion_Neumatico n on m1.codigo_medicion=n.id_medicion 
			where m1.med_nro_vuelta=m.med_nro_vuelta and m1.id_carrera=m.id_carrera and m1.auto_modelo=m.auto_modelo and m1.auto_numero=m.auto_numero and m1.codigo_sector=s.codigo_sector
			group by m1.med_tiempo_vuelta
			order by m1.med_tiempo_vuelta asc)-(select top 1 sum(n.neumatico_profundidad) from CEBOLLITA_SUB_CAMPEON.Medicion m1 
			join CEBOLLITA_SUB_CAMPEON.Medicion_Neumatico n on m1.codigo_medicion=n.id_medicion 
			where m1.med_nro_vuelta=m.med_nro_vuelta and m1.id_carrera=m.id_carrera and m1.auto_modelo=m.auto_modelo and m1.auto_numero=m.auto_numero and m1.codigo_sector=s.codigo_sector
			group by m1.med_tiempo_vuelta
			order by m1.med_tiempo_vuelta desc))/4,
(select top 1 tn.id_tipo_neumatico from CEBOLLITA_SUB_CAMPEON.Medicion m2
	join CEBOLLITA_SUB_CAMPEON.Medicion_Neumatico mn on
		mn.id_medicion = m2.codigo_medicion
	join CEBOLLITA_SUB_CAMPEON.Neumatico n on
		n.neumatico_serie = mn.id_neumatico
	join CEBOLLITA_SUB_CAMPEON.BI_Tipo_Neumatico tn on
		n.neumatico_tipo = tn.id_tipo_neumatico
	where m2.auto_modelo = m.auto_modelo and m2.auto_numero = m.auto_numero and m2.id_carrera = m.id_carrera and m2.codigo_sector = s.codigo_sector and m2.med_nro_vuelta = m.med_nro_vuelta)
from CEBOLLITA_SUB_CAMPEON.Medicion m
	join CEBOLLITA_SUB_CAMPEON.Carrera c on c.id_carrera=m.id_carrera
	join CEBOLLITA_SUB_CAMPEON.Sector s on s.codigo_sector=m.codigo_sector
	join CEBOLLITA_SUB_CAMPEON.[Auto] a on a.auto_modelo=m.auto_modelo and a.auto_numero=m.auto_numero
group by 
	m.med_nro_vuelta,
	m.auto_modelo,
	m.auto_numero,
	m.id_carrera,
	year(c.carrera_fecha),
	DATEPART(QUARTER,c.carrera_fecha),
	s.codigo_sector,
	s.sector_tipo,
	a.escuderia,
	a.auto_piloto_nombre,
	a.auto_piloto_apellido
commit
go

exec CEBOLLITA_SUB_CAMPEON.Cargar_mediciones_BI
GO

CREATE TABLE CEBOLLITA_SUB_CAMPEON.BI_Paradas(
	dim_circuito int,
	dim_anio int,
	dim_cuatri int,
	dim_escuderia nvarchar(255) foreign key references CEBOLLITA_SUB_CAMPEON.BI_Escuderia,
	tiempo_parada decimal(18,10),
	cantidad_paradas int,
	PRIMARY KEY(dim_circuito,dim_anio,dim_cuatri,dim_escuderia),
	foreign key(dim_anio,dim_cuatri) references CEBOLLITA_SUB_CAMPEON.BI_Tiempo(año, cuatrimestre),
) ON [PRIMARY]
go

Create procedure CEBOLLITA_SUB_CAMPEON.Cargar_BI_Paradas
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.BI_Paradas (
	tiempo_parada,
	cantidad_paradas,
	dim_circuito,
	dim_anio,
	dim_cuatri,
	dim_escuderia
)
SELECT 
	sum(tiempo_parada),
	counT(*),
	p.id_carrera,
	year(c.carrera_fecha),
	DATEPART(QUARTER,c.carrera_fecha),
	a.escuderia
FROM CEBOLLITA_SUB_CAMPEON.Parada p
	join CEBOLLITA_SUB_CAMPEON.Carrera c on c.id_carrera=p.id_carrera
	join CEBOLLITA_SUB_CAMPEON.[Auto] a on a.auto_numero= p.auto_numero and a.auto_modelo=p.auto_modelo
group by 
	p.id_carrera,
	year(c.carrera_fecha),
	DATEPART(QUARTER,c.carrera_fecha),
	a.escuderia
commit
go


exec CEBOLLITA_SUB_CAMPEON.Cargar_BI_Paradas
go

CREATE TABLE CEBOLLITA_SUB_CAMPEON.BI_Incidentes(
	dim_anio int,
	dim_cuatri int,
	dim_escuderia nvarchar(255) foreign key references CEBOLLITA_SUB_CAMPEON.BI_Escuderia,
	dim_circuito int foreign key references CEBOLLITA_SUB_CAMPEON.BI_Circuito,
	dim_tipo_sector nvarchar(255) foreign key references CEBOLLITA_SUB_CAMPEON.BI_Tipo_Sector,
	dim_sector int,
	dim_incidente_tipo int foreign key references CEBOLLITA_SUB_CAMPEON.BI_Incidente_Tipo,
	dim_piloto_nombre nvarchar(255),
	dim_piloto_apellido nvarchar(255),
	dim_auto_modelo nvarchar(255),
	dim_auto_nro int,
	cantidad_incidentes int,
	constraint [FKBITIEMPOINCD] foreign key(dim_anio,dim_cuatri) references CEBOLLITA_SUB_CAMPEON.BI_Tiempo(año, cuatrimestre),
	constraint [FKBIAUTOINCD]foreign key(dim_auto_modelo,dim_auto_nro) references CEBOLLITA_SUB_CAMPEON.BI_Auto(auto_modelo,auto_numero),
	constraint [FKBIPILOTOINCD] foreign key(dim_piloto_nombre,dim_piloto_apellido) references CEBOLLITA_SUB_CAMPEON.BI_Piloto(piloto_nombre,piloto_apellido),
	PRIMARY KEY(dim_anio,dim_cuatri,dim_escuderia,dim_tipo_sector,dim_sector,dim_incidente_tipo,dim_piloto_nombre,dim_piloto_apellido,dim_auto_modelo,dim_auto_nro)

)on [Primary]
go

create procedure CEBOLLITA_SUB_CAMPEON.Cargar_Incidentes_BI
AS
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.BI_Incidentes (
		dim_tipo_sector,
		dim_sector,
		dim_circuito,
		dim_anio,
		dim_cuatri,
		dim_auto_nro,
		dim_auto_modelo,
		dim_incidente_tipo,
		dim_piloto_nombre,
		dim_piloto_apellido,
		dim_escuderia,
		cantidad_incidentes
)
(select
	s.sector_tipo,
	s.codigo_sector,
	c.circuito_codigo,
	Year(carrera.carrera_fecha),
	DatePart(Quarter,carrera.carrera_fecha),
	ia.auto_incidente_nuro,
	ia.auto_incidente_codigo,
	ia.incidente_tipo,
	a.auto_piloto_nombre,
	a.auto_piloto_apellido,
	a.escuderia,
	count(*)
from CEBOLLITA_SUB_CAMPEON.Incidente i
	join CEBOLLITA_SUB_CAMPEON.Sector s on i.sector=s.codigo_sector
	join CEBOLLITA_SUB_CAMPEON.Circuito c on c.circuito_codigo= s.id_circuito
	join CEBOLLITA_SUB_CAMPEON.Carrera carrera on carrera.circuito_codigo=c.circuito_codigo
	join CEBOLLITA_SUB_CAMPEON.Incidente_Auto ia on ia.id_incidente=i.id_incidente
	join CEBOLLITA_SUB_CAMPEON.[Auto] a on a.auto_modelo= ia.auto_incidente_codigo and a.auto_numero=ia.auto_incidente_nuro
group by 
	s.sector_tipo,
	s.codigo_sector,
	c.circuito_codigo,
	Year(carrera.carrera_fecha),
	DatePart(Quarter,carrera.carrera_fecha),
	ia.auto_incidente_nuro,
	ia.auto_incidente_codigo,
	ia.incidente_tipo,
	a.auto_piloto_nombre,
	a.auto_piloto_apellido,
	a.escuderia
	)

		
commit
go

exec CEBOLLITA_SUB_CAMPEON.Cargar_Incidentes_BI
GO


--VIEW 1
create view CEBOLLITA_SUB_CAMPEON.DesgastePromedioPorVueltaPorAutoPorCircuito
as
select 
		sum(Potencia_motor) desgaste_motor,
		sum(m.Desgaste_caja) desgaste_caja,---ver estoooooooo
		sum(desgaste_frenos) desgaste_freno,
		sum(desgaste_neumaticos) desgaste_neumaticos,
		m.dim_vuelta,
		m.dim_circuito,
		m.dim_auto_nro,
		m.dim_auto_modelo 
		from CEBOLLITA_SUB_CAMPEON.BI_Medicion m
	group by m.dim_vuelta,m.dim_circuito,m.dim_auto_nro,m.dim_auto_modelo
	go


--VIEW 2

CREATE FUNCTION CEBOLLITA_SUB_CAMPEON.TiempoVueltasEnCircuito(@año int, @circuito int,@escuderia nvarchar(255))
returns decimal(18,10)
as
begin
	return(
	select top 1
	sum(tiempo_vuelta)
	from CEBOLLITA_SUB_CAMPEON.BI_Medicion m 
	where m.dim_anio=@año and m.dim_circuito=@circuito and m.dim_escuderia=@escuderia
	group by dim_vuelta, dim_auto_modelo,dim_auto_nro
	having sum(tiempo_vuelta)>0
	order by 1 asc
	)
end
go

create view CEBOLLITA_SUB_CAMPEON.TiempoPorVueltaPorPiloto 
as
select 
sum(m.tiempo_vuelta) as tiempoVuelta,
m.dim_anio año,
m.dim_cuatri cuatri,
m.dim_circuito circuito,
m.dim_escuderia escuderia,
m.dim_vuelta vuelta,
m.dim_auto_nro autoNro,
dim_auto_modelo auto_modelo
from CEBOLLITA_SUB_CAMPEON.BI_Medicion m
group by 
m.dim_anio,
m.dim_circuito,
m.dim_escuderia,
m.dim_vuelta,
m.dim_auto_nro,
dim_auto_modelo,
m.dim_cuatri
go


CREATE VIEW CEBOLLITA_SUB_CAMPEON.MejorVueltaPorCiruitoPorAño AS
SELECT 
(select top 1 min(tiempoVuelta) from CEBOLLITA_SUB_CAMPEON.TiempoPorVueltaPorPiloto where año=m.dim_anio and circuito=m.dim_circuito and escuderia=m.dim_escuderia and tiempoVuelta>0)mejor_vuelta,
m.dim_anio año,
m.dim_circuito circuito,
m.dim_escuderia escuderia
FROM CEBOLLITA_SUB_CAMPEON.BI_Medicion m
group by dim_escuderia,dim_circuito,dim_anio
go

--VIEW 3

create VIEW CEBOLLITA_SUB_CAMPEON.CircuitosDeMayorConsumoPromedio AS
SELECT TOP 3 
	dim_circuito,
	sum(combustible) as Gasto 
FROM CEBOLLITA_SUB_CAMPEON.BI_Medicion 
GROUP BY 
	dim_circuito
ORDER BY Gasto desc
go


--VIEW 4
CREATE VIEW CEBOLLITA_SUB_CAMPEON.MaximaVelocidad AS
SELECT
	max(velocidad) as velocidad_maxima,
	dim_auto_nro,dim_auto_modelo,
	dim_circuito,
	dim_tipo_sector 
FROM CEBOLLITA_SUB_CAMPEON.BI_Medicion
group by dim_tipo_sector,dim_circuito,dim_auto_nro,dim_auto_modelo
go


--VIEW 5
CREATE VIEW CEBOLLITA_SUB_CAMPEON.TiempoPromedioDeParadaPorEscuderiaPorCuatri AS
SELECT sum(tiempo_parada)/sum(cantidad_paradas) as promedioParada,dim_escuderia,dim_cuatri FROM CEBOLLITA_SUB_CAMPEON.BI_Paradas
group by dim_escuderia,dim_cuatri
go


-- VIEW 6
CREATE VIEW CEBOLLITA_SUB_CAMPEON.ParadasPorCircuitoPorEscuderiaPorAnio AS
SELECT sum(cantidad_paradas) as cantidad,dim_circuito,dim_escuderia,dim_anio FROM CEBOLLITA_SUB_CAMPEON.BI_Paradas
group by dim_circuito,dim_escuderia,dim_anio
go

--VIEW 7
CREATE VIEW CEBOLLITA_SUB_CAMPEON.TiempoTotalEnParada AS
SELECT TOP 3 SUM(tiempo_parada)as tiempo_total_en_parada, 
	dim_circuito 
FROM CEBOLLITA_SUB_CAMPEON.BI_Paradas
group by
	dim_circuito
order by tiempo_total_en_parada desc
go

--VIEW 8
CREATE VIEW CEBOLLITA_SUB_CAMPEON.CircuitosMasPeligrososPorAño AS
select
año,
(select top 1 dim_circuito
from CEBOLLITA_SUB_CAMPEON.BI_Incidentes
where dim_anio=año
group by dim_circuito
order by sum(cantidad_incidentes) desc)as primer_ciruito_mas_peligroso,
ISnull((select top 1 dim_circuito
from CEBOLLITA_SUB_CAMPEON.BI_Incidentes
where dim_anio=año and dim_circuito!= (select top 1 dim_circuito
from CEBOLLITA_SUB_CAMPEON.BI_Incidentes
where dim_anio=año
group by dim_circuito
order by sum(cantidad_incidentes) desc)
group by dim_circuito
order by sum(cantidad_incidentes) desc),0) as segundo_ciruito_mas_peligroso,
isnull((select top 1 dim_circuito
from CEBOLLITA_SUB_CAMPEON.BI_Incidentes
where dim_anio=año and dim_circuito not in (select top 2 dim_circuito
from CEBOLLITA_SUB_CAMPEON.BI_Incidentes
where dim_anio=año
group by dim_circuito
order by sum(cantidad_incidentes) desc)
group by dim_circuito
order by  sum(cantidad_incidentes) desc),0 )as tercer_ciruito_mas_peligroso
from CEBOLLITA_SUB_CAMPEON.BI_Tiempo
group by año
go

-- VIEW 9
create view CEBOLLITA_SUB_CAMPEON.IncidentesPorSectorPorAño
as
select
t.año,
s.sector_tipo,
e.escuderia_nombre,
Isnull((select avg(cantidad_incidentes) from CEBOLLITA_SUB_CAMPEON.BI_Incidentes i where i.dim_anio=t.año and i.dim_escuderia=e.escuderia_nombre and i.dim_tipo_sector=s.sector_tipo group by i.dim_anio,i.dim_tipo_sector,i.dim_escuderia),0)as Cantidad_de_Incidentes
from CEBOLLITA_SUB_CAMPEON.BI_Tiempo t, CEBOLLITA_SUB_CAMPEON.BI_Tipo_Sector s, CEBOLLITA_SUB_CAMPEON.BI_Escuderia e
group by t.año,s.sector_tipo,e.escuderia_nombre
go

commit
go
