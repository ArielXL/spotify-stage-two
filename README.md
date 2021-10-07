# Informe escrito

## Autores

|  **Nombre(s) y Apellidos**   |              **Correo**              |                          **GitHub**                          |
| :--------------------------: | :----------------------------------: | :----------------------------------------------------------: |
| Carlos Aryam Martínez Molina |  c.molina@estudiantes.matcom.uh.cu   | [@carlosmartinezmolina](https://github.com/carlosmartinezmolina) |
|      Eziel Ramos Piñón       |   e.ramos@estudiantes.matcom.uh.cu   |         [@ezielramos](https://github.com/ezielramos)         |
|     Ariel Plasencia Díaz     | a.plasencia@estudiantes.matcom.uh.cu |            [@ArielXL](https://github.com/ArielXL)            |

## Resumen

El objetivo de este trabajo es, a partir de un conjunto de datos que coincide con las 50 mejores canciones de la aplicación Spotify, realizar un estudio estadístico aplicando las técnicas de regresión lineal simple y múltiple, análisis de varianza y de reducción de dimensiones para llegar a conclusiones precisas sobre características y propiedades de las canciones antes mencionadas.

En nuestro conjunto de datos predominan los datos cuantitativos, por lo que nos dimos la libertad de insertar algunas variables cualitativas con el fin de tener mayores argumentos a la hora de comparar nuestras canciones. Entre las observaciones agregadas y usadas principalmente a partir del capítulo 5 tenemos la *Colaboración* que representa la existencia o no de múltiples cantantes, el *Año de Nacimiento*, el *Género Musical* constituido por los valores pop, reggaeton y otros y el *Tamaño de la canción* que denota si el tema es corto o largo en dependencia de si la duración es menor al promedio de los segundos de todas las canciones. Para llevar a cabo lo explicado anteriormente nos apoyaremos en el lenguaje de programación [R](https://es.wikipedia.org/wiki/R_(lenguaje_de_programaci%C3%B3n)), el cual fue diseñado por [Ross Ihaka](https://en.wikipedia.org/wiki/Ross_Ihaka) y [Robert Gentleman](https://en.wikipedia.org/wiki/Robert_Gentleman_(statistician)) en 1933 y es muy utilizado en nuestros días para la investigación por la comunidad estadística, en el campo de la minería de datos, la investigación biomédica, la bioinformática y las matemáticas financieras. Para todo este análisis tomaremos un nivel de significación de 0.05 y es necesario mencionar que nos apoyamos en librerías que nos provee el lenguaje R, entre las que se encuentran lmtest, ggplot2, car, factoextra, cluster, purrr, gridExtra, lsr y psych utilizadas fundamentalmente para el análisis de los supuestos, para plotear los gráficos y la confección de clústeres.

Para una explicación y análisis más detallada de nuestros objetivos propuestos consulte nuestro [Informe Escrito](./doc/report.pdf).