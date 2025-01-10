--====== creacion de tablas ==========
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
------------------NORMALIZACION DE TABLAS PARA PATRIMONIO ------------------------



CREATE TABLE "registro" (
    "idregistro"  SERIAL  NOT NULL,
    "fech_registro" TIMESTAMP   NOT NULL,
    "fech_actualizacion" TIMESTAMP   NOT NULL,
    "id_ambiente" INT   NOT NULL,
    -- idpersona
    "id_asignado" INT   NOT NULL,
    "num_pecosa" STRING   NOT NULL,
    "guia_remision" STRING   NOT NULL,
    "boleta" STRING   NOT NULL,
    "detalle" TEXT   NOT NULL,
    CONSTRAINT "pk_registro" PRIMARY KEY (
        "idregistro"
     )
);

CREATE TABLE "bienes" (
    "idbien"  SERIAL  NOT NULL,
    "idregistro" INT   NOT NULL,
    "iditem" INT   NOT NULL,
    "correlativo" INT   NOT NULL,
    "marca" TEXT   NOT NULL,
    "model" TEXT   NOT NULL,
    "serie" TEXT   NOT NULL,
    "dimension" TEXT   NOT NULL,
    "color" TEXT   NOT NULL,
    "precio" FLOAT   NOT NULL,
    "tipo_bien" STRING   NOT NULL,
    CONSTRAINT "pk_bienes" PRIMARY KEY (
        "idbien"
     )
);

CREATE TABLE "registroOC" (
    "idregistroOC"  SERIAL  NOT NULL,
    "idorden" INT   NOT NULL,
    "idregistro" INT   NOT NULL,
    CONSTRAINT "pk_registroOC" PRIMARY KEY (
        "idregistroOC"
     )
);

CREATE TABLE "registroNEA" (
    "idregistroNEA"  SERIAL  NOT NULL,
    "idregistro" INT   NOT NULL,
    "id_proveedor" INT   NOT NULL,
    "id_proyecto" INT   NOT NULL,
    CONSTRAINT "pk_registroNEA" PRIMARY KEY (
        "idregistroNEA"
     )
);

ALTER TABLE "bienes" ADD CONSTRAINT "fk_bienes_idregistro" FOREIGN KEY("idregistro")
REFERENCES "registro" ("idregistro");

ALTER TABLE "registroOC" ADD CONSTRAINT "fk_registroOC_idregistro" FOREIGN KEY("idregistro")
REFERENCES "registro" ("idregistro");

ALTER TABLE "registroNEA" ADD CONSTRAINT "fk_registroNEA_idregistro" FOREIGN KEY("idregistro")
REFERENCES "registro" ("idregistro");
