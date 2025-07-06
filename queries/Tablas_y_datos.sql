CREATE TABLE artists (
    artist_name TEXT PRIMARY KEY
);

CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name TEXT NOT NULL UNIQUE
);

CREATE TABLE tracks (
    track_id TEXT PRIMARY KEY,
    track_name TEXT NOT NULL,
    artist_name TEXT NOT NULL,
    album TEXT,
    duration_ms INTEGER,
    explicit BOOLEAN,
    popularity INTEGER,
    FOREIGN KEY (artist_name) REFERENCES artists(artist_name)
);

CREATE TABLE audio_features (
    track_id TEXT PRIMARY KEY,
    danceability FLOAT,
    energy FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    tempo FLOAT,
    valence FLOAT,
    liveness FLOAT,
    FOREIGN KEY (track_id) REFERENCES tracks(track_id)
);

CREATE TABLE track_genre (
    track_id TEXT NOT NULL,
    genre_id INTEGER NOT NULL,
    PRIMARY KEY (track_id, genre_id),
    FOREIGN KEY (track_id) REFERENCES tracks(track_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);


INSERT INTO artists (artist_name)
SELECT DISTINCT TRIM(SPLIT_PART(artists, ';', 1)) AS artist_name
FROM spotify_raw
ON CONFLICT (artist_name) DO NOTHING;

INSERT INTO genres (genre_name)
SELECT DISTINCT track_genre
FROM spotify_raw
ON CONFLICT (genre_name) DO NOTHING;

INSERT INTO tracks (track_id, track_name, artist_name, album, duration_ms, explicit, popularity)
SELECT
    track_id,
    track_name,
    TRIM(SPLIT_PART(artists, ';', 1)) AS artist_name,
    album_name AS album,
    duration_ms,
    explicit,
    popularity
FROM spotify_raw
ON CONFLICT (track_id) DO NOTHING;


INSERT INTO audio_features (track_id, danceability, energy, acousticness, instrumentalness, tempo, valence, liveness)
SELECT
    track_id,
    danceability,
    energy,
    acousticness,
    instrumentalness,
    tempo,
    valence,
    liveness
FROM spotify_raw
ON CONFLICT (track_id) DO NOTHING;

INSERT INTO track_genre (track_id, genre_id)
SELECT
    sr.track_id,
    g.genre_id
FROM
    spotify_raw sr
JOIN
    genres g ON sr.track_genre = g.genre_name
ON CONFLICT (track_id, genre_id) DO NOTHING;


--Consultas
--🟢 BÁSICO
--¿Cuáles son los nombres de todas las canciones de la base de datos?
select track_name from tracks

--¿Qué canciones son explícitas (tienen contenido explícito)?
SELECT track_name, artist_name
FROM tracks
WHERE explicit = TRUE;


--¿Cuántas canciones hay en total en tu base de datos?
select count(track_name) from tracks 

--¿Qué canciones duran más de 5 minutos?
select track_name from tracks 
where duration_ms > 300000

--¿Cuál es la canción más popular?
select track_name from tracks 
order by popularity DESC limit 1;


--¿Cuál es la media de popularidad de todas las canciones?
select AVG(popularity) as media_popularidad from tracks 

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
