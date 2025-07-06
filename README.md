# SQL_spotify
## 🎵 Proyecto de Análisis de Datos Musicales con SQL y Visualizaciones en Python

Este proyecto consiste en un análisis exploratorio de una base de datos relacional sobre canciones, artistas, géneros y características acústicas de Spotify, utilizando consultas SQL para extraer insights relevantes. Complementa el análisis con visualizaciones en Python para interpretar y comunicar los resultados. Es uno de mis primeros proyectos prácticos con SQL enfocado en datos musicales, con el objetivo de fortalecer mis habilidades en bases de datos, análisis de datos y visualización.

## 🧹 Limpieza y preparación de datos
Partí de un único archivo CSV completo que contenía toda la información combinada. Realicé un proceso de limpieza y normalización para dividirlo en cinco archivos CSV separados correspondientes a las tablas mencionadas (tracks, artists, genres, track_genre y audio_features). Esto facilitó la importación en la base de datos relacional y permitió un análisis más estructurado y eficiente mediante SQL.

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

Visualizar los datos para facilitar la interpretación y la toma de decisiones usando Python (pandas, matplotlib, seaborn).

## 🛠️ Tecnologías utilizadas

SQL para manipulación y consulta de datos.

DBeaver como entorno para gestión y consulta de la base de datos.

Python con pandas, matplotlib y seaborn para análisis y visualización.

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

│   ├── consultas_basicas.sql

│   ├── consultas_intermedias.sql

│   └── consultas_avanzadas.sql

│   └── tablas_y_datos.sql

├── data/

│   ├── spotify_limpio.csv

├── visualizations/
│   ├── spotify_analysis.ipynb
│   └── charts/
│       ├── danceability_vs_genre.png
│       └── top_artists_barplot.png

├── README.md
