/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS: Desenvolupament d'aplicacions webs (DAW) 1A
    Mòdul: 0484 Bases de dades. 
    AUTORS: Ricardo Martín Díaz, Pau Bosch Pérez
    DATA: 12/12/2024
****************************************************** */


-- Creació de les taules

drop table if exists companyia;
drop table if exists avio;
drop table if exists aeroport;
drop table if exists mostrador;
drop table if exists personal;
drop table if exists hostessa;
drop table if exists pilot;
drop table if exists passatger;
drop table if exists vol;
drop table if exists volar;

create table companyia (
    nom varchar (40) not null, /* primary key */
    IATA varchar (6) not null,
    CODE3 varchar (6),
    ICAO varchar (6),
    pais varchar (40) not null,
    filial_de varchar (40) /* foreign key REFERENCES companyia(nom) */
);

create table avio (
    num_serie varchar (30) not null, /* primary key */
    tipus varchar (10) not null, /* (comercial, passatgers, transport de mercaderies) */
    fabricant varchar (20) not null,
    any_fabricacio year,
    companyia varchar (40) not null /* foreign key REFERENCES companyia(nom) */
);

create table aeroport (
    codi varchar (4) not null, /* primary key */
    pais varchar (40) not null,
    ciutat varchar (40) not null,
    IATA varchar (4),
    nom varchar (55) not null,
    any_construccio year
);

create table mostrador (
    numero smallint unsigned not null, /* primary key */
    codi_aeroport varchar (4) not null /* foreign key REFERENCES aeroport(codi) */
);

create table personal (
    num_empleat int unsigned not null,
    nom varchar (25) not null,
    cognom varchar (35) not null,
    passaport varchar (20) not null,
    sou float not null
);

create table hostessa (
    num_empleat int unsigned not null
);

create table pilot (
    hores_vol smallint unsigned,
    num_empleat int unsigned not null
);

create table passatger (
    passaport varchar (20) not null,
    nom varchar (30) not null,
    cognom varchar (50),
    adreca varchar (70),
    telefon varchar (9),
    email varchar (40),
    data_naixement date,
    genere char (1)
);

create table vol (
    codi varchar (9) not null,
    data date not null,
    durada time not null,
    descripcio varchar (15)
);

create table volar (
    passatger varchar (20) not null,
    vol varchar (9) not null,
    seient int
);