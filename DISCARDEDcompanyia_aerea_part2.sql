/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS: Desenvolupament d'aplicacions webs (DAW) 1A
    Mòdul: 0484 Bases de dades. 
    AUTORS: Ricardo Martín Díaz, Pau Bosch Pérez
    DATA: 09/01/2025
****************************************************** */

-- ------------------------------------------------------
-- Base de dades de vols
-- ------------------------------------------------------

-- ------------------------------------------------------
--  Eliminació de taules
-- ------------------------------------------------------
drop table if exists volar;
drop table if exists vol;
drop table if exists pilot;
drop table if exists hostessa;
drop table if exists personal;
drop table if exists passatger;
drop table if exists Mostrador;
drop table if exists aeroport;
drop table if exists avio;
drop table if exists companyia;

-- ------------------------------------------------------
--  Creació de taula companyia
-- ------------------------------------------------------

CREATE TABLE companyia (	
	nom Varchar(40) not null, 
	IATA CHAR(6) not null, 
	CODE3 CHAR(6), 
	ICAO CHAR(6), 
	pais Varchar(40) NOT NULL, 
	filial_de Varchar(40)
) CHARACTER SET utf8mb4;

alter table companyia
add constraint pk_companyia primary key (nom);
-- ------------------------------------------------------
--  Creació de la taula  hostessa
-- ------------------------------------------------------

CREATE TABLE hostessa ( 
	num_empleat int
) CHARACTER SET utf8mb4;

alter table hostessa
add constraint pk_hostessa primary key (num_empleat);

alter table hostessa
add constraint fk_hostessa_personal foreign key (num_empleat)
references personal (num_empleat)
ON DELETE CASCADE
ON UPDATE CASCADE;


-- ------------------------------------------------------
--  Creació de la taula  avio
-- ------------------------------------------------------

CREATE TABLE avio (	
	num_serie CHAR(30), 
	tipus Varchar(10) not null, 
	fabricant Varchar(20) not null, 
	any_fabricacio year, 
	companyia Varchar(40) not null
)  CHARACTER SET utf8mb4;

alter table avio
add constraint pk_avio primary key (num_serie);

alter table avio
add constraint fk_avio_companyia foreign key (companyia)
references companyia (nom)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table avio
add constraint ch_avio_tipus check (tipus IN ('COM-PAS', 'JET', 'CARGO'));

-- ------------------------------------------------------
--  Creació de la taula  aeroport
-- ------------------------------------------------------
CREATE TABLE aeroport (
	codi CHAR(4), 
	pais Varchar(40) not null, 
	ciutat Varchar(40) not null, 
	IATA CHAR(4), 
	nom Varchar(55) not null, 
	any_construccio Year
) CHARACTER SET utf8mb4;

alter table aeroport
add constraint pk_aeroport primary key (codi);

alter table aeroport
add constraint uq_iata unique (IATA);

-- ------------------------------------------------------
--  Creació de la taula  Mostrador
-- ------------------------------------------------------

CREATE TABLE Mostrador (
	numero smallint, 
	codi_aeroport CHAR(4)
) CHARACTER SET utf8mb4;

alter table Mostrador
add constraint pk_Mostrador primary key (numero, codi_aeroport);

alter table Mostrador
add constraint fk_Mostrador_aeroport foreign key (codi_aeroport)
references aeroport (codi)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- ------------------------------------------------------
--  Creació de la taula  personal
-- ------------------------------------------------------

CREATE TABLE personal (
    num_empleat INT,
    nom VARCHAR(25) NOT NULL,
    cognom VARCHAR(35) NOT NULL,
    passaport CHAR(20) NOT NULL,
    sou FLOAT NOT NULL
)  CHARACTER SET utf8mb4;

alter table personal
add constraint pk_personal primary key (num_empleat);

alter table personal
add constraint uq_passaport unique (passaport);

alter table personal
add constraint ch_sou check (sou >= 20000);

-- ------------------------------------------------------
--  Creació de la taula  vol
-- ------------------------------------------------------

CREATE TABLE vol (
	codi CHAR(9), 
	aeroport_desti CHAR(4) not null, 
	data DATE not null, 
	durada smallint not null, 
	aeroport_origen CHAR(4) not null, 
	avio CHAR(30) not null, 
	hostessa int not null, 
    pilot int not null, 
	descripcio Varchar(30) not null
) CHARACTER SET utf8mb4;

alter table vol
add constraint pk_vol primary key (codi);

alter table vol
add constraint fk_vol_aeroport_origen foreign key (aeroport_origen)
references aeroport (codi)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table vol
add constraint fk_vol_aeroport_desti foreign key (aeroport_desti)
references aeroport (codi)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table vol
add constraint fk_vol_avio foreign key (avio)
references avio (num_serie)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table vol
add constraint fk_vol_hostessa foreign key (hostessa)
references hostessa (num_empleat)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table vol
add constraint fk_vol_pilot foreign key (pilot)
references pilot (num_empleat)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table vol
add constraint ch_vol_descripcio check (descripcio IN ('ON-TIME', 'DELAYED', 'UNKNOWN'));

alter table vol
add constraint ch_vol_durada check (durada >= 10, durada <= 1200);

-- ------------------------------------------------------
--  Creació de la taula  passatger
-- ------------------------------------------------------

CREATE TABLE passatger (
	passaport CHAR(20), 
	nom Varchar(30) not null, 
	cognom Varchar(50), 
	adreca Varchar(70), 
	telefon Varchar(9), 
	email Varchar(40), 
	data_naix DATE, 
	genere CHAR(1)
)  CHARACTER SET utf8mb4;

alter table passatger
add constraint pk_passatger primary key (passaport);

-- ------------------------------------------------------
--  Creació de la taula  pilot
-- ------------------------------------------------------

CREATE TABLE pilot (
	num_empleat int, 
	hores_vol smallint
)CHARACTER SET utf8mb4;

alter table pilot
add constraint pk_pilot primary key (num_empleat);

alter table pilot
add constraint fk_pilot_personal foreign key (num_empleat)
references personal (num_empleat)
ON DELETE CASCADE
ON UPDATE CASCADE;

alter table pilot
add constraint ch_pilot_hores_vol check (hores_vol >= 400);


-- ------------------------------------------------------
--  Creació de la taula  volar
-- ------------------------------------------------------  
CREATE TABLE volar(
	passatger char(20),
	vol char(9),
	seient tinyint
)CHARACTER SET utf8mb4;

alter table volar
add constraint pk_volar primary key (passatger, vol);

alter table volar
add constraint fk_volar_passatger foreign key (passatger)
references passatger (passaport)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table volar
add constraint fk_volar_vol foreign key (vol)
references vol (codi)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table volar
add constraint ch_seient check (seient >= 1, seient <= 200);

alter table volar
add constraint uq_seient unique (seient);











El seient és un número entre 1 i 200.
alter table volar
add constraint ck_seient check (seient > 0 and seient <= 200);

- El número de passaport del personal no es pot repetir.
alter table personal
add constraint uni_passaport unique (passaport);

- El tipus d’avió pot valer només COM-PAS, JET, o CARGO.
alter table vol
add constraint ck_tipus_avio check (avio='COM-PAS' or avio='JET' or avio='CARGO');

- La descripció del vol pot valer només ON-TIME, DELAYED, o UNKNOWN
alter table vol
add constraint ck_vol_desc check (descripcio='ON-TIME' or descripcio='DELAYED' or descripcio='UNKNOWN');

- Per ser pilot s’han de tenir com a mínim 400 hores de vol.
alter table pilot
add constraint ck_hores_vol check (hores_vol >= 400);

- En un vol un seient no pot estar ocupat per més d’una persona.
alter table volar
add constraint uni_seient unique (seient);

- La durada dels vols ha de ser un valor entre 10 i 1200 (és a dir, entre 10 minuts i 20
hores)
alter table vol
add constraint ck_durada check (durada <= 1200 and durada >= 10);

- El sou no pot ser negatiu. A més el sou mínim ha de ser de 20.000 dolars.
alter table personal
add constraint ck_sou check (sou >= 20000);

- El codi IATA dels aeroports no es pot repetir
alter table aeroport
add constraint uni_iata unique (IATA);
























/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS: Desenvolupament d'aplicacions webs (DAW) 1A
    Mòdul: 0484 Bases de dades. 
    AUTORS: Ricardo Martín Díaz, Pau Bosch Pérez
    DATA: 14/01/2025
****************************************************** */

-- ------------------------------------------------------
-- Base de dades de vols
-- ------------------------------------------------------


-- ------------------------------------------------------
--  Modificació de taula companyia
-- ------------------------------------------------------

alter table companyia
add constraint pk_companyia primary key (nom);

-- ------------------------------------------------------
--  Modificació de la taula  hostessa
-- ------------------------------------------------------

alter table hostessa
add constraint pk_hostessa primary key (num_empleat);

alter table hostessa
add constraint fk_hostessa_personal foreign key (num_empleat)
references personal (num_empleat)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- ------------------------------------------------------
--  Modificació de la taula  avio
-- ------------------------------------------------------

alter table avio
add constraint pk_avio primary key (num_serie);

alter table avio
add constraint fk_avio_companyia foreign key (companyia)
references companyia (nom)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table avio
add constraint ch_avio_tipus check (tipus IN ('COM-PAS', 'JET', 'CARGO'));

-- ------------------------------------------------------
--  Modificació de la taula  aeroport
-- ------------------------------------------------------

alter table aeroport
add constraint pk_aeroport primary key (codi);

alter table aeroport
add constraint uq_iata unique (IATA);

-- ------------------------------------------------------
--  Modificació de la taula  Mostrador
-- ------------------------------------------------------

alter table Mostrador
add constraint pk_Mostrador primary key (numero, codi_aeroport);

alter table Mostrador
add constraint fk_Mostrador_aeroport foreign key (codi_aeroport)
references aeroport (codi)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- ------------------------------------------------------
--  Modificació de la taula  personal
-- ------------------------------------------------------

alter table personal
add constraint pk_personal primary key (num_empleat);

alter table personal
add constraint uq_passaport unique (passaport);

alter table personal
add constraint ch_sou check (sou >= 20000);

-- ------------------------------------------------------
--  Modificació de la taula  vol
-- ------------------------------------------------------

alter table vol
add constraint pk_vol primary key (codi);

alter table vol
add constraint fk_vol_aeroport_origen foreign key (aeroport_origen)
references aeroport (codi)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table vol
add constraint fk_vol_aeroport_desti foreign key (aeroport_desti)
references aeroport (codi)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table vol
add constraint fk_vol_avio foreign key (avio)
references avio (num_serie)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table vol
add constraint fk_vol_hostessa foreign key (hostessa)
references hostessa (num_empleat)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table vol
add constraint fk_vol_pilot foreign key (pilot)
references pilot (num_empleat)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table vol
add constraint ch_vol_descripcio check (descripcio IN ('ON-TIME', 'DELAYED', 'UNKNOWN'));

alter table vol
add constraint ch_vol_durada check (durada >= 10, durada <= 1200);

-- ------------------------------------------------------
--  Modificació de la taula  passatger
-- ------------------------------------------------------

alter table passatger
add constraint pk_passatger primary key (passaport);

-- ------------------------------------------------------
--  Modificació de la taula  pilot
-- ------------------------------------------------------

alter table pilot
add constraint pk_pilot primary key (num_empleat);

alter table pilot
add constraint fk_pilot_personal foreign key (num_empleat)
references personal (num_empleat)
ON DELETE CASCADE
ON UPDATE CASCADE;

alter table pilot
add constraint ch_pilot_hores_vol check (hores_vol >= 400);

-- ------------------------------------------------------
--  Modificació de la taula  volar
-- ------------------------------------------------------  

alter table volar
add constraint pk_volar primary key (passatger, vol);

alter table volar
add constraint fk_volar_passatger foreign key (passatger)
references passatger (passaport)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table volar
add constraint fk_volar_vol foreign key (vol)
references vol (codi)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table volar
add constraint ch_seient check (seient >= 1, seient <= 200);

alter table volar
add constraint uq_vol_seient unique (seient, vol);