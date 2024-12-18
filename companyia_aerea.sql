/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS: Desenvolupament d'aplicacions webs (DAW) 1A
    Mòdul: 0484 Bases de dades. 
    AUTORS: Ricardo Martín Díaz, Pau Bosch Pérez
    DATA: 12/12/2024
****************************************************** */

/* Creació de la base de dades

(Preguntar a Jordi en clase si es necesario crear una base de datos previa a la creación de las tablas)

drop database if exists companyia_aeria;
create database companyia_aeria;
use companyia_aeria;
*/

-- Creació de les taules

drop table if exists companyia;
create table companyia (
    nom varchar (40) not null, -- primary key
    IATA varchar (6) not null,
    CODE3 varchar (6) not null,
    ICAO varchar (6) not null,
    pais varchar (40) not null,
    filial_de varchar (40) -- foreign key REF companyia(nom)

);

drop table if exists avio;
create table avio (
    num_serie varchar (30) not null, -- primary key
    tipus varchar (10) not null, -- (comercial, passatgers, transport de mercaderies)
    fabricant varchar (20) not null,
    any_fabricacio year,
    companyia varchar (40) not null -- foreign key REF companyia(nom)

);

drop table if exists aeroport;
create table aeroport (
    codi varchar (4) not null, -- primary key
    pais varchar (40) not null,
    ciutat varchar (40) not null,
    IATA varchar (4),
    nom varchar (55) not null,
    any_construccio year

);

drop table if exists mostrador;
create table mostrador (
    numero smallint unsigned, -- primary key (debería ser not null al ser primary key, aunque no especifique el enunciado que deba ser obligatorio?? Pau: las primary creo que nunca pueden ser null?¿? (no estoy seguro))
    codi_aeroport varchar (4) not null -- foreign key REF aeroport(codi)
);



drop table if exists personal;
create table personal (
    num_empleat int unsigned, -- al ser primary key, no debería ser not null ? (en el modelo relacional no lo pone)
    nom varchar (25) not null,
    cognom varchar (35) not null,
    passaport varchar (20) not null,
    sou float not null
);

drop table if exists hostessa;
create table hostessa (
    num_empleat int unsigned -- al ser foreign key, no debería ser not null ? (en el modelo relacional no lo pone)
);

drop table if exists pilot;
create table pilot (
    hores_vol smallint unsigned
    -- num_empleat int unsigned -- al ser foreign key, no debería ser not null ? (en el modelo relacional no lo pone)
)

drop table if exists passatger;
create table passatger(
    passaport varchar (20) not null,
    nom varchar (30) not null,
    cognom varchar (50),
    email varchar (40),
    data_naixement date,
    genere char (1)
);

drop table if exists vol;
create table vol(
    codi varchar (9) not null,
    data date not null,
    durada time not null,
    descripcio varchar (15)
);