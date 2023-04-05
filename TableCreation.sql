CREATE TABLE IF NOT EXIST Client(
    id serial,
    nom text,
    prenom text,
    email text,
    CONSTRAINT pk_client PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Liquid(
    id serial,
    ispotable BOOLEAN,
    nom text,
    CONSTRAINT pk_liquid PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Region_geo(
    id serial,
    nom text,
    CONSTRAINT pk_region_geo PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Fournisseur(
    id serial,
    nom text,
    CONSTRAINT pk_fournisseur PRIMARY KEY id
)

CREATE TABLE IF NOT EXIST Subvention(
    id serial,
    nom text,
    date_début DATE,
    date_fin DATE,
    CONSTRAINT pk_subvention PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Pays(
    id integer,
    CONSTRAINT hk_pays FOREIGN KEY Pays(id) REFERENCES Region_geo(id),
    CONSTRAINT pk_pays PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Etatique(
    id integer,
    id_pays_concerne integer,
    CONSTRAINT hk_etatique FOREIGN KEY Etatique(id) REFERENCES Subvention(id),
    CONSTRAINT fk_etatique_pays FOREIGN KEY Etatique(id_pays_concerne) REFERENCES Pays(id),
    CONSTRAINT pk_etatique PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Region(
    id integer,
    CONSTRAINT hk_region FOREIGN KEY Region(id) REFERENCES Region_geo(id),
    CONSTRAINT pk_region PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Regionale(
    id integer,
    id_region_concerne integer,
    CONSTRAINT hk_regionale FOREIGN KEY Regionale(id) REFERENCES Subvention(id),
    CONSTRAINT fk_regionale_region FOREIGN KEY Etatique(id_region_concerne) REFERENCES Region(id),
    CONSTRAINT pk_regionale PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Metropole(
    id integer,
    CONSTRAINT hk_metropole FOREIGN KEY Metropole(id) REFERENCES Region_geo(id),
    CONSTRAINT pk_metropole PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Metropolitaine(
    id integer,
    id_region_concerne integer,
    CONSTRAINT hk_metropolitaine FOREIGN KEY Regional(id) REFERENCES Subvention(id),
    CONSTRAINT fk_metropolitaine_metropole FOREIGN KEY Metropolitaine(id_region_concerne) REFERENCES Metropole(id),
    CONSTRAINT pk_regional PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Commune(
    id integer,
    CONSTRAINT hk_commune FOREIGN KEY Commune(id) REFERENCES Region_geo(id),
    CONSTRAINT pk_commune PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Communale(
    id integer,
    id_commune_concerne integer,
    CONSTRAINT hk_communale FOREIGN KEY Communale(id) REFERENCES Subvention(id),
    CONSTRAINT fk_communale_commune FOREIGN KEY Communal(id_commune_concerne) REFERENCES Commune(id),
    CONSTRAINT pk_communale PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Sub_valFix(
    id integer,
    val_const integer DEFAULT 0 CHECK val_mult >= 0,
    val_mult integer DEFAULT 0 CHECK val_mult >= 0 and val_mult <= 1,
    CONSTRAINT hk_sub_valFix FOREIGN KEY Sub_valFix(id) REFERENCES Subvention(id),
    CONSTRAINT pk_sub_valfix PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Sub_valHab(
    id integer,
    val_const integer DEFAULT 0 CHECK val_mult >= 0,
    val_mult integer DEFAULT 0 CHECK val_mult >= 0 and val_mult <= 1,
    val_upperCap integer NOT NULL CHECK val_upperCap > 0,
    val_lowerCap integer DEFAULT 0 CHECK val_lowerCap > 0,
    CONSTRAINT hk_sub_valhab FOREIGN KEY Sub_valHab(id) REFERENCES Subvention(id),
    CONSTRAINT pk_sub_valhab PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Eau(
    id integer,
    magnesium float NOT NULL,
    nitrates float NOT NULL,
    calcium float NOT NULL,
    bicarbonates float NOT NULL,
    sulfate float NOT NULL,
    sodium float NOT NULL,
    nitrate float NOT NULL,
    potassium float NOT NULL,
    silicum float NOT NULL,
    fluor float NOT NULL,
    CONSTRAINT hk_eau FOREIGN KEY Eau(id) REFERENCES Liquid(id),
    CONSTRAINT pk_eau PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Jus(
    id integer,
    composition text,
    CONSTRAINT hk_jus FOREIGN KEY Jus(id) REFERENCES Liquid(id),
    CONSTRAINT pk_jus PRIMARY KEY id
);

CREATE TABLE IF NOT EXIST Alcool(
    id integer,
    composition text,
    alcool_value integer,
    CONSTRAINT hk_alcool FOREIGN KEY Alcool(id) REFERENCES Liquid(id),
    CONSTRAINT pk_alcool PRIMARY KEY id
);

/*      
Debut des tables de liens.
*/








