begin transaction

use GD1C2022
go

create schema CEBOLLITA_SUB_CAMPEON
go


create table [CEBOLLITA_SUB_CAMPEON].[Escuderia](
escuderia_nombre nvarchar(255) Primary Key,
escuderia_nacionalidad nvarchar(255)
) ON [PRIMARY] 
go

create table [CEBOLLITA_SUB_CAMPEON].[Piloto](
piloto_nombre nvarchar(255),
piloto_apellido nvarchar(255),
piloto_nacionalidad nvarchar(255),
piloto_fecha_nac Date
constraint [PKPILOTO] Primary key (
[piloto_nombre],
[piloto_apellido]
)
) ON [PRIMARY] 
go

create table [CEBOLLITA_SUB_CAMPEON].[Auto](
auto_modelo nvarchar(255),
auto_numero int,
escuderia nvarchar(255)FOREIGN KEY references [CEBOLLITA_SUB_CAMPEON].[Escuderia]([escuderia_nombre]) ,
auto_piloto_nombre nvarchar(255),
auto_piloto_apellido nvarchar(255)
constraint [PKAUTO] Primary key (
[auto_modelo],
[auto_numero]
)
)on [PRIMARY]
go

alter table  [CEBOLLITA_SUB_CAMPEON].[Auto]
WITH CHECK add constraint [FKPILOTOS] 
Foreign key ([auto_piloto_nombre], [auto_piloto_apellido])
references 
[CEBOLLITA_SUB_CAMPEON].[Piloto] ([piloto_nombre], [piloto_apellido])
go

CREATE INDEX escuderia_auto
ON CEBOLLITA_SUB_CAMPEON.Auto (escuderia);

create Table [CEBOLLITA_SUB_CAMPEON].[Circuito](
circuito_codigo int Primary key,
circuito_pais nvarchar(255),
circuito_nombre nvarchar(255)
) on [Primary]
go

create table [CEBOLLITA_SUB_CAMPEON].[Sector](
codigo_sector int primary key,
sector_distancia nvarchar(255),
sector_tipo nvarchar(255),
id_circuito int foreign key references [CEBOLLITA_SUB_CAMPEON].[Circuito](circuito_codigo) 
) on [PRIMARY]
go

CREATE INDEX circuitoDelSector
ON CEBOLLITA_SUB_CAMPEON.Sector (id_circuito);

create table [CEBOLLITA_SUB_CAMPEON].[Carrera](
id_carrera int primary key,
carrera_fecha date,
carrera_clima nvarchar(100),
carrera_total decimal(18,2),
carrera_cantvueltas int,
circuito_codigo int foreign key references [CEBOLLITA_SUB_CAMPEON].[Circuito](circuito_codigo)
) on[PRIMARY]
go

create table [CEBOLLITA_SUB_CAMPEON].[Incidente](
id_incidente int Primary Key Identity(1,1),
tiempo decimal(18,2),
bandera nvarchar(255),
sector int foreign key references [CEBOLLITA_SUB_CAMPEON].[Sector](codigo_sector)
)on [Primary]
go

create table [CEBOLLITA_SUB_CAMPEON].[Incidente_Tipo](
id_tipo int Primary Key identity(100,1),
tipo nvarchar(255)
)on [Primary]
go

create table [CEBOLLITA_SUB_CAMPEON].[Incidente_Auto](
id_incidente int foreign key references [CEBOLLITA_SUB_CAMPEON].[Incidente](id_incidente),
auto_incidente_codigo nvarchar(255),
auto_incidente_nuro int,
incidente_num_vuelta decimal(18,0), 
incidente_tipo int foreign key references [CEBOLLITA_SUB_CAMPEON].[Incidente_Tipo](id_tipo)
constraint [PKINCAUTO] Primary Key( id_incidente, auto_incidente_codigo,auto_incidente_nuro)
)on [Primary]
alter table [CEBOLLITA_SUB_CAMPEON].[Incidente_Auto] 
with check add constraint [FK_AUTO_INCIDENTE] 
Foreign key (auto_incidente_codigo,auto_incidente_nuro)
references  [CEBOLLITA_SUB_CAMPEON].[Auto](auto_modelo,auto_numero)
go

create table [CEBOLLITA_SUB_CAMPEON].[Motor](
id_motor nvarchar(255) Primary Key,
modelo_motor nvarchar(255)
)on [Primary]

go

create table [CEBOLLITA_SUB_CAMPEON].[Tipo_Neumatico](
id_tipo_neumatico int Primary Key Identity(1000,100),
detalle nvarchar(255)
) on [Primary]
go


create table [CEBOLLITA_SUB_CAMPEON].[Neumatico](
neumatico_serie nvarchar(255) Primary Key,
neumatico_posicion nvarchar(255),
neumatico_tipo int foreign key references [CEBOLLITA_SUB_CAMPEON].Tipo_Neumatico(id_tipo_neumatico)
) on [Primary]
go

CREATE INDEX posicion_del_neumatico
ON CEBOLLITA_SUB_CAMPEON.Neumatico (neumatico_posicion);

create table [CEBOLLITA_SUB_CAMPEON].[Freno](
freno_serie nvarchar(255) Primary Key,
tamanio_disco decimal(18,2),
freno_posicion nvarchar(255)
) on [Primary]
go

CREATE INDEX freno_posicion
ON CEBOLLITA_SUB_CAMPEON.Freno (freno_posicion);

create table [CEBOLLITA_SUB_CAMPEON].[Caja_de_Cambios](
caja_serie nvarchar(255) Primary Key,
modelo_caja nvarchar(50)
) on [Primary]
go

create table [CEBOLLITA_SUB_CAMPEON].[Medicion](
codigo_medicion decimal(18,0) Primary Key,
auto_modelo nvarchar(255),
auto_numero int,
id_carrera  int foreign key references [CEBOLLITA_SUB_CAMPEON].[Carrera](id_carrera),
codigo_sector int foreign key references [CEBOLLITA_SUB_CAMPEON].[Sector](codigo_sector),
med_nro_vuelta int,
med_distancia_carrera decimal(18,6),
med_distancia_vuelta decimal(18,2),
med_tiempo_vuelta decimal(18,10),
med_posicion int,
med_velocidad decimal(18,2),
med_combustible decimal(18,2)
) on [Primary]
go

alter table [CEBOLLITA_SUB_CAMPEON].[Medicion] 
	add constraint [FK_AUTO_MED] Foreign key(
	auto_modelo,
	auto_numero
	)
	references [CEBOLLITA_SUB_CAMPEON].[Auto](
	auto_modelo,
	auto_numero
	)
go

create table [CEBOLLITA_SUB_CAMPEON].[Medicion_Motor](
id_medicion decimal(18,0) foreign key references [CEBOLLITA_SUB_CAMPEON].[Medicion](codigo_medicion),
id_motor nvarchar(255) foreign key references [CEBOLLITA_SUB_CAMPEON].[Motor](id_motor),
motor_potencia decimal(18,6),
motor_temp_aceite decimal(18,6),
motor_temp_agua decimal(18,6),
motor_rpm decimal(18,6)
constraint [PKMEDMOTOR] Primary Key(id_medicion,id_motor)
)on [Primary]
go

create table [CEBOLLITA_SUB_CAMPEON].[Medicion_Neumatico](
id_medicion decimal(18,0) foreign key references [CEBOLLITA_SUB_CAMPEON].[Medicion](codigo_medicion),
id_neumatico nvarchar(255) foreign key references [CEBOLLITA_SUB_CAMPEON].[neumatico](neumatico_serie),
neumatico_profundidad decimal(18,6),
neumatico_presion decimal(18,6),
neumatico_temperatura decimal(18,6)
constraint [PKMEDNeumatico] Primary Key(id_medicion,id_neumatico)
)on [Primary]
go

create table [CEBOLLITA_SUB_CAMPEON].[Medicion_Freno](
id_medicion decimal(18,0) foreign key references [CEBOLLITA_SUB_CAMPEON].[Medicion](codigo_medicion),
id_freno nvarchar(255) foreign key references [CEBOLLITA_SUB_CAMPEON].[Freno](freno_serie),
freno_grosor_pastilla decimal(18,2),
freno_temperatura decimal(18,2)
constraint [PKMEDFreno] Primary Key(id_medicion,id_freno)
)on [Primary]
go

create table [CEBOLLITA_SUB_CAMPEON].[Medicion_Caja](
id_medicion decimal(18,0) foreign key references [CEBOLLITA_SUB_CAMPEON].[Medicion](codigo_medicion),
id_caja nvarchar(255) foreign key references [CEBOLLITA_SUB_CAMPEON].[Caja_de_Cambios](caja_serie),
caja_temp_aceite decimal(18,2),
caja_rpm decimal(18,2),
caja_desgaste decimal(18,2)
constraint [PKMEDCaja] Primary Key(id_medicion,id_caja)
)on [Primary]
go

create table [CEBOLLITA_SUB_CAMPEON].[Parada](
    id_parada int IDENTITY(100,1) PRIMARY KEY,
    nro_de_vuelta decimal(18,0),
    tiempo_parada decimal(18,10),
    auto_modelo nvarchar(255),
    auto_numero int,
    id_carrera int FOREIGN KEY REFERENCES [CEBOLLITA_SUB_CAMPEON].[Carrera] (id_carrera),
	constraint [AUTO_FK_PARADA] 
		Foreign key(
			auto_modelo,
			auto_numero)
		References  [CEBOLLITA_SUB_CAMPEON].[Auto] (
			auto_modelo,
			auto_numero)
) on [PRIMARY]
go

create table [CEBOLLITA_SUB_CAMPEON].[Neumatico_x_Cambio](
id_neumaticoXCambio int IDENTITY(1000,100) Primary key,
neumatico_serie nvarchar(255) foreign key references [CEBOLLITA_SUB_CAMPEON].[Neumatico](Neumatico_serie),
id_cambio int
)on [Primary]
go

create table [CEBOLLITA_SUB_CAMPEON].[Cambio](
    id_cambio int IDENTITY(100,1) PRIMARY KEY,
    neumatico_x_cambio_nuevo int FOREIGN KEY REFERENCES [CEBOLLITA_SUB_CAMPEON].[Neumatico_x_Cambio](id_neumaticoXCambio),
    neumatico_x_cambio_viejo int FOREIGN KEY REFERENCES [CEBOLLITA_SUB_CAMPEON].[Neumatico_x_Cambio](id_neumaticoXCambio),
	neu_nuevo nvarchar(255),
	neu_viejo nvarchar(255),
    parada_id int FOREIGN KEY REFERENCES [CEBOLLITA_SUB_CAMPEON].[Parada] (id_parada)
) on [PRIMARY]
go

alter Table [CEBOLLITA_SUB_CAMPEON].[Neumatico_x_Cambio]
add constraint [FK_CAMBIO] foreign key(id_cambio)
references [CEBOLLITA_SUB_CAMPEON].[Cambio](id_cambio)
go



Create view CEBOLLITA_SUB_CAMPEON.pilotosPorEscuderia
AS
Select Piloto.*,esc.escuderia_nacionalidad, auto.escuderia, auto.auto_numero, auto.auto_modelo from CEBOLLITA_SUB_CAMPEON.Piloto piloto join 
	CEBOLLITA_SUB_CAMPEON.Auto auto on 
		auto.auto_piloto_apellido = piloto.piloto_apellido and 
		auto.auto_piloto_nombre = piloto.piloto_nombre
	join CEBOLLITA_SUB_CAMPEON.Escuderia esc on
		esc.escuderia_nombre = auto.escuderia	
go

Create view CEBOLLITA_SUB_CAMPEON.medicionesPorCarrera
AS
Select car.carrera_fecha,car.carrera_total,car.carrera_cantvueltas,cir.circuito_nombre,auto.escuderia,med.* 
	from CEBOLLITA_SUB_CAMPEON.Medicion med 
	join CEBOLLITA_SUB_CAMPEON.Carrera car on 
		med.id_carrera = car.id_carrera
	join CEBOLLITA_SUB_CAMPEON.Auto auto on
		med.auto_modelo = auto.auto_modelo and
		med.auto_numero = auto.auto_numero
	join CEBOLLITA_SUB_CAMPEON.Circuito cir on
		cir.circuito_codigo = car.circuito_codigo
go

Create view CEBOLLITA_SUB_CAMPEON.neumaticosConTipo
AS
select neu.*,ISNULL(tn.detalle,'No fue cambiado') as tipo_neumatico from CEBOLLITA_SUB_CAMPEON.Neumatico neu
	left join CEBOLLITA_SUB_CAMPEON.Tipo_Neumatico tn on
		tn.id_tipo_neumatico = neu.neumatico_tipo
	group by neu.neumatico_serie,neu.neumatico_posicion,tn.detalle,neu.neumatico_tipo
go

Create view CEBOLLITA_SUB_CAMPEON.cambiosDeNeumaticosEnCadaParada
AS
select par.*,cambio.neumatico_x_cambio_nuevo,cambio.neumatico_x_cambio_viejo 
	from CEBOLLITA_SUB_CAMPEON.Parada par 
		join CEBOLLITA_SUB_CAMPEON.Cambio cambio on
			par.id_parada = cambio.parada_id
go


create function [CEBOLLITA_SUB_CAMPEON].obtener_id_tipo_neu(@param nvarchar(255))
returns int
as
begin
declare @id int
	set @id= (select top 1 id_tipo_neumatico from CEBOLLITA_SUB_CAMPEON.Tipo_Neumatico
				where detalle=@param)
	return @id
end
go

create function [CEBOLLITA_SUB_CAMPEON].obtener_id_Tipo_Incidente(@param1 nvarchar(255))
returns int
as
begin
	declare @id int
	set @id= (select top 1 id_tipo from CEBOLLITA_SUB_CAMPEON.Incidente_Tipo 
				where tipo=@param1)
	return @id
end
GO


create function [CEBOLLITA_SUB_CAMPEON].obtener_id_Incidente(@param1 int,@param2 nvarchar(255),@param3 decimal(18,2))
returns int
as
begin
declare @id int
set @id= (select top 1 id_incidente from CEBOLLITA_SUB_CAMPEON.Incidente
			where sector = @param1 and
			tiempo=@param3 and
			bandera=@param2)
return @id
end
go

create function [CEBOLLITA_SUB_CAMPEON].obtener_id_de_parada(@nroDeVuelta decimal(18,0),@auto_numero int,@auto_modelo nvarchar(255),@id_carrera int)
returns int
as
begin
	declare @id int
	set @id= (select top 1 id_parada from CEBOLLITA_SUB_CAMPEON.Parada
				where auto_numero = @auto_numero 
                AND auto_modelo = @auto_modelo 
                AND nro_de_vuelta = @nroDeVuelta
                AND id_carrera = @id_carrera)
	return @id
end
GO

create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Escuderias
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.Escuderia(
escuderia_nombre,
escuderia_nacionalidad
) select
ESCUDERIA_NOMBRE,
ESCUDERIA_NACIONALIDAD
from gd_esquema.Maestra
group by ESCUDERIA_NOMBRE,ESCUDERIA_NACIONALIDAD 
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Escuderias
go



create Procedure [CEBOLLITA_SUB_CAMPEON].Crear_Pilotos
as
begin transaction
Insert into CEBOLLITA_SUB_CAMPEON.Piloto(
piloto_nombre,
piloto_apellido,
piloto_nacionalidad,
piloto_fecha_nac
)
select
PILOTO_NOMBRE,
PILOTO_APELLIDO,
PILOTO_NACIONALIDAD,
PILOTO_FECHA_NACIMIENTO
from gd_esquema.Maestra
group by 
PILOTO_NOMBRE,
PILOTO_APELLIDO,
PILOTO_NACIONALIDAD,
PILOTO_FECHA_NACIMIENTO
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Pilotos
go


Create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Autos
as
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.[Auto](
		auto_modelo,
		auto_numero,
		auto_piloto_nombre,
		auto_piloto_apellido,
		escuderia
	) 
	select
		AUTO_MODELO,
		AUTO_NUMERO,
		PILOTO_NOMBRE,
		PILOTO_APELLIDO,
		ESCUDERIA_NOMBRE
	from gd_esquema.Maestra
	group by 
		AUTO_MODELO,
		AUTO_NUMERO,
		PILOTO_NOMBRE,
		PILOTO_APELLIDO,
		ESCUDERIA_NOMBRE
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Autos
go

create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Circuitos
as
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.Circuito(
		circuito_codigo,
		circuito_pais,
		circuito_nombre
	)
	Select
		CIRCUITO_CODIGO,
		CIRCUITO_PAIS,
		CIRCUITO_NOMBRE
	from gd_esquema.Maestra
	group by 
		CIRCUITO_CODIGO,
		CIRCUITO_PAIS,
		CIRCUITO_NOMBRE
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Circuitos
go

Create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Carreras
as
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.Carrera(
		id_carrera,
		circuito_codigo,
		carrera_clima,
		carrera_cantvueltas,
		carrera_total,
		carrera_fecha
	) 
	select
		CODIGO_CARRERA,
		CIRCUITO_CODIGO,
		CARRERA_CLIMA,
		CARRERA_CANT_VUELTAS,
		CARRERA_TOTAL_CARRERA,
		CARRERA_FECHA
	from gd_esquema.Maestra
	group by
		CODIGO_CARRERA,
		CIRCUITO_CODIGO,
		CARRERA_CLIMA,
		CARRERA_CANT_VUELTAS,
		CARRERA_TOTAL_CARRERA,
		CARRERA_FECHA
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Carreras
go


create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Sectores
as
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.Sector(
		id_circuito,
		codigo_sector,
		sector_tipo,
		sector_distancia
	)
	select
		CIRCUITO_CODIGO,
		CODIGO_SECTOR,
		SECTO_TIPO,
		SECTOR_DISTANCIA
	from gd_esquema.Maestra
	group by 
		CIRCUITO_CODIGO,
		CODIGO_SECTOR,
		SECTO_TIPO,
		SECTOR_DISTANCIA
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Sectores
go


Create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Incidentes
as
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.Incidente(
		sector,
		bandera,
		tiempo
	)
	Select
		CODIGO_SECTOR,
		INCIDENTE_BANDERA,
		INCIDENTE_TIEMPO
	from gd_esquema.Maestra
	where 
		INCIDENTE_BANDERA  is not null 
		and INCIDENTE_TIEMPO is not null
	group by
		CODIGO_SECTOR,
		INCIDENTE_BANDERA,
		INCIDENTE_TIEMPO
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Incidentes
go

create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Tipo_Incidentes
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.Incidente_Tipo(
	tipo
)
select 
	INCIDENTE_TIPO
from gd_esquema.Maestra
where INCIDENTE_TIPO is not null
group by INCIDENTE_TIPO
--begin transaction
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Tipo_Incidentes
go




Create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Incidente_Auto
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.Incidente_Auto(
	auto_incidente_codigo,
	auto_incidente_nuro,
	incidente_num_vuelta,
	id_incidente,
	incidente_tipo
)
	Select
		AUTO_MODELO,
		AUTO_NUMERO,
		INCIDENTE_NUMERO_VUELTA,
		[CEBOLLITA_SUB_CAMPEON].obtener_id_Incidente(CODIGO_SECTOR,INCIDENTE_BANDERA,INCIDENTE_TIEMPO),
		[CEBOLLITA_SUB_CAMPEON].obtener_id_Tipo_Incidente(INCIDENTE_TIPO)
	from gd_esquema.Maestra
	where 
		INCIDENTE_BANDERA  is not null 
		and INCIDENTE_TIEMPO is not null
	group by
		INCIDENTE_TIPO,
		CODIGO_SECTOR,
		INCIDENTE_BANDERA,
		INCIDENTE_TIEMPO,
		INCIDENTE_NUMERO_VUELTA,
		AUTO_MODELO,
		AUTO_NUMERO
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Incidente_Auto
go

create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Motores
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.Motor(
	id_motor,
	modelo_motor
)
select 
	TELE_MOTOR_NRO_SERIE,
	TELE_MOTOR_MODELO
FROM gd_esquema.Maestra 
where 
	TELE_MOTOR_NRO_SERIE is not null
GROUP BY 
	TELE_MOTOR_NRO_SERIE,
	TELE_MOTOR_MODELO
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Motores
go

create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Frenos 
as
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.Freno(
	freno_serie,
	tamanio_disco,
	freno_posicion
	)
	(select 
		TELE_FRENO1_NRO_SERIE AS SERIE,
		TELE_FRENO1_TAMANIO_DISCO AS DISCO,
		TELE_FRENO1_POSICION as POSICION
	from gd_esquema.Maestra
	where TELE_FRENO1_NRO_SERIE IS NOT NULL
	group by 
		TELE_FRENO1_NRO_SERIE,
		TELE_FRENO1_TAMANIO_DISCO,
		TELE_FRENO1_POSICION
	UNION
		select 
		TELE_FRENO2_NRO_SERIE AS SERIE,
		TELE_FRENO2_TAMANIO_DISCO AS DISCO,
		TELE_FRENO2_POSICION as POSICION
	from gd_esquema.Maestra
	where TELE_FRENO2_NRO_SERIE IS NOT NULL
	group by 
		TELE_FRENO2_NRO_SERIE,
		TELE_FRENO2_TAMANIO_DISCO,
		TELE_FRENO2_POSICION
	UNION
	select 
		TELE_FRENO3_NRO_SERIE AS SERIE,
		TELE_FRENO3_TAMANIO_DISCO AS DISCO,
		TELE_FRENO3_POSICION as POSICION
	from gd_esquema.Maestra
	where TELE_FRENO3_NRO_SERIE IS NOT NULL
	group by 
		TELE_FRENO3_NRO_SERIE,
		TELE_FRENO3_TAMANIO_DISCO,
		TELE_FRENO3_POSICION
	UNION
	select 
		TELE_FRENO4_NRO_SERIE AS SERIE,
		TELE_FRENO4_TAMANIO_DISCO AS DISCO,
		TELE_FRENO4_POSICION as POSICION
	from gd_esquema.Maestra
	where TELE_FRENO4_NRO_SERIE IS NOT NULL
	group by 
		TELE_FRENO4_NRO_SERIE,
		TELE_FRENO4_TAMANIO_DISCO,
		TELE_FRENO4_POSICION
	)
commit
go

EXEC [CEBOLLITA_SUB_CAMPEON].Crear_Frenos
go

create Procedure [CEBOLLITA_SUB_CAMPEON].Crear_Cajas_de_Cambio
as
begin transaction 
	insert into CEBOLLITA_SUB_CAMPEON.Caja_de_Cambios(
		caja_serie,
		modelo_caja
	)
	select 
	TELE_CAJA_NRO_SERIE,
	TELE_CAJA_MODELO
	from gd_esquema.Maestra
	WHERE TELE_CAJA_NRO_SERIE is not null
	group by
		TELE_CAJA_NRO_SERIE,
		TELE_CAJA_MODELO
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Cajas_de_Cambio
go


CREATE PROCEDURE [CEBOLLITA_SUB_CAMPEON].Crear_TipoNeumatico
AS
BEGIN TRANSACTION
INSERT INTO CEBOLLITA_SUB_CAMPEON.Tipo_Neumatico(
    detalle
) (SELECT DISTINCT
    NEUMATICO1_TIPO_NUEVO
FROM gd_esquema.Maestra
WHERE NEUMATICO1_TIPO_NUEVO is not null
union 
SELECT DISTINCT
    NEUMATICO1_TIPO_VIEJO
FROM gd_esquema.Maestra
WHERE NEUMATICO1_TIPO_VIEJO is not null
)
COMMIT
GO

exec [CEBOLLITA_SUB_CAMPEON].Crear_TipoNeumatico
GO



create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Neumaticos
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.Neumatico(
	neumatico_serie,
	neumatico_posicion,
	neumatico_tipo
)
(
select
TELE_NEUMATICO1_NRO_SERIE as serie,
TELE_NEUMATICO1_POSICION,
CEBOLLITA_SUB_CAMPEON.obtener_id_tipo_neu(NEUMATICO1_TIPO_VIEJO)AS tipo
from gd_esquema.Maestra
where TELE_NEUMATICO1_NRO_SERIE is not null
group by
TELE_NEUMATICO1_NRO_SERIE,
TELE_NEUMATICO1_POSICION,
CEBOLLITA_SUB_CAMPEON.obtener_id_tipo_neu(NEUMATICO1_TIPO_VIEJO)
union 
select
TELE_NEUMATICO2_NRO_SERIE as serie,
TELE_NEUMATICO2_POSICION,
CEBOLLITA_SUB_CAMPEON.obtener_id_tipo_neu(NEUMATICO2_TIPO_VIEJO)
from gd_esquema.Maestra
where TELE_NEUMATICO2_NRO_SERIE is not null
group by
TELE_NEUMATICO2_NRO_SERIE,
TELE_NEUMATICO2_POSICION,
CEBOLLITA_SUB_CAMPEON.obtener_id_tipo_neu(NEUMATICO2_TIPO_VIEJO)
union
select
TELE_NEUMATICO3_NRO_SERIE as serie,
TELE_NEUMATICO3_POSICION,
CEBOLLITA_SUB_CAMPEON.obtener_id_tipo_neu(NEUMATICO3_TIPO_VIEJO)
from gd_esquema.Maestra
where TELE_NEUMATICO3_NRO_SERIE is not null
group by
TELE_NEUMATICO3_NRO_SERIE,
TELE_NEUMATICO3_POSICION,
CEBOLLITA_SUB_CAMPEON.obtener_id_tipo_neu(NEUMATICO3_TIPO_VIEJO)
union 
select
TELE_NEUMATICO4_NRO_SERIE as serie,
TELE_NEUMATICO4_POSICION,
CEBOLLITA_SUB_CAMPEON.obtener_id_tipo_neu(NEUMATICO4_TIPO_VIEJO)
from gd_esquema.Maestra
where TELE_NEUMATICO4_NRO_SERIE is not null
group by
TELE_NEUMATICO4_NRO_SERIE,
TELE_NEUMATICO4_POSICION,
CEBOLLITA_SUB_CAMPEON.obtener_id_tipo_neu(NEUMATICO4_TIPO_VIEJO)
) 
commit
go


exec [CEBOLLITA_SUB_CAMPEON].Crear_Neumaticos
go

Create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Mediciones
as
begin transaction
insert into CEBOLLITA_SUB_CAMPEON.Medicion(
auto_modelo,
auto_numero,
id_carrera,
codigo_sector,
codigo_medicion,
med_combustible,
med_distancia_carrera,
med_distancia_vuelta,
med_nro_vuelta,
med_posicion,
med_tiempo_vuelta,
med_velocidad
)
(select distinct
	AUTO_MODELO,
	AUTO_NUMERO,
	CODIGO_CARRERA,
	CODIGO_SECTOR,
	TELE_AUTO_CODIGO,
	TELE_AUTO_COMBUSTIBLE,
	TELE_AUTO_DISTANCIA_CARRERA,
	TELE_AUTO_DISTANCIA_VUELTA,
	TELE_AUTO_NUMERO_VUELTA,
	TELE_AUTO_POSICION,
	TELE_AUTO_TIEMPO_VUELTA,
	TELE_AUTO_VELOCIDAD
from gd_esquema.Maestra
WHERE 
	TELE_AUTO_CODIGO IS NOT NULL
GROUP BY 
	AUTO_MODELO,
	AUTO_NUMERO,
	CODIGO_CARRERA,
	CODIGO_SECTOR,
	TELE_AUTO_CODIGO,
	TELE_AUTO_COMBUSTIBLE,
	TELE_AUTO_DISTANCIA_CARRERA,
	TELE_AUTO_DISTANCIA_VUELTA,
	TELE_AUTO_NUMERO_VUELTA,
	TELE_AUTO_POSICION,
	TELE_AUTO_TIEMPO_VUELTA,
	TELE_AUTO_VELOCIDAD )order by 5
commit
go


EXEC [CEBOLLITA_SUB_CAMPEON].Crear_Mediciones
go

create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Mediciones_Caja
as
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.Medicion_Caja(
		id_caja,
		id_medicion,
		caja_desgaste,
		caja_rpm,
		caja_temp_aceite
		)
	select
		TELE_CAJA_NRO_SERIE,
		TELE_AUTO_CODIGO,
		TELE_CAJA_DESGASTE,
		TELE_CAJA_RPM,
		TELE_CAJA_TEMP_ACEITE
	from gd_esquema.Maestra
	where TELE_AUTO_CODIGO is not null
	group by
		TELE_CAJA_NRO_SERIE,
		TELE_AUTO_CODIGO,
		TELE_CAJA_DESGASTE,
		TELE_CAJA_RPM,
		TELE_CAJA_TEMP_ACEITE
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Mediciones_Caja
go

create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Mediciones_Motor
as
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.Medicion_Motor(
		id_medicion,
		id_motor,
		motor_potencia,
		motor_temp_aceite,
		motor_temp_agua,
		motor_rpm
	)
	select
		TELE_AUTO_CODIGO,
		TELE_MOTOR_NRO_SERIE,
		TELE_MOTOR_POTENCIA,
		TELE_MOTOR_TEMP_ACEITE,
		TELE_MOTOR_TEMP_AGUA,
		TELE_MOTOR_RPM
	from gd_esquema.Maestra
	where TELE_AUTO_CODIGO is not null
	group by
		TELE_AUTO_CODIGO,
		TELE_MOTOR_NRO_SERIE,
		TELE_MOTOR_POTENCIA,
		TELE_MOTOR_TEMP_ACEITE,
		TELE_MOTOR_TEMP_AGUA,
		TELE_MOTOR_RPM
commit
go

Exec [CEBOLLITA_SUB_CAMPEON].Crear_Mediciones_Motor
go

create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Mediciones_Neumatico
as
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.Medicion_Neumatico(
		id_medicion,
		id_neumatico,
		neumatico_presion,
		neumatico_profundidad,
		neumatico_temperatura
	)
		(select 
			TELE_AUTO_CODIGO as codigo_medicion,
			TELE_NEUMATICO1_NRO_SERIE as neumatico_serie,
			TELE_NEUMATICO1_PRESION as presion,
			TELE_NEUMATICO1_PROFUNDIDAD	as profundidad,
			TELE_NEUMATICO1_TEMPERATURA as temperatura
		from gd_esquema.Maestra
		where TELE_AUTO_CODIGO is not null
		group by 
			TELE_AUTO_CODIGO,
			TELE_NEUMATICO1_NRO_SERIE,
			TELE_NEUMATICO1_PRESION,
			TELE_NEUMATICO1_PROFUNDIDAD,
			TELE_NEUMATICO1_TEMPERATURA
		union
		select
			TELE_AUTO_CODIGO as codigo_medicion,
			TELE_NEUMATICO2_NRO_SERIE as neumatico_serie,
			TELE_NEUMATICO2_PRESION as presion,
			TELE_NEUMATICO2_PROFUNDIDAD	as profundidad,
			TELE_NEUMATICO2_TEMPERATURA as temperatura
		from gd_esquema.Maestra
		where TELE_AUTO_CODIGO is not null
		group by 
			TELE_AUTO_CODIGO,
			TELE_NEUMATICO2_NRO_SERIE,
			TELE_NEUMATICO2_PRESION,
			TELE_NEUMATICO2_PROFUNDIDAD,
			TELE_NEUMATICO2_TEMPERATURA
		union
		select
			TELE_AUTO_CODIGO as codigo_medicion,
			TELE_NEUMATICO3_NRO_SERIE as neumatico_serie,
			TELE_NEUMATICO3_PRESION as presion,
			TELE_NEUMATICO3_PROFUNDIDAD	as profundidad,
			TELE_NEUMATICO3_TEMPERATURA as temperatura
		from gd_esquema.Maestra
		where TELE_AUTO_CODIGO is not null
		group by 
			TELE_AUTO_CODIGO,
			TELE_NEUMATICO3_NRO_SERIE,
			TELE_NEUMATICO3_PRESION,
			TELE_NEUMATICO3_PROFUNDIDAD,
			TELE_NEUMATICO3_TEMPERATURA
		union
		select
			TELE_AUTO_CODIGO as codigo_medicion,
			TELE_NEUMATICO4_NRO_SERIE as neumatico_serie,
			TELE_NEUMATICO4_PRESION as presion,
			TELE_NEUMATICO4_PROFUNDIDAD	as profundidad,
			TELE_NEUMATICO4_TEMPERATURA as temperatura
		from gd_esquema.Maestra
		where TELE_AUTO_CODIGO is not null
		group by 
			TELE_AUTO_CODIGO,
			TELE_NEUMATICO4_NRO_SERIE,
			TELE_NEUMATICO4_PRESION,
			TELE_NEUMATICO4_PROFUNDIDAD,
			TELE_NEUMATICO4_TEMPERATURA
		)
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Mediciones_Neumatico
go

create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Mediciones_Freno
as
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.Medicion_Freno(
		id_medicion,
		id_freno,
		freno_grosor_pastilla,
		freno_temperatura
	)
	(select
		TELE_AUTO_CODIGO as codigo,
		TELE_FRENO1_NRO_SERIE as freno,
		TELE_FRENO1_GROSOR_PASTILLA as pastilla,
		TELE_FRENO1_TEMPERATURA as temperatura
	from gd_esquema.Maestra
	where TELE_AUTO_CODIGO is not null
	group by 
		TELE_AUTO_CODIGO,
		TELE_FRENO1_NRO_SERIE,
		TELE_FRENO1_GROSOR_PASTILLA,
		TELE_FRENO1_TEMPERATURA
	union 
	select
		TELE_AUTO_CODIGO as codigo,
		TELE_FRENO2_NRO_SERIE as freno,
		TELE_FRENO2_GROSOR_PASTILLA as pastilla,
		TELE_FRENO2_TEMPERATURA as temperatura
	from gd_esquema.Maestra
	where TELE_AUTO_CODIGO is not null
	group by 
		TELE_AUTO_CODIGO,
		TELE_FRENO2_NRO_SERIE,
		TELE_FRENO2_GROSOR_PASTILLA,
		TELE_FRENO2_TEMPERATURA
	union 
		select
		TELE_AUTO_CODIGO as codigo,
		TELE_FRENO3_NRO_SERIE as freno,
		TELE_FRENO3_GROSOR_PASTILLA as pastilla,
		TELE_FRENO3_TEMPERATURA as temperatura
	from gd_esquema.Maestra
	where TELE_AUTO_CODIGO is not null
	group by 
		TELE_AUTO_CODIGO,
		TELE_FRENO3_NRO_SERIE,
		TELE_FRENO3_GROSOR_PASTILLA,
		TELE_FRENO3_TEMPERATURA
	union 
		select
		TELE_AUTO_CODIGO as codigo,
		TELE_FRENO4_NRO_SERIE as freno,
		TELE_FRENO4_GROSOR_PASTILLA as pastilla,
		TELE_FRENO4_TEMPERATURA as temperatura
	from gd_esquema.Maestra
	where TELE_AUTO_CODIGO is not null
	group by 
		TELE_AUTO_CODIGO,
		TELE_FRENO4_NRO_SERIE,
		TELE_FRENO4_GROSOR_PASTILLA,
		TELE_FRENO4_TEMPERATURA)
commit
go

exec [CEBOLLITA_SUB_CAMPEON].Crear_Mediciones_Freno
go


CREATE PROCEDURE [CEBOLLITA_SUB_CAMPEON].Crear_Parada
AS
BEGIN TRANSACTION
INSERT INTO CEBOLLITA_SUB_CAMPEON.Parada(
    nro_de_vuelta,
    tiempo_parada,
    auto_modelo,
    auto_numero,
    id_carrera
) SELECT distinct
	PARADA_BOX_VUELTA,
	PARADA_BOX_TIEMPO,
	AUTO_MODELO,
	AUTO_NUMERO,
	CODIGO_CARRERA
FROM gd_esquema.Maestra
where PARADA_BOX_VUELTA is not null
COMMIT
go


Create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Neumaticos_X_Cambio_Nuevos
as
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.Neumatico_x_Cambio(
		id_cambio,
		neumatico_serie
	)select id_cambio, neu_nuevo from CEBOLLITA_SUB_CAMPEON.Cambio
commit
go

Create procedure [CEBOLLITA_SUB_CAMPEON].Crear_Neumaticos_X_Cambio_Viejos
as
begin transaction
	insert into CEBOLLITA_SUB_CAMPEON.Neumatico_x_Cambio(
		id_cambio,
		neumatico_serie
	)select id_cambio, neu_viejo from CEBOLLITA_SUB_CAMPEON.Cambio
commit
go


create procedure [CEBOLLITA_SUB_CAMPEON].Cargar_Neu_X_cambioEnCambio
as
begin transaction
update CEBOLLITA_SUB_CAMPEON.Cambio
set neumatico_x_cambio_nuevo= n.id_neumaticoXCambio
from CEBOLLITA_SUB_CAMPEON.Cambio c 
join CEBOLLITA_SUB_CAMPEON.Neumatico_x_Cambio n on
c.id_cambio= n.id_cambio
and c.neu_nuevo=n.neumatico_serie

update CEBOLLITA_SUB_CAMPEON.Cambio
set neumatico_x_cambio_viejo= n.id_neumaticoXCambio
from CEBOLLITA_SUB_CAMPEON.Cambio c 
join CEBOLLITA_SUB_CAMPEON.Neumatico_x_Cambio n on
c.id_cambio= n.id_cambio
and c.neu_viejo=n.neumatico_serie

alter table CEBOLLITA_SUB_CAMPEON.Cambio
drop column neu_nuevo, neu_viejo
commit
go


create trigger [CEBOLLITA_SUB_CAMPEON].Actualizar_Id_cambio_en_neu_x_cambio
on [CEBOLLITA_SUB_CAMPEON].Cambio
after insert
as
begin transaction	
	update [CEBOLLITA_SUB_CAMPEON].Neumatico_x_Cambio 
	set id_Cambio = (select top 1 id_cambio from inserted where id_neumaticoXCambio = neumatico_x_cambio_nuevo or id_neumaticoXCambio = neumatico_x_cambio_viejo )
	where id_neumaticoXCambio in (select neumatico_x_cambio_nuevo from inserted union select neumatico_x_cambio_viejo from inserted)
commit
go

CREATE PROCEDURE [CEBOLLITA_SUB_CAMPEON].Crear_Cambio
AS
BEGIN TRANSACTION
INSERT INTO CEBOLLITA_SUB_CAMPEON.Cambio(
    neu_nuevo,
	neu_viejo,
    parada_id 
) SELECT 
	NEUMATICO1_NRO_SERIE_NUEVO ,
	NEUMATICO1_NRO_SERIE_VIEJO,
	[CEBOLLITA_SUB_CAMPEON].obtener_id_de_parada(PARADA_BOX_VUELTA,AUTO_NUMERO,AUTO_MODELO,CODIGO_CARRERA)
FROM gd_esquema.Maestra
WHERE NEUMATICO1_NRO_SERIE_NUEVO is not NULL
and NEUMATICO1_NRO_SERIE_VIEJO is not NULL
UNION
SELECT 
	NEUMATICO2_NRO_SERIE_NUEVO,
	NEUMATICO2_NRO_SERIE_VIEJO,
	[CEBOLLITA_SUB_CAMPEON].obtener_id_de_parada(PARADA_BOX_VUELTA,AUTO_NUMERO,AUTO_MODELO,CODIGO_CARRERA)
FROM gd_esquema.Maestra
WHERE NEUMATICO2_NRO_SERIE_NUEVO is not NULL
and NEUMATICO2_NRO_SERIE_VIEJO is not NULL
UNION
SELECT 
	NEUMATICO3_NRO_SERIE_NUEVO,
	NEUMATICO3_NRO_SERIE_VIEJO,
	[CEBOLLITA_SUB_CAMPEON].obtener_id_de_parada(PARADA_BOX_VUELTA,AUTO_NUMERO,AUTO_MODELO,CODIGO_CARRERA)
FROM gd_esquema.Maestra
WHERE NEUMATICO3_NRO_SERIE_NUEVO is not NULL
and NEUMATICO3_NRO_SERIE_VIEJO is not NULL
UNION
SELECT 
	NEUMATICO4_NRO_SERIE_NUEVO,
	NEUMATICO4_NRO_SERIE_VIEJO,
	[CEBOLLITA_SUB_CAMPEON].obtener_id_de_parada(PARADA_BOX_VUELTA,AUTO_NUMERO,AUTO_MODELO,CODIGO_CARRERA)
FROM gd_esquema.Maestra
WHERE NEUMATICO4_NRO_SERIE_NUEVO is not NULL
and NEUMATICO4_NRO_SERIE_VIEJO is not NULL
COMMIT
GO


exec [CEBOLLITA_SUB_CAMPEON].Crear_Parada
go
exec [CEBOLLITA_SUB_CAMPEON].Crear_Cambio
go
exec [CEBOLLITA_SUB_CAMPEON].Crear_Neumaticos_X_Cambio_Nuevos
go
exec [CEBOLLITA_SUB_CAMPEON].Crear_Neumaticos_X_Cambio_Viejos
go
exec [CEBOLLITA_SUB_CAMPEON].Cargar_Neu_X_cambioEnCambio
go
--commit
go

COMMIT
GO