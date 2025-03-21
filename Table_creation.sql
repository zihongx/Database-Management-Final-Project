
-- ANIME_SOURCE TABLE
CREATE TABLE anime_source (
    source_pk NUMBER NOT NULL,
    source_tx VARCHAR2(100)
);

ALTER TABLE anime_source ADD CONSTRAINT anime_source_pk PRIMARY KEY ( source_pk );

-- ANIME_TYPE TABLE
CREATE TABLE anime_type (
    type_pk NUMBER NOT NULL,
    type_tx VARCHAR2(100)
);

ALTER TABLE anime_type ADD CONSTRAINT anime_type_pk PRIMARY KEY ( type_pk );

-- ANIME_ANIME TABLE
CREATE TABLE anime_anime (
    anime_pk   NUMBER NOT NULL,
    anime_id   NUMBER,
    title      VARCHAR2(100),
    rating     NUMBER,
    scoredby   NUMBER,
    popularity NUMBER,
    members    NUMBER,
    episodes   NUMBER,
    aired      DATE,
    link       VARCHAR2(300),
    source_fk  NUMBER NOT NULL,
    type_fk    NUMBER NOT NULL
);

ALTER TABLE anime_anime ADD CONSTRAINT anime_anime_pk PRIMARY KEY ( anime_pk );

ALTER TABLE anime_anime
    ADD CONSTRAINT anime_source_fk FOREIGN KEY ( source_fk )
        REFERENCES anime_source ( source_pk );

ALTER TABLE anime_anime
    ADD CONSTRAINT anime_type_fk FOREIGN KEY ( type_fk )
        REFERENCES anime_type ( type_pk );


-- ANIME_GENRE TABLE
CREATE TABLE anime_genre (
    genre_pk NUMBER NOT NULL,
    genre_tx VARCHAR2(100)
);

ALTER TABLE anime_genre ADD CONSTRAINT anime_genre_pk PRIMARY KEY ( genre_pk );

-- ANIME_AN_GENRE TABLE
CREATE TABLE anime_an_genre (
    an_genre_pk NUMBER NOT NULL,
    anime_fk    NUMBER NOT NULL,
    genre_fk    NUMBER NOT NULL
);

ALTER TABLE anime_an_genre ADD CONSTRAINT anime_an_genre_pk PRIMARY KEY ( an_genre_pk );

ALTER TABLE anime_an_genre
    ADD CONSTRAINT anime_anime_fk FOREIGN KEY ( anime_fk )
        REFERENCES anime_anime ( anime_pk );

ALTER TABLE anime_an_genre
    ADD CONSTRAINT anime_genre_fk FOREIGN KEY ( genre_fk )
        REFERENCES anime_genre ( genre_pk );


-- ANIME_STUDIO TABLE
CREATE TABLE anime_studio (
    studio_pk NUMBER NOT NULL,
    studio_tx VARCHAR2(100)
);

ALTER TABLE anime_studio ADD CONSTRAINT anime_studio_pk PRIMARY KEY ( studio_pk );

-- ANIME_AN_STUDIO TABLE
CREATE TABLE anime_an_studio (
    an_studio_pk NUMBER NOT NULL,
    anime_fk     NUMBER NOT NULL,
    studio_fk    NUMBER NOT NULL
);

ALTER TABLE anime_an_studio ADD CONSTRAINT anime_an_studio_pk PRIMARY KEY ( an_studio_pk );

ALTER TABLE anime_an_studio
    ADD CONSTRAINT "_ANIME_STUDIO_FK" FOREIGN KEY ( studio_fk )
        REFERENCES anime_studio ( studio_pk );

ALTER TABLE anime_an_studio
    ADD CONSTRAINT anime_anime_fkv2 FOREIGN KEY ( anime_fk )
        REFERENCES anime_anime ( anime_pk );


-- ANIME_PRODUCER TABLE
CREATE TABLE anime_producer (
    producer_pk NUMBER NOT NULL,
    producer_tx VARCHAR2(100)
);

ALTER TABLE anime_producer ADD CONSTRAINT anime_producer_pk PRIMARY KEY ( producer_pk );

-- ANIME_AN_PRODUCER TABLE
CREATE TABLE anime_an_producer (
    an_producer_pk NUMBER NOT NULL,
    anime_fk       NUMBER NOT NULL,
    producer_fk    NUMBER NOT NULL
);

ALTER TABLE anime_an_producer ADD CONSTRAINT anime_an_producer_pk PRIMARY KEY ( an_producer_pk );

ALTER TABLE anime_an_producer
    ADD CONSTRAINT anime_anime_fkv1 FOREIGN KEY ( anime_fk )
        REFERENCES anime_anime ( anime_pk );

ALTER TABLE anime_an_producer
    ADD CONSTRAINT anime_producer_fk FOREIGN KEY ( producer_fk )
        REFERENCES anime_producer ( producer_pk );