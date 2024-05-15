--base de dades Plantes Aina Rovira i Ricard ...
drop database if exists practica; 
create database practica;
use practica;

--taula mètodes de reproducció
create table metodes_de_reproducció (
    nom_mertode varchar(25) primary key,
) engine = innodb;

--taula estacions
create table estacions (
    nom_estacio varchar(15) primary key,
) engine = innodb;

--taula plantes
create table plantes(
    nom_popular varchar(15) primary key,
    nom_llati varchar(15),
) engine = innodb;

--taula plantes interior
create table plantes_interior(
    nom_planta varchar(15) primary key,
    ubicacio varchar(15),
    temperatura int,
    foregin key (nom_planta) references plantes(nom_popular),
) engine = innodb;

--taula plantes exterior
create table plantes_exterior(
    nom_planta varchar(15) primary key,
    tipus_planta varchar(15),
    foregin key (nom_planta) references plantes(nom_popular),
) engine = innodb;

--taula exemplars plantes
create table exemplars_plantes(
    nom_planta varchar(15),
    num_exemplar int, 
    primary key(nom_planta, num_exemplar),
    foregin key (nom_planta) references plantes(nom_popular),
) engine = innodb;

--taula firmes comercials
create table firmes_comercials(
    nom_firma varchar(15) primary key,
) engine = innodb; 


--taula adobs
create table adobs(
    nom_adob varchar(15) primary key,
    nom_firma varchar(15) not null,
    tipus_adob varchar(15)
    constant fk_adobs foregin key(nom_firma) references firmes_comercials(nom_firma),
) engine = innodb;


--taula països
create table paisos(
    nom_pais varchar(15) primary key,
) engine = innodb;