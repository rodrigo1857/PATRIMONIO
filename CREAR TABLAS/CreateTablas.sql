-====== creacion de tablas ==========
---------------------1---------------------

create table bytsscom_bytcore.area_patrimonio_dependencias
(
    id_area_patrimonio integer      not null
        primary key,
    codigo             varchar(100)  not null,
    nombre             varchar      not null,
    tipo               varchar(100) not null
);

comment on column bytsscom_bytcore.area_patrimonio_dependencias.id_area_patrimonio is 'TIPO : Ambiente,Dependencia,Oficina,Unidad,SubUnidad';

alter table bytsscom_bytcore.area_patrimonio_dependencias
    owner to postgres;

---------------------2---------------------
create table bytsscom_bytcore.area_patrimonio_unidades
(
    id_patrimonio_unidad serial
        primary key,
    id_area_patrimonio   integer
        references bytsscom_bytcore.area_patrimonio_dependencias,
    codigo               varchar(100) not null,
    nombre               varchar      not null,
    tipo                 varchar(100) not null
);

alter table bytsscom_bytcore.area_patrimonio_unidades
    owner to postgres;