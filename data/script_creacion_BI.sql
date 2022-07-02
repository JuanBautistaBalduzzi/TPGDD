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

CREATE TABLE CEBOLLITA_SUB_CAMPEON.BI_Medicion (
	codigo_medicion nvarchar(255),
	dim_auto_modelo nvarchar(255) ,
	dim_auto_nro int,
	dim_tipo_sector nvarchar(255) FOREIGN KEY REFERENCES CEBOLLITA_SUB_CAMPEON.BI_Tipo_Sector,
	dim_escuderia nvarchar(255) FOREIGN KEY REFERENCES CEBOLLITA_SUB_CAMPEON.BI_Escuderia,
	dim_circuito int FOREIGN KEY REFERENCES CEBOLLITA_SUB_CAMPEON.BI_Circuito,
	dim_anio int,
	dim_cuatri int,
	dim_piloto_nombre nvarchar(255),
	dim_piloto_apellido nvarchar(255),
	dim_tipo_neumatico int FOREIGN KEY REFERENCES CEBOLLITA_SUB_CAMPEON.BI_Tipo_Neumatico,
	velocidad decimal(18,2),
	combustible decimal(18,2),
	tiempo_vuelta decimal(18,10),
	num_vuelta decimal(18,0),
	Potencia_motor decimal(18,6),
	Desgaste_caja decimal(18,2),
	Grosor_freno1 decimal(18,0),
	Grosor_freno2 decimal(18,0),
	Grosor_freno3 decimal(18,0),
	Grosor_freno4 decimal(18,0),
	profundidad_neu1 decimal(18,6),
	profundidad_neu2 decimal(18,6),
	profundidad_neu3 decimal(18,6),
	profundidad_neu4 decimal(18,6),
	PRIMARY KEY(codigo_medicion,dim_auto_modelo,dim_auto_nro,dim_tipo_sector,dim_escuderia,dim_anio,dim_cuatri,dim_piloto_nombre,dim_piloto_apellido),
	foreign key(dim_anio,dim_cuatri) references CEBOLLITA_SUB_CAMPEON.BI_Tiempo(año, cuatrimestre),
	foreign key(dim_auto_modelo,dim_auto_nro) references CEBOLLITA_SUB_CAMPEON.BI_Auto(auto_modelo,auto_numero),
	foreign key(dim_piloto_nombre,dim_piloto_apellido) references CEBOLLITA_SUB_CAMPEON.BI_Piloto(piloto_nombre,piloto_apellido)
) on [PRIMARY]
go


create procedure CEBOLLITA_SUB_CAMPEON.Cargar_mediciones_BI
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.BI_Medicion(
	codigo_medicion,
	combustible,
	num_vuelta,
	velocidad,
	tiempo_vuelta,
	dim_auto_modelo,
	dim_auto_nro,
	dim_circuito,
	dim_anio,
	dim_cuatri,
	dim_tipo_sector,
	dim_escuderia,
	dim_piloto_nombre,
	dim_piloto_apellido,
	Potencia_motor,
	Desgaste_caja,
	profundidad_neu1,
	profundidad_neu2,
	profundidad_neu3,
	profundidad_neu4,
	Grosor_freno1,
	Grosor_freno2,
	Grosor_freno3,
	Grosor_freno4,
	dim_tipo_neumatico
)
select 
m.codigo_medicion,
m.med_combustible,
m.med_nro_vuelta,
m.med_velocidad,
m.med_tiempo_vuelta,
m.auto_modelo,
m.auto_numero,
m.id_carrera,
year(c.carrera_fecha),
DATEPART(QUARTER,c.carrera_fecha),
s.sector_tipo,
a.escuderia,
a.auto_piloto_nombre,
a.auto_piloto_apellido,
mm.motor_potencia,
mc.caja_desgaste,
(select neumatico_profundidad from CEBOLLITA_SUB_CAMPEON.Medicion_Neumatico mn inner join CEBOLLITA_SUB_CAMPEON.Neumatico neu_DD on neu_DD.neumatico_serie= mn.id_neumatico and neu_DD.neumatico_posicion='Delantero Derecho' WHERE mn.id_medicion= m.codigo_medicion),
(select neumatico_profundidad from CEBOLLITA_SUB_CAMPEON.Medicion_Neumatico mn inner join CEBOLLITA_SUB_CAMPEON.Neumatico neu_DI on neu_DI.neumatico_serie= mn.id_neumatico and neu_DI.neumatico_posicion='Delantero Izquierdo'WHERE mn.id_medicion= m.codigo_medicion),
(select neumatico_profundidad from CEBOLLITA_SUB_CAMPEON.Medicion_Neumatico mn 	inner join CEBOLLITA_SUB_CAMPEON.Neumatico neu_TD on neu_TD.neumatico_serie= mn.id_neumatico and neu_TD.neumatico_posicion='Trasero Derecho' WHERE mn.id_medicion= m.codigo_medicion),
(select neumatico_profundidad from CEBOLLITA_SUB_CAMPEON.Medicion_Neumatico mn 	inner join CEBOLLITA_SUB_CAMPEON.Neumatico neu_TI on neu_TI.neumatico_serie= mn.id_neumatico and neu_TI.neumatico_posicion='Trasero Izquierdo' WHERE mn.id_medicion= m.codigo_medicion),
(select freno_grosor_pastilla from CEBOLLITA_SUB_CAMPEON.Medicion_Freno mn inner join CEBOLLITA_SUB_CAMPEON.Freno neu_DD on neu_DD.Freno_serie= mn.id_Freno and neu_DD.Freno_posicion='Delantero Derecho' WHERE mn.id_medicion= m.codigo_medicion),
(select freno_grosor_pastilla from CEBOLLITA_SUB_CAMPEON.Medicion_Freno mn inner join CEBOLLITA_SUB_CAMPEON.Freno neu_DI on neu_DI.Freno_serie= mn.id_Freno and neu_DI.Freno_posicion='Delantero Izquierdo'WHERE mn.id_medicion= m.codigo_medicion),
(select freno_grosor_pastilla from CEBOLLITA_SUB_CAMPEON.Medicion_Freno mn 	inner join CEBOLLITA_SUB_CAMPEON.Freno neu_TD on neu_TD.Freno_serie= mn.id_Freno and neu_TD.Freno_posicion='Trasero Derecho' WHERE mn.id_medicion= m.codigo_medicion),
(select freno_grosor_pastilla from CEBOLLITA_SUB_CAMPEON.Medicion_Freno mn 	inner join CEBOLLITA_SUB_CAMPEON.Freno neu_TI on neu_TI.Freno_serie= mn.id_Freno and neu_TI.Freno_posicion='Trasero Izquierdo' WHERE mn.id_medicion= m.codigo_medicion),
(select neumatico_tipo from CEBOLLITA_SUB_CAMPEON.Medicion_Neumatico mn inner join CEBOLLITA_SUB_CAMPEON.Neumatico neu_DD on neu_DD.neumatico_serie= mn.id_neumatico and neu_DD.neumatico_posicion='Delantero Derecho' WHERE mn.id_medicion= m.codigo_medicion)
from CEBOLLITA_SUB_CAMPEON.Medicion m
	join CEBOLLITA_SUB_CAMPEON.Carrera c on c.id_carrera=m.id_carrera
	join CEBOLLITA_SUB_CAMPEON.Sector s on s.codigo_sector=m.codigo_sector
	join CEBOLLITA_SUB_CAMPEON.[Auto] a on a.auto_modelo=m.auto_modelo and a.auto_numero=m.auto_numero
	join CEBOLLITA_SUB_CAMPEON.Medicion_Motor mm on mm.id_medicion=m.codigo_medicion
	join CEBOLLITA_SUB_CAMPEON.Medicion_Caja mc on mc.id_medicion=m.codigo_medicion
commit
go

exec CEBOLLITA_SUB_CAMPEON.Cargar_mediciones_BI
GO

CREATE TABLE CEBOLLITA_SUB_CAMPEON.BI_Paradas(
	Id_parada int,
	dim_circuito int,
	dim_anio int,
	dim_cuatri int,
	dim_escuderia nvarchar(255) foreign key references CEBOLLITA_SUB_CAMPEON.BI_Escuderia,
	dim_auto_modelo nvarchar(255),
	dim_auto_nro int,
	tiempo_parada decimal(18,10),
	vuelta decimal(18,0),
	PRIMARY KEY(Id_parada,dim_circuito,dim_anio,dim_cuatri,dim_escuderia,dim_auto_modelo,dim_auto_nro),
	foreign key(dim_anio,dim_cuatri) references CEBOLLITA_SUB_CAMPEON.BI_Tiempo(año, cuatrimestre),
	foreign key(dim_auto_modelo,dim_auto_nro) references CEBOLLITA_SUB_CAMPEON.BI_Auto(auto_modelo,auto_numero),
) ON [PRIMARY]
go

Create procedure CEBOLLITA_SUB_CAMPEON.Cargar_BI_Paradas
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.BI_Paradas (
	Id_parada,
	vuelta,
	tiempo_parada,
	dim_auto_modelo,
	dim_auto_nro,
	dim_circuito,
	dim_anio,
	dim_cuatri,
	dim_escuderia
)
SELECT 
	id_parada,
	nro_de_vuelta,
	tiempo_parada,
	p.auto_modelo,
	p.auto_numero,
	p.id_carrera,
	year(c.carrera_fecha),
	DATEPART(QUARTER,c.carrera_fecha),
	a.escuderia
FROM CEBOLLITA_SUB_CAMPEON.Parada p
	join CEBOLLITA_SUB_CAMPEON.Carrera c on c.id_carrera=p.id_carrera
	join CEBOLLITA_SUB_CAMPEON.[Auto] a on a.auto_numero= p.auto_numero and a.auto_modelo=p.auto_modelo
commit
go

exec CEBOLLITA_SUB_CAMPEON.Cargar_BI_Paradas
go

CREATE TABLE CEBOLLITA_SUB_CAMPEON.BI_Incidentes(
	Id_incidente int,
	dim_anio int,
	dim_cuatri int,
	dim_escuderia nvarchar(255) foreign key references CEBOLLITA_SUB_CAMPEON.BI_Escuderia,
	dim_circuito int foreign key references CEBOLLITA_SUB_CAMPEON.BI_Circuito,
	dim_tipo_sector nvarchar(255) foreign key references CEBOLLITA_SUB_CAMPEON.BI_Tipo_Sector,
	dim_incidente_tipo int foreign key references CEBOLLITA_SUB_CAMPEON.BI_Incidente_Tipo,
	dim_piloto_nombre nvarchar(255),
	dim_piloto_apellido nvarchar(255),
	dim_auto_modelo nvarchar(255),
	dim_auto_nro int,
	bandera nvarchar(255),

	constraint [FKBITIEMPOINCD] foreign key(dim_anio,dim_cuatri) references CEBOLLITA_SUB_CAMPEON.BI_Tiempo(año, cuatrimestre),
	constraint [FKBIAUTOINCD]foreign key(dim_auto_modelo,dim_auto_nro) references CEBOLLITA_SUB_CAMPEON.BI_Auto(auto_modelo,auto_numero),
	constraint [FKBIPILOTOINCD] foreign key(dim_piloto_nombre,dim_piloto_apellido) references CEBOLLITA_SUB_CAMPEON.BI_Piloto(piloto_nombre,piloto_apellido),
	PRIMARY KEY(Id_incidente,dim_anio,dim_cuatri,dim_escuderia,dim_tipo_sector,dim_incidente_tipo,dim_piloto_nombre,dim_piloto_apellido,dim_auto_modelo,dim_auto_nro)

)on [Primary]
go

create procedure CEBOLLITA_SUB_CAMPEON.Cargar_Incidentes_BI
AS
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.BI_Incidentes (
		id_incidente,
		bandera,
		dim_tipo_sector,
		dim_circuito,
		dim_anio,
		dim_cuatri,
		dim_auto_nro,
		dim_auto_modelo,
		dim_incidente_tipo,
		dim_piloto_nombre,
		dim_piloto_apellido,
		dim_escuderia
)
(select
	i.id_incidente,
	i.bandera,
	s.sector_tipo,
	c.circuito_codigo,
	Year(carrera.carrera_fecha),
	DatePart(Quarter,carrera.carrera_fecha),
	ia.auto_incidente_nuro,
	ia.auto_incidente_codigo,
	ia.incidente_tipo,
	a.auto_piloto_nombre,
	a.auto_piloto_apellido,
	a.escuderia
from CEBOLLITA_SUB_CAMPEON.Incidente i
	join CEBOLLITA_SUB_CAMPEON.Sector s on i.sector=s.codigo_sector
	join CEBOLLITA_SUB_CAMPEON.Circuito c on c.circuito_codigo= s.id_circuito
	join CEBOLLITA_SUB_CAMPEON.Carrera carrera on carrera.circuito_codigo=c.circuito_codigo
	join CEBOLLITA_SUB_CAMPEON.Incidente_Auto ia on ia.id_incidente=i.id_incidente
	join CEBOLLITA_SUB_CAMPEON.[Auto] a on a.auto_modelo= ia.auto_incidente_codigo and a.auto_numero=ia.auto_incidente_nuro
	)
commit
go

exec CEBOLLITA_SUB_CAMPEON.Cargar_Incidentes_BI
GO


--VIEW 1
create view CEBOLLITA_SUB_CAMPEON.DesgastePromedioPorVueltaPorAutoPorCircuito
as
select ((select max(profundidad_neu1) from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo)
		-
		(select min(profundidad_neu1) from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo)) as gasto_neumatico_1,
		(select top 1 profundidad_neu2 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 desc)
		-
		(select top 1 profundidad_neu2 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 asc) as gasto_neumatico_2,
		(select top 1 profundidad_neu3 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 desc)
		-
		(select top 1 profundidad_neu3 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 asc) as gasto_neumatico_3,
		((select top 1 profundidad_neu4 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 desc)
		-
		(select top 1 profundidad_neu4 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 asc)) as gasto_neumatico_4,
		((select top 1 Grosor_freno1 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 asc)
		-
		(select top 1 Grosor_freno1 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 desc)) as desgaste_freno_1,
		((select top 1 Grosor_freno2 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 asc)
		-
		(select top 1 Grosor_freno2 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 desc)) as desgaste_freno_2,
		((select top 1 Grosor_freno3 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 asc)
		-
		(select top 1 Grosor_freno3 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 desc)) as gasto_freno_3,
		((select top 1 Grosor_freno4 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 asc)
		-
		(select top 1 Grosor_freno4 from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by 1 desc)) as gasto_freno_4,

		((select top 1 Potencia_motor from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by tiempo_vuelta asc) - 
		(select top 1 Potencia_motor from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
		where dim_circuito=m.dim_circuito and num_vuelta=m.num_vuelta and dim_auto_nro=m.dim_auto_nro and dim_auto_modelo=m.dim_auto_modelo
		order by tiempo_vuelta desc) ) as desgaste_motor,
		avg(m.Desgaste_caja)as desgaste_caja,
		m.num_vuelta,
		m.dim_circuito,
		m.dim_auto_nro,
		m.dim_auto_modelo 
		from CEBOLLITA_SUB_CAMPEON.BI_Medicion m
	group by m.num_vuelta,m.dim_circuito,m.dim_auto_nro,m.dim_auto_modelo
	go


--VIEW 2
create function CEBOLLITA_SUB_CAMPEON.tiempoVuelta(@vuelta int, @circuito int, @autonumero int, @automodelo nvarchar(255),@año int)
returns decimal(18,10)
as 
begin
return (SELECT max(tiempo_vuelta)
		FROM CEBOLLITA_SUB_CAMPEON.BI_Medicion
		WHERE dim_anio = @año AND num_vuelta = @vuelta AND dim_circuito = @circuito AND dim_auto_nro = @autonumero and dim_auto_modelo=@automodelo)
end
go

CREATE VIEW CEBOLLITA_SUB_CAMPEON.VueltaMasRapidaPorCiruitoPorAño AS
SELECT (select min(TIEMPO_VUELTA) 
		FROM(select 
			(CEBOLLITA_SUB_CAMPEON.tiempovuelta(num_vuelta,dim_circuito,dim_auto_nro,dim_auto_modelo,dim_anio)) AS TIEMPO_VUELTA
			from CEBOLLITA_SUB_CAMPEON.BI_Medicion m1
WHERE m1.dim_circuito=m3.dim_circuito AND m1.dim_escuderia=m3.dim_escuderia and m1.dim_anio=m3.dim_anio
and CEBOLLITA_SUB_CAMPEON.tiempovuelta(num_vuelta,dim_circuito,dim_auto_nro,dim_auto_modelo,dim_anio)>0
GROUP BY num_vuelta,dim_circuito,dim_auto_nro,dim_auto_modelo,dim_anio)AS TIEMPOS
) as tiempo_mas_rapido,
						dim_escuderia,
						dim_circuito,
						dim_anio 
						FROM CEBOLLITA_SUB_CAMPEON.BI_Medicion m3
group by dim_escuderia,dim_circuito,dim_anio
go



CREATE VIEW CEBOLLITA_SUB_CAMPEON.MejorVueltaPorCiruitoPorAño AS
SELECT (select min(TIEMPO_VUELTA) 
		FROM(select 
			((SELECT max(tiempo_vuelta)
		FROM CEBOLLITA_SUB_CAMPEON.BI_Medicion
		WHERE dim_anio = m1.dim_anio AND num_vuelta = m1.num_vuelta AND dim_circuito = m1.dim_circuito AND dim_auto_nro = m1.dim_auto_nro and dim_auto_modelo=m1.dim_auto_modelo)) AS TIEMPO_VUELTA
			from CEBOLLITA_SUB_CAMPEON.BI_Medicion m1
WHERE m1.dim_circuito=m3.dim_circuito AND m1.dim_escuderia=m3.dim_escuderia and m1.dim_anio=m3.dim_anio
and (SELECT max(tiempo_vuelta)
		FROM CEBOLLITA_SUB_CAMPEON.BI_Medicion
		WHERE dim_anio = m1.dim_anio AND num_vuelta = m1.num_vuelta AND dim_circuito = m1.dim_circuito AND dim_auto_nro = m1.dim_auto_nro and dim_auto_modelo=m1.dim_auto_modelo)>0
GROUP BY num_vuelta,dim_circuito,dim_auto_nro,dim_auto_modelo,dim_anio)AS TIEMPOS
) as tiempo_mas_rapido,
						dim_escuderia,
						dim_circuito,
						dim_anio 
						FROM CEBOLLITA_SUB_CAMPEON.BI_Medicion m3
group by dim_escuderia,dim_circuito,dim_anio

go



--VIEW 3
create FUNCTION CEBOLLITA_SUB_CAMPEON.gastoCombustiblePorPilotoPorCircuito (
	@modeloAuto nvarchar(255),
	@numeroAuto int,
	@circuito int
)
RETURNS int AS
BEGIN
	DECLARE @return_value int;
	DECLARE @lastValue int;
    SET @lastValue = (SELECT min(combustible) from CEBOLLITA_SUB_CAMPEON.BI_Medicion 
							WHERE dim_auto_modelo = @modeloAuto AND dim_auto_nro = @numeroAuto AND dim_circuito=@circuito
							group by 
							dim_auto_nro,
							dim_auto_modelo,
							dim_circuito
							);
	SET @return_value = 600 - @lastValue;
 
    RETURN @return_value;
END
go


create VIEW CEBOLLITA_SUB_CAMPEON.CircuitosDeMayorConsumoPromedio AS
SELECT TOP 3 
	dim_circuito,
	avg(CEBOLLITA_SUB_CAMPEON.gastoCombustiblePorPilotoPorCircuito(dim_auto_modelo,dim_auto_nro,dim_circuito)) as Gasto 
FROM CEBOLLITA_SUB_CAMPEON.BI_Medicion 
GROUP BY 
	dim_circuito,
	dim_piloto_nombre,
	dim_piloto_apellido
ORDER BY Gasto desc
go


--VIEW 4
CREATE VIEW CEBOLLITA_SUB_CAMPEON.MaximaVelocidad AS
SELECT max(velocidad) as velocidad_maxima,dim_auto_nro,dim_auto_modelo,dim_circuito,dim_tipo_sector FROM CEBOLLITA_SUB_CAMPEON.BI_Medicion
group by dim_tipo_sector,dim_circuito,dim_auto_nro,dim_auto_modelo
go


--VIEW 5
CREATE VIEW CEBOLLITA_SUB_CAMPEON.TiempoPromedioDeParadaPorEscuderiaPorCuatri AS
SELECT AVG(tiempo_parada) as promedioParada,dim_escuderia,dim_cuatri FROM CEBOLLITA_SUB_CAMPEON.BI_Paradas
group by dim_escuderia,dim_cuatri
go


-- VIEW 6
CREATE VIEW CEBOLLITA_SUB_CAMPEON.ParadasPorCircuitoPorEscuderiaPorAnio AS
SELECT COUNT(*) as cantidad,dim_circuito,dim_escuderia,dim_anio FROM CEBOLLITA_SUB_CAMPEON.BI_Paradas
group by dim_circuito,dim_escuderia,dim_anio
go

--VIEW 7
CREATE VIEW CEBOLLITA_SUB_CAMPEON.TiempoTotalEnParada AS
SELECT TOP 3 SUM(tiempo_parada)as tiempo_total_en_parada, 
	dim_cuatri,
	dim_circuito 
FROM CEBOLLITA_SUB_CAMPEON.BI_Paradas
group by
	dim_circuito, 
	dim_cuatri
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
order by  count(distinct Id_incidente) desc)as primer_ciruito_mas_peligroso,
ISnull((select top 1 dim_circuito
from CEBOLLITA_SUB_CAMPEON.BI_Incidentes
where dim_anio=año and dim_circuito!= (select top 1 dim_circuito
from CEBOLLITA_SUB_CAMPEON.BI_Incidentes
where dim_anio=año
group by dim_circuito
order by  count(distinct Id_incidente) desc)
group by dim_circuito
order by  count(distinct Id_incidente) desc),0) as segundo_ciruito_mas_peligroso,
isnull((select top 1 dim_circuito
from CEBOLLITA_SUB_CAMPEON.BI_Incidentes
where dim_anio=año and dim_circuito not in (select top 2 dim_circuito
from CEBOLLITA_SUB_CAMPEON.BI_Incidentes
where dim_anio=año
group by dim_circuito
order by  count(distinct Id_incidente) desc)
group by dim_circuito
order by  count(distinct Id_incidente) desc),0 )as tercer_ciruito_mas_peligroso
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
(select count(*) from CEBOLLITA_SUB_CAMPEON.BI_Incidentes i where i.dim_anio=t.año and i.dim_escuderia=e.escuderia_nombre and i.dim_tipo_sector=s.sector_tipo)as Cantidad_de_Incidentes
from CEBOLLITA_SUB_CAMPEON.BI_Tiempo t, CEBOLLITA_SUB_CAMPEON.BI_Tipo_Sector s, CEBOLLITA_SUB_CAMPEON.BI_Escuderia e
group by t.año,s.sector_tipo,e.escuderia_nombre
go

commit
go