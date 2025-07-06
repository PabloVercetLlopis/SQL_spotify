-Consultas
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