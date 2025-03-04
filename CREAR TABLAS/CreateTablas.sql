-- TABLA PATRIMONIO AREA
------------------------------------------------

create table if not exists bytsscom_bytsig.patrimonio_area
(
    id_patrimonio_area integer not null
        constraint pk_patrimonio_area
            primary key
        constraint patrimonio_area_area_id_area_fk
            references bytsscom_bytcore.area,
    codigo             varchar not null
);

alter table bytsscom_bytsig.patrimonio_area
    owner to bytsscom_bytsig;

-- TABLA PATRIMONIO AMBIENTE
------------------------------------------------
create table if not exists bytsscom_bytsig.patrimonio_ambiente
(
    id_patrimonio_ambiente serial
        constraint pk_patrimonio_ambiente
            primary key,
    id_patrimonio_area     integer not null
        constraint fk_patrimonio_ambiente_id_patrimonio_area
            references bytsscom_bytsig.patrimonio_area,
    codigo                 varchar not null,
    nombre                 varchar not null,
    tipo                   varchar not null
);

alter table bytsscom_bytsig.patrimonio_ambiente
    owner to bytsscom_bytsig;

-- TABLA PATRIMONIO REGISTRO
------------------------------------------------
create table if not exists bytsscom_bytsig.patrimonio_registro
(
    id_patrimonio_registro     serial
        constraint pk_patrimonio_registro
            primary key,
    fech_registro              timestamp                              not null,
    fech_actualizacion         timestamp                              not null,
    id_patrimonio_ambiente     integer                                not null
        constraint fk_patrimonio_registro_id_patrimonio_ambiente
            references bytsscom_bytsig.patrimonio_ambiente,
    id_persona_asignada        integer                                not null
        constraint patrimonio_registro_persona_id_persona_fk
            references bytsscom_bytcore.persona,
    num_factura                varchar,
    num_boleta                 varchar,
    num_guia_remision          varchar,
    num_pecosa                 varchar                                not null,
    tipo_bien                  varchar,
    id_cuenta                  varchar
        constraint patrimonio_registro_plan_cuenta_id_cuenta_fk
            references bytsscom_bytsig.plan_cuenta,
    fecha_pecosa               timestamp,
    id_persona_registro        integer
        constraint patrimonio_registro_persona_id_persona_fk_2
            references bytsscom_bytcore.persona,
    estado_patrimonio_registro varchar default 'R'::character varying not null
);

alter table bytsscom_bytsig.patrimonio_registro
    owner to bytsscom_bytsig;








-- TABLA PATRIMONIO REGISTRO ORDEN DE COMPRA
------------------------------------------------
create table if not exists bytsscom_bytsig.patrimonio_regoc
(
    id_patrimonio_regoc    serial
        constraint pk_patrimonio_regoc
            primary key,
    id_patrimonio_registro integer not null
        constraint fk_patrimonio_regoc_id_patrimonio_registro
            references bytsscom_bytsig.patrimonio_registro,
    id_contrato            integer not null
        constraint patrimonio_regoc_contrato_id_contrato_fk
            references bytsscom_bytsig.contrato
);

alter table bytsscom_bytsig.patrimonio_regoc
    owner to bytsscom_bytsig;

create index if not exists patrimonio_regoc_id_patrimonio_registro_index
    on bytsscom_bytsig.patrimonio_regoc (id_patrimonio_registro);




-- TABLA PATRIMONIO REGISTRO NEA
------------------------------------------------

create table if not exists bytsscom_bytsig.patrimonio_regnea
(
    id_patrimonio_regnea   serial
        constraint pk_patrimonio_regnea
            primary key,
    id_patrimonio_registro integer not null
        constraint fk_patrimonio_regnea_id_patrimonio_registro
            references bytsscom_bytsig.patrimonio_registro,
    id_proveedor           integer
        constraint patrimonio_regnea_persona_id_persona_fk
            references bytsscom_bytcore.persona,
    id_proyecto            integer,
    num_nea                varchar,
    fecha_nea              timestamp,
    resolucion_rectoral    varchar
);

alter table bytsscom_bytsig.patrimonio_regnea
    owner to bytsscom_bytsig;

create index if not exists patrimonio_regnea_id_patrimonio_registro_index
    on bytsscom_bytsig.patrimonio_regnea (id_patrimonio_registro);



-- TABLA PATRIMONIO BIEN
------------------------------------------------
create table if not exists bytsscom_bytsig.patrimonio_bien
(
    id_patrimonio_bien     serial
        constraint pk_patrimonio_bien
            primary key,
    id_patrimonio_registro integer                                not null
        constraint fk_patrimonio_bien_id_patrimonio_registro
            references bytsscom_bytsig.patrimonio_registro,
    id_item                integer                                not null
        constraint patrimonio_bien_item_id_item_fk
            references bytsscom_bytsig.item,
    correlativo            varchar                                not null,
    marca                  varchar                                not null,
    modelo                 varchar                                not null,
    serie                  varchar,
    dimension              varchar,
    color                  varchar,
    precio                 numeric(19, 4)                         not null,
    detalle                text,
    estado_patrimonio_bien varchar default 'R'::character varying not null
        constraint chk_estado_patrimonio_bien
            check ((estado_patrimonio_bien)::text = ANY
                   (ARRAY [('R'::character varying)::text, ('A'::character varying)::text, ('B'::character varying)::text, ('O'::character varying)::text]))
);

comment on column bytsscom_bytsig.patrimonio_bien.estado_patrimonio_bien is 'R: Bien registrado, A: Bien anulado por el usuario, O: Bien con correlativo reutilizado: B:Bien dado de baja';

alter table bytsscom_bytsig.patrimonio_bien
    owner to bytsscom_bytsig;

create index if not exists patrimonio_bien_id_item_index
    on bytsscom_bytsig.patrimonio_bien (id_item);

create unique index if not exists unique_patrimonio_bien_r
    on bytsscom_bytsig.patrimonio_bien (id_item, correlativo)
    where ((estado_patrimonio_bien)::text = 'R'::text);



