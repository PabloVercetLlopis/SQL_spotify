# SQL_spotify
## 🎵 Proyecto de Análisis de Datos Musicales con SQL

Este proyecto consiste en un análisis exploratorio de una base de datos relacional sobre canciones, artistas, géneros y características acústicas de Spotify, utilizando consultas SQL para extraer insights relevantes. Es uno de mis primeros proyectos prácticos con SQL enfocado en datos musicales, con el objetivo de fortalecer mis habilidades en bases de datos, análisis de datos y visualización.

## 🧹 Limpieza y preparación de datos
El proyecto parte de un único archivo CSV original que contiene toda la información combinada de canciones, artistas, géneros y características acústicas.

Localmente, realicé un proceso de limpieza y normalización para dividir este CSV completo en cinco conjuntos de datos correspondientes a las tablas principales (tracks, artists, genres, track_genre y audio_features), lo que facilitó la importación y el análisis en la base de datos relacional mediante SQL.

Por limitaciones de espacio y para mantener la coherencia, en el repositorio solo se incluye el archivo CSV original completo, sin los CSVs divididos, que fueron generados localmente para el análisis.


## 📁 Estructura de la base de datos
| Tabla            | Descripción                                                                  |
| ---------------- | ---------------------------------------------------------------------------- |
| `tracks`         | Información de canciones (nombre, duración, popularidad, explícito, artista) |
| `artists`        | Información de los artistas                                                  |
| `genres`         | Géneros musicales                                                            |
| `track_genre`    | Relación muchos a muchos entre canciones y géneros                           |
| `audio_features` | Características acústicas (energy, danceability, valence, etc)               |


## 🎯 Objetivos del proyecto

Explorar la base de datos y responder preguntas clave sobre canciones, artistas y géneros musicales.

Aplicar consultas SQL avanzadas con JOINs, GROUP BY, HAVING y funciones agregadas.

Realizar análisis estadísticos y comparativos de atributos musicales.

## 🛠️ Tecnologías utilizadas

SQL para manipulación y consulta de datos.

DBeaver como entorno para gestión y consulta de la base de datos.


## 🧠 Consultas destacadas

¿Cuáles son las canciones explícitas?

¿Qué canciones duran más de 5 minutos?

¿Cuál es la canción más popular?

¿Qué artistas tienen más canciones en la base?

¿Qué canciones tienen mayor energía, bailabilidad y valencia combinadas?

¿Qué géneros tienen canciones más bailables de media?

¿Cuál es la duración promedio de las canciones por género?

¿Qué canciones están asociadas a más de un género?

## 📁 Estructura del repositorio

├── queries/

    │       ├── consultas_basicas.sql

    │       ├── consultas_intermedias.sql

    │       └── consultas_avanzadas.sql

    │       └── tablas_y_datos.sql

├── data/

    │       ├── spotify_limpio.csv


├── README.md
