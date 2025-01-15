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
--  Creació Primary Keys
-- ------------------------------------------------------

alter table companyia
add constraint pk_companyia primary key (nom);

alter table hostessa
add constraint pk_hostessa primary key (num_empleat);

alter table avio
add constraint pk_avio primary key (num_serie);

alter table aeroport
add constraint pk_aeroport primary key (codi);

alter table Mostrador
add constraint pk_Mostrador primary key (numero, codi_aeroport);

alter table personal
add constraint pk_personal primary key (num_empleat);

alter table vol
add constraint pk_vol primary key (codi);

alter table passatger
add constraint pk_passatger primary key (passaport);

alter table pilot
add constraint pk_pilot primary key (num_empleat);

alter table volar
add constraint pk_volar primary key (passatger, vol);

-- ------------------------------------------------------
--  Creació de les Foreign Keys
-- ------------------------------------------------------

alter table hostessa
add constraint fk_hostessa_personal foreign key (num_empleat)
references personal (num_empleat)
ON DELETE CASCADE
ON UPDATE CASCADE;

alter table companyia
add constraint fk_companyia_filial foreign key (filial_de)
references companyia (nom)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table avio
add constraint fk_avio_companyia foreign key (companyia)
references companyia (nom)
ON DELETE RESTRICT
ON UPDATE CASCADE;

alter table Mostrador
add constraint fk_Mostrador_aeroport foreign key (codi_aeroport)
references aeroport (codi)
ON DELETE CASCADE
ON UPDATE CASCADE;

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

alter table pilot
add constraint fk_pilot_personal foreign key (num_empleat)
references personal (num_empleat)
ON DELETE CASCADE
ON UPDATE CASCADE;

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

-- ------------------------------------------------------
--  Creació dels checks
-- ------------------------------------------------------

alter table avio
add constraint ck_tipus_avio check (tipus='COM-PAS' or tipus='JET' or tipus='CARGO');

alter table personal
add constraint ck_sou check (sou >= 20000);

alter table vol
add constraint ck_vol_desc check (descripcio='ON-TIME' or descripcio='DELAYED' or descripcio='UNKNOWN');

alter table vol
add constraint ck_vol_durada check (durada >= 10 and durada <= 1200);

alter table pilot
add constraint ck_pilot_hores_vol check (hores_vol >= 400);

alter table volar
add constraint ck_seient check (seient >= 1 and seient <= 200);

-- ------------------------------------------------------
--  Creació dels uniques
-- ------------------------------------------------------

alter table volar
add constraint uq_vol_seient unique (seient, vol);

alter table aeroport
add constraint uq_iata unique (IATA);

alter table personal
add constraint uq_passaport unique (passaport);