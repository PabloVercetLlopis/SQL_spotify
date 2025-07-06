--🔴 AVANZADO
--¿Qué canciones están asociadas a más de un género?
select t.track_name, count(g.genre_name) as generos_asociados from tracks t join track_genre tg on t.track_id = tg.track_id 
join genres g on tg.genre_id  = g.genre_id 
group by t.track_name 
having count(g.genre_name) > 1 
order by generos_asociados 

--¿Qué artistas tienen canciones en más de un género?
select a.artist_name, t.track_name, count(g.genre_name) as generos_canciones from artists a  join tracks t on a.artist_name = t.artist_name 
join track_genre tg on t.track_id = tg.track_id 
join genres g on tg.genre_id  = g.genre_id 
group by a.artist_name, t.track_name  
HAVING COUNT(g.genre_name) > 1
ORDER BY generos_canciones DESC;

--¿Qué género tiene canciones más bailables de media?
select g.genre_name, round(AVG(af.danceability)::numeric, 3) as media_bailable 
from genres g join track_genre tg  on g.genre_id = tg.genre_id 
join audio_features af  on tg.track_id = af.track_id 
group by g.genre_name
order by media_bailable DESC

--¿Cuál es la canción con mayor "valence" y "energy" al mismo tiempo?
select t.track_name, af.valence, af.energy
from genres g join track_genre tg  on g.genre_id = tg.genre_id 
join tracks t on tg.track_id = t.track_id
join audio_features af  on t.track_id = af.track_id 
order by af.valence DESC, af.energy DESC
limit 1

--¿Cuál es el promedio de duración de las canciones por género?
select g.genre_name, avg(t.duration_ms) as media_duracion from genres g join track_genre tg  on g.genre_id = tg.genre_id 
join tracks t on tg.track_id = t.track_id
group by g.genre_name
order by media_duracion DESC

--¿Qué canción tiene los valores más altos combinados de "energy", "danceability" y "valence"?
select t.track_name, af.energy, af.danceability, af.valence, (af.energy + af.danceability + af.valence) as combinado
from genres g join track_genre tg  on g.genre_id = tg.genre_id 
join tracks t on tg.track_id = t.track_id
join audio_features af  on t.track_id = af.track_id 
order by combinado DESC
limit 1
