/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS Desenvolupament d'aplicacions webs (DAW) 1A
    Mòdul: 0484 Bases de dades. 
    AUTORS: Ricardo Martín Díaz, Pau Bosch Pérez
    DATA: 12/12/2024
****************************************************** */

-- Creació de les taules
drop table if exists companyia;
create table companyia (
  nom varchar (40) not null primary key,
  IATA varchar (6) not null,
  CODE3 varchar (6) not null,
  ICA0 varchar (6) not null,
  pais varchar (40) not null,
  filial_de varchar (40)

);




drop table if exists personal;
create table personal (
    num_empleat int unsigned,
    nom varchar (25) not null,
    cognom varchar (35) not null,
    passaport varchar (20) not null,
    sou float not null
);

drop table if exists hostessa;
create table hostessa (
    num_empleat int unsigned
);

drop table if exists pilot;
create table pilot (
    hores_vol smallint unsigned
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
    codi varchar int
)