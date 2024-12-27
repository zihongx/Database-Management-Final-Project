
--- ANIME_SOURCE TABLE ---
create sequence SEQ_ANIME_source;

insert into ANIME_source(source_pk,source_tx)
select  SEQ_ANIME_source.nextval,ani_source
from(
    select distinct(type) ani_source
    from anime_stage
    minus
    select source_tx
    from anime_source
    );




--- ANIME_TYPE TABLE ---
create sequence SEQ_ANIME_type;

insert into ANIME_type(type_pk,type_tx)
select  SEQ_ANIME_type.nextval,ani_type
from(
    select distinct(type) ani_type
    from anime_stage
    minus
    select type_tx
    from anime_type
    );


--- ANIME_ANIME table ---
create sequence SEQ_ANIME_anime;
insert into anime_anime(anime_pk, anime_id, title, rating, scoredby, popularity, members,
            episodes, aired, link, source_fk, type_fk)
select SEQ_ANIME_anime.nextval, anime_id, title, rating, scoredby, popularity, members,
            episodes, aired, link, source_pk, type_pk
from( 
        select anime_id, title, rating, scoredby, popularity, members,
            episodes, aired, link, source_pk, type_pk
        from anime_stage stage
        join anime_source s
        on stage.source = s.name_tx
        join anime_type t
        on stage.type = t.name_tx
        minus
        select anime_id, title, rating, scoredby, popularity, members,
            episodes, aired, link, source_fk, type_fk
        from anime_anime
        );


--------------Genre, Producer, Studio (list to values) -------------


--- Anime_Genre Table --- 
create sequence seq_anime_genre;

insert into anime_genre(genre_pk, genre_tx)
select seq_anime_genre.nextval, genre
from (

        SELECT   Trim(data_single) genre
        FROM   (--A Open
               -------------------------this is the data from STAGE -------------------------
               --simply copy/paste this block and change the column name to match the column you are splitting
               ---change "listed_in" to whatever the column is that you want to split
               ---If delimiter is not a "comma", need to change that also
               ------- [^,]  && instr( listed_in, ',', 1, LEVEL - 1)
               SELECT Regexp_substr(replace(replace(replace(genre,''''),'['),']'), '[^,]+', 1, dataList.column_value)
                      data_single
                FROM   anime_stage a,
                       TABLE (Cast (MULTISET (SELECT LEVEL
                                       FROM   dual
                                       CONNECT BY Instr(replace(replace(replace(genre,''''),'['),']'), ',', 1, LEVEL - 1) >
                                                  0) AS
                                    sys.ODCINUMBERLIST) ) dataList
               -------------------------this is the data from STAGE -------------------------
               )--A Close
        WHERE  Trim(data_single) IS NOT NULL 
        minus
        select genre_tx
        from anime_genre
);


--- Anime_Producer TABLE ---
create sequence seq_anime_producer;

insert into anime_producer(producer_pk, producer_tx)
select seq_anime_producer.nextval, producer
from (

        SELECT   Trim(data_single) producer
        FROM   (--A Open
               -------------------------this is the data from STAGE -------------------------
               --simply copy/paste this block and change the column name to match the column you are splitting
               ---change "listed_in" to whatever the column is that you want to split
               ---If delimiter is not a "comma", need to change that also
               ------- [^,]  && instr( listed_in, ',', 1, LEVEL - 1)
               SELECT Regexp_substr(replace(replace(replace(producer,''''),'['),']'), '[^,]+', 1, dataList.column_value)
                      data_single
                FROM   anime_stage a,--change to match your stage table
                       TABLE (Cast (MULTISET (SELECT LEVEL
                                       FROM   dual
                                       CONNECT BY Instr(replace(replace(replace(producer,''''),'['),']'), ',', 1, LEVEL - 1) >
                                                  0) AS
                                    sys.ODCINUMBERLIST) ) dataList
               -------------------------this is the data from STAGE -------------------------
               )--A Close
        WHERE  Trim(data_single) IS NOT NULL 
        minus
        select producer_tx
        from anime_producer
);

--- Anime_Studio TABLE ---
create sequence seq_anime_studio;

insert into anime_studio(studio_pk, studio_tx)
select seq_anime_studio.nextval, studio
from (

        SELECT   Trim(data_single) studio
        FROM   (--A Open
               -------------------------this is the data from STAGE -------------------------
               --simply copy/paste this block and change the column name to match the column you are splitting
               ---change "listed_in" to whatever the column is that you want to split
               ---If delimiter is not a "comma", need to change that also
               ------- [^,]  && instr( listed_in, ',', 1, LEVEL - 1)
               SELECT Regexp_substr(replace(replace(replace(studio,''''),'['),']'), '[^,]+', 1, dataList.column_value)
                      data_single
                FROM   anime_stage a,--change to match your stage table
                       TABLE (Cast (MULTISET (SELECT LEVEL
                                       FROM   dual
                                       CONNECT BY Instr(replace(replace(replace(studio,''''),'['),']'), ',', 1, LEVEL - 1) >
                                                  0) AS
                                    sys.ODCINUMBERLIST) ) dataList
               -------------------------this is the data from STAGE -------------------------
               )--A Close
        WHERE  Trim(data_single) IS NOT NULL 
        minus
        select studio_tx
        from anime_studio
);




----------------------------Insert ANIME_AN_GENRE, ANIME_AN_PRODUCER, ANIME_AN_STUDIO table----------------------------------------------------

--- ANIME_AN_GENRE ---
create sequence seq_anime_an_genre;

insert into anime_an_genre(an_genre_pk, anime_fk, genre_fk)
 
     select seq_anime_an_genre.nextval,  anime_pk,   genre_pk
     from (select  anime_anime.anime_pk,  anime_genre.genre_pk
                from (SELECT distinct anime_id, Trim(data_single) genre
                            FROM   (--A Open
                                   -------------------------this is the data from STAGE -------------------------
                                   --simply copy/paste this block and change the column name to match the column you are splitting
                                   ---change "listed_in" to whatever the column is that you want to split
                                   ---If delimiter is not a "comma", need to change that also
                                   ------- [^,]  && instr( listed_in, ',', 1, LEVEL - 1)
                                   SELECT anime_id,  Regexp_substr(replace(replace(replace(genre,''''),'['),']'), '[^,]+', 1, dataList.column_value)
                                          data_single
                                    FROM   anime_stage a,--change to match your stage table
                                           TABLE (Cast (MULTISET (SELECT LEVEL
                                                           FROM   dual
                                                           CONNECT BY Instr(replace(replace(replace(genre,''''),'['),']'), ',', 1, LEVEL - 1) >
                                                                      0) AS
                                                        sys.ODCINUMBERLIST) ) dataList
                                   -------------------------this is the data from STAGE -------------------------
                                   )--A Close
                            WHERE  Trim(data_single) IS NOT NULL 
                    ) stageData
                      join anime_anime
                    on (stageData.anime_id = anime_anime.anime_id)
                      join anime_genre
                    on (stageData.genre = anime_genre.name_tx)
                    minus
                    select anime_fk, genre_fk 
                   from anime_an_genre
       );



--- ANIME_AN_PRODUCER ---
create sequence seq_anime_an_producer;

insert into anime_an_producer(an_producer_pk, anime_fk, producer_fk)
 
     select seq_anime_an_producer.nextval,  anime_pk,   producer_pk
     from (select  anime_anime.anime_pk,  zx_anime_producer.producer_pk
                from (SELECT distinct anime_id, Trim(data_single) producer
                            FROM   (--A Open
                                   -------------------------this is the data from STAGE -------------------------
                                   --simply copy/paste this block and change the column name to match the column you are splitting
                                   ---change "listed_in" to whatever the column is that you want to split
                                   ---If delimiter is not a "comma", need to change that also
                                   ------- [^,]  && instr( listed_in, ',', 1, LEVEL - 1)
                                   SELECT anime_id,  Regexp_substr(replace(replace(replace(producer,''''),'['),']'), '[^,]+', 1, dataList.column_value)
                                          data_single
                                    FROM   anime_stage a,--change to match your stage table
                                           TABLE (Cast (MULTISET (SELECT LEVEL
                                                           FROM   dual
                                                           CONNECT BY Instr(replace(replace(replace(producer,''''),'['),']'), ',', 1, LEVEL - 1) >
                                                                      0) AS
                                                        sys.ODCINUMBERLIST) ) dataList
                                   -------------------------this is the data from STAGE -------------------------
                                   )--A Close
                            WHERE  Trim(data_single) IS NOT NULL 
                    ) stageData
                      join anime_anime
                    on (stageData.anime_id = anime_anime.anime_id)
                      join anime_producer
                    on (stageData.producer = anime_producer.name_tx)
                    minus
                    select anime_fk, producer_fk 
                   from anime_an_producer
       );
       

--- ANIME_AN_STUDIO ---      
create sequence seq_anime_an_studio;

insert into anime_an_studio(an_studio_pk, anime_fk, studio_fk)
 
     select seq_anime_an_studio.nextval,  anime_pk,   studio_pk
     from (select  anime_anime.anime_pk,  anime_studio.studio_pk
                from (SELECT distinct anime_id, Trim(data_single) studio
                            FROM   (--A Open
                                   -------------------------this is the data from STAGE -------------------------
                                   --simply copy/paste this block and change the column name to match the column you are splitting
                                   ---change "listed_in" to whatever the column is that you want to split
                                   ---If delimiter is not a "comma", need to change that also
                                   ------- [^,]  && instr( listed_in, ',', 1, LEVEL - 1)
                                   SELECT anime_id,  Regexp_substr(replace(replace(replace(studio,''''),'['),']'), '[^,]+', 1, dataList.column_value)
                                          data_single
                                    FROM   anime_stage a,--change to match your stage table
                                           TABLE (Cast (MULTISET (SELECT LEVEL
                                                           FROM   dual
                                                           CONNECT BY Instr(replace(replace(replace(studio,''''),'['),']'), ',', 1, LEVEL - 1) >
                                                                      0) AS
                                                        sys.ODCINUMBERLIST) ) dataList
                                   -------------------------this is the data from STAGE -------------------------
                                   )--A Close
                            WHERE  Trim(data_single) IS NOT NULL 
                    ) stageData
                      join anime_anime
                    on (stageData.anime_id = anime_anime.anime_id)
                      join anime_studio
                    on (stageData.studio = anime_studio.name_tx)
                    minus
                    select anime_fk, studio_fk 
                   from anime_an_studio
       );


