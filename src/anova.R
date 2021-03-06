library(lsr)
library(lmtest)
library(ggplot2)
library(gridExtra)

armar_tabla <- function(datos)
{
  danceabilidad <- datos$Danceability
  colaboracion <- datos$Colaboration
  genero <- datos$MusicalGender
  datos <- data.frame(danceabilidad = danceabilidad, colaboracion = colaboracion, 
                      genero = genero)
  
  return(datos)
}

# Importamos los datos a analizar
datos <- read.table(file.choose(), header = TRUE)
#head(datos)

# Nos quedamos solo con las variables necesarias
datos <- armar_tabla(datos)
#head(datos)

# Graficamos los gr�ficos de cajas y bigotes
ggplot(data = datos, aes(x = colaboracion, y = danceabilidad, color = colaboracion)) + 
  geom_boxplot() + 
  labs(title = "", x = "colaboraci�n", y = "danceabilidad", 
       color = "colaboraci�n") + 
  theme_bw()
ggplot(data = datos, aes(x = genero, y = danceabilidad, color = genero)) +
  geom_boxplot() + 
  labs(title = "", x = "g�nero", y = "danceabilidad", color = "g�nero") + 
  theme_bw()
ggplot(data = datos, aes(x = colaboracion, y = danceabilidad, color = genero)) +
  geom_boxplot() + 
  labs(title = "", x = "colaboraci�n", y = "danceabilidad", color = "g�nero") + 
  theme_bw()

# Hallamos la media y la desviaci�n est�ndar para cada par de variables
with(data = datos,expr = tapply(danceabilidad, colaboracion, mean))
with(data = datos,expr = tapply(danceabilidad, colaboracion, sd))

with(data = datos,expr = tapply(danceabilidad, genero, mean))
with(data = datos,expr = tapply(danceabilidad, genero, sd))

with(data = datos,expr = tapply(danceabilidad, list(colaboracion, genero), mean))
with(data = datos,expr = tapply(danceabilidad, list(colaboracion, genero), sd))

# Ploteamos los gr�ficos de interacci�n
ggplot(data = datos, aes(x = colaboracion, y = danceabilidad, colour = genero,
                         group = genero)) +
  stat_summary(fun.y = mean, geom = "point") +
  stat_summary(fun.y = mean, geom = "line") +
  labs(title = "", x = "colaboraci�n", y = "media de danceabilidad", 
       colour = "g�nero") +
  theme_bw()

ggplot(data = datos, aes(x = genero, y = danceabilidad, colour = colaboracion,
                         group = colaboracion)) +
  stat_summary(fun.y = mean, geom = "point") +
  stat_summary(fun.y = mean, geom = "line") +
  labs(title = "", x = "g�nero", y = "media de danceabilidad", 
       colour = "colaboraci�n") +
  theme_bw()

# ANOVA
anova <- aov(danceabilidad ~ colaboracion * genero, data = datos)
summary(anova)

etaSquared(anova)

# Calculando los residuales
residuales <- anova$residuals

# Analizando el supuesto de normalidad
qqnorm(residuales)
qqline(residuales)

# Esto no es necesario ya que se puede saber a partir de los gr�ficos anteriores
shapiro.test(residuales)

# Plotemamos el histograma de residuos
hist(residuales, xlab = "residuos", ylab = "frecuencias", 
     main = "Histograma de residuos")

# Analizamos el supuesto de varianza constante
plot(anova$fitted.values, rstudent(anova), xlab = "predicciones",
     ylab = "residuales studentnizados", main = "ANOVA Residuos studentnizados")

# Esto no es necesario ya que se puede saber a partir del grafico anterior
bartlett.test(residuales, colaboracion)
bartlett.test(residuales, datos$genero)

# Prueba de independencia
dwtest(anova)

