-- crear base de datos
create database jardineria;
use jardineria;

-- crear taula firmes_comercials
create table firmes_comercials (
    id int auto_increment primary key,
    nom varchar(100) not null unique
);

-- crear taula adobs
create table adobs (
    id int auto_increment primary key,
    nom varchar(100) not null unique,
    firma_comercial_id int not null,
    qtat_adob int not null check (qtat_adob between 20 and 100),
    foreign key (firma_comercial_id) references firmes_comercials(id)
);

-- crear taula estacions
create table estacions (
    id int auto_increment primary key,
    nom_estacio varchar(100) not null unique,
    qtat_aigua int not null
);

-- crear taula plantes
create table plantes (
    id int auto_increment primary key,
    nom_popular varchar(100) not null unique,
    nom_llati varchar(100) not null,
    estacio_floracio_id int not null,
    foreign key (estacio_floracio_id) references estacions(id)
);

-- crear tabla metodes_reproduccio
create table metodes_reproduccio (
    id int auto_increment primary key,
    nom_metode varchar(100) not null unique,
    grau_exit int not null
);

-- crear tabla exemplars_plantes
create table exemplars_plantes (
    id int auto_increment primary key,
    nom_popular varchar(100) not null,
    foreign key (nom_popular) references plantes(nom_popular)
);

-- crear tabla plantes_interior
create table plantes_interior (
    id int auto_increment primary key,
    nom_popular_interior varchar(100) not null,
    estacio_any_id int not null,
    foreign key (nom_popular_interior) references plantes(nom_popular),
    foreign key (estacio_any_id) references estacions(id)
);

-- crear tabla plantes_exterior
create table plantes_exterior (
    id int auto_increment primary key,
    nom_popular_exterior varchar(100) not null,
    foreign key (nom_popular_exterior) references plantes(nom_popular)
);

-- crear tabla paisos
create table paisos (
    id int auto_increment primary key,
    nom varchar(100) not null unique
);

-- crear taula intermedia reproduccions
create table reproduccions (
    planta_id int not null,
    metode_id int not null,
    grau_exit int not null,
    primary key (planta_id, metode_id),
    foreign key (planta_id) references plantes(id),
    foreign key (metode_id) references metodes_reproduccio(id)
);

-- crear taula intermedia dosi_adobs
create table dosi_adobs (
    planta_id int not null,
    adob_id int not null,
    qtat_adob int not null check (qtat_adob between 20 and 100),
    primary key (planta_id, adob_id),
    foreign key (planta_id) references plantes(id),
    foreign key (adob_id) references adobs(id)
);

-- crear taula intermedia floracio
create table floracio (
    planta_id int not null,
    estacio_id int not null,
    primary key (planta_id, estacio_id),
    foreign key (planta_id) references plantes(id),
    foreign key (estacio_id) references estacions(id)
);

-- crear taula intermedia rec_plantes
create table rec_plantes (
    planta_id int not null,
    planta_interior_id int,
    planta_exterior_id int,
    primary key (planta_id, planta_interior_id, planta_exterior_id),
    foreign key (planta_id) references plantes(id),
    foreign key (planta_interior_id) references plantes_interior(id),
    foreign key (planta_exterior_id) references plantes_exterior(id)
);

-- crear taula intermedia origens_plantes
create table origens_plantes (
    planta_id int not null,
    pais_id int not null,
    primary key (planta_id, pais_id),
    foreign key (planta_id) references plantes(id),
    foreign key (pais_id) references paisos(id)
);

-- restricció addicional per assegurar que una planta tingui almenys 2 exemplars
delimiter //
create trigger trg_min_exemplars before insert on exemplars_plantes
for each row
begin
    declare count_exemplars int;
    select count(*) into count_exemplars from exemplars_plantes where nom_popular = new.nom_popular;
    if count_exemplars < 1 then
        signal sqlstate '45000' set message_text = 'una planta ha de tenir al menys 2 exemplars';
    end if;
end;
//
delimiter ;
