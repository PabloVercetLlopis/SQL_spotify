--🟡 INTERMEDIO
--¿Cuántas canciones tiene cada artista?
select a.artist_name, count(t.artist_name) as numero_canciones from artists a join tracks t on a.artist_name = t.artist_name 
group by a.artist_name
order by numero_canciones DESC

--¿Qué artistas tienen más de 10 canciones en la base de datos?
select a.artist_name, count(t.artist_name) as numero_canciones from artists a join tracks t on a.artist_name = t.artist_name 
group by a.artist_name
having count(t.artist_name) > 10
order by numero_canciones 

--¿Qué canciones tienen una "danceability" superior a 0.9?
select track_name, danceability from tracks t  join audio_features af  on t.track_id = af.track_id
where af.danceability > 0.9

--¿Qué canciones tienen una "acousticness" superior a 0.95?
select track_name, af.acousticness  from tracks t  join audio_features af  on t.track_id = af.track_id
where af.acousticness > 0.95

--¿Cuáles son las 10 canciones más populares con mayor nivel de "energy"?
select track_name, popularity, energy from tracks t join audio_features af on t.track_id = af.track_id
order by popularity DESC, energy DESC
limit 10

--¿Qué canciones están clasificadas como "pop"?
select track_name, genre_name from genres g join track_genre tg on g.genre_id = tg.genre_id join tracks t on tg.track_id = t.track_id
where g.genre_name = 'pop'

--¿Cuáles son los 10 géneros más comunes?
select genre_name, COUNT(t.track_name) as numero_canciones from genres g join track_genre tg on g.genre_id = tg.genre_id join tracks t on tg.track_id = t.track_id
group by g.genre_name 
order by numero_canciones  desc
limit 10

--¿Cuántos géneros distintos tiene cada artista?
select a.artist_name, count(genre_name) as generos_distintos from artists a join tracks t on a.artist_name = t.artist_name
join track_genre tg on t.track_id = tg.track_id join genres g on tg.genre_id = g.genre_id
group by a.artist_name 
order by generos_distintos DESC

