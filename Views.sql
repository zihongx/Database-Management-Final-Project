
-- The most popular genres of anime for each type (TV, Movie, etc.)

create materialized view ZX_ANIME_TYPE_GENRE_MV      
as
select type, genre, count(genre) number_genre
        from(
            select t.type_tx type, gen.genre_tx genre from anime_anime an
            join anime_type t on (an.type_fk = t.type_pk)
            join anime_an_genre an_gen on (an_gen.anime_fk = an.anime_pk)
            join anime_genre gen on (an_gen.genre_fk = gen.genre_pk))
        group by type, genre
        order by type, number_genre desc;       


create view zx_anime_type_Most_Popular_Genre_view
as
select type, genre most_popular_genre, max_number_genre from ZX_ANIME_TYPE_GENRE_MV t_gen
inner join (select max(number_genre) max_number_genre from ZX_ANIME_TYPE_GENRE_MV where type ='Movie') t_gen_max
on t_gen.number_genre = t_gen_max.max_number_genre
where type ='Movie'
union
select type, genre, max_number_genre from ZX_ANIME_TYPE_GENRE_MV t_gen
inner join (select max(number_genre) max_number_genre from ZX_ANIME_TYPE_GENRE_MV where type ='Music') t_gen_max
on t_gen.number_genre = t_gen_max.max_number_genre
where type ='Music'
union
select type, genre, max_number_genre from ZX_ANIME_TYPE_GENRE_MV t_genc
inner join (select max(number_genre) max_number_genre from ZX_ANIME_TYPE_GENRE_MV where type ='ONA') t_gen_max
on t_gen.number_genre = t_gen_max.max_number_genre
where type ='ONA'
union
select type, genre, max_number_genre from ZX_ANIME_TYPE_GENRE_MV t_gen
inner join (select max(number_genre) max_number_genre from ZX_ANIME_TYPE_GENRE_MV where type ='OVA') t_gen_max
on t_gen.number_genre = t_gen_max.max_number_genre
where type ='OVA'
union
select type, genre, max_number_genre from ZX_ANIME_TYPE_GENRE_MV t_gen
inner join (select max(number_genre) max_number_genre from ZX_ANIME_TYPE_GENRE_MV where type ='Special' ) t_gen_max
on t_gen.number_genre = t_gen_max.max_number_genre
where type ='Special'
union
select type, genre, max_number_genre from ZX_ANIME_TYPE_GENRE_MV t_gen
inner join (select max(number_genre) max_number_genre from ZX_ANIME_TYPE_GENRE_MV where type ='TV') t_gen_max
on t_gen.number_genre = t_gen_max.max_number_genre
where type ='TV'
union
select type, genre, max_number_genre from ZX_ANIME_TYPE_GENRE_MV t_gen
inner join (select max(number_genre) max_number_genre from ZX_ANIME_TYPE_GENRE_MV where type ='Unknown' ) t_gen_max
on t_gen.number_genre = t_gen_max.max_number_genre
where type ='Unknown';

  

-- Studios and Producers which are associated with the highest rating and highest popularity of anime

create view ZX_ANIME_STUDIO_PRODUCER_HIGHEST_RATING 
as
select an.title anime, studio.studio_tx studio, producer.producer_tx producer, rating
from anime_anime an
join anime_an_studio an_studio
on (an.anime_pk = an_studio.anime_fk)
join anime_studio studio
on (an_studio.studio_fk = studio.studio_pk)
join anime_an_producer an_producer
on (an.anime_pk = an_producer.anime_fk)
join anime_producer producer
on (an_producer.producer_fk = producer.producer_pk)
where rating is not null
and popularity is not null
order by rating desc;



create view ZX_ANIME_STUDIO_PRODUCER_HIGHEST_POPULARITY 
as
select an.title anime, studio.studio_tx studio, producer.producer_tx producer, popularity
from anime_anime an
join anime_an_studio an_studio
on (an.anime_pk = an_studio.anime_fk)
join anime_studio studio
on (an_studio.studio_fk = studio.studio_pk)
join anime_an_producer an_producer
on (an.anime_pk = an_producer.anime_fk)
join anime_producer producer
on (an_producer.producer_fk = producer.producer_pk)
where rating is not null
and popularity is not null
order by popularity;

