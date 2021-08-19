library(car)
library(psych)
library(lmtest)
library(ggplot2)
library(gridExtra)

quitar_variables_cualitativas <- function(datos)
{
  datos <- datos[, -18]
  datos <- datos[, -17]
  datos <- datos[, -16]
  datos <- datos[, -14]
  datos <- datos[, -3]
  datos <- datos[, -2]
  datos <- datos[, -1]
  
  return(datos)
}

# Importamos los datos a analizar
datos <- read.table(file.choose(), header = TRUE)

# Quitamos las variables cualitativas
datos <- quitar_variables_cualitativas(datos)
#str(datos)
#head(datos)

# Calculamos el coeficiente de correlación para cada par de variables
round(cor(x = datos, method = "pearson"), 3)

# Graficamos la relación entre las variables
multi.hist(x = datos, dcol = c("blue", "red"), dlty = c("dotted", "solid"),
           main = "")

# Generamos el modelo de regresión múltiple
modelo <- lm(datos$Energy ~ datos$Beats_Per_Minute + datos$Danceability + 
             datos$Loudness.dB. + datos$Length + datos$Valence + 
             datos$Liveness + datos$Acousticness + datos$Speechiness + 
             datos$Popularity, data = datos )
summary(modelo)

# Seleccionamos los mejores predictores
step(object = modelo, direction = "both", trace = 1)

# El mejor modelo resultante del proceso de selección es
modelo <- lm(datos$Energy ~ datos$Loudness.dB. + datos$Valence +
             datos$Acousticness, data = datos)
summary(modelo)

# Hallamos los intervalos de confianzas
confint(lm(formula = datos$Energy ~ datos$Loudness.dB. + datos$Valence + 
                     datos$Acousticness, data = datos))

# Validación de condiciones para la regresión múltiple lineal
plot1 <- ggplot(data = datos, aes(datos$Loudness.dB., modelo$residuals)) + 
  geom_point() + 
  labs(title = "", x = "sonoridad", y = "residuos") + 
  geom_smooth(formula = "y ~ x", method = "loess", color = "firebrick") + 
  geom_hline(yintercept = 0) + 
  theme_bw()
plot2 <- ggplot(data = datos, aes(datos$Valence, modelo$residuals)) +
  geom_point() + 
  labs(title = "", x = "positividad", y = "residuos") + 
  geom_smooth(formula = "y ~ x", method = "loess", color = "firebrick") + 
  geom_hline(yintercept = 0) + 
  theme_bw()
plot3 <- ggplot(data = datos, aes(datos$Acousticness, modelo$residuals)) +
  geom_point() + 
  labs(title = "", x = "acústica", y = "residuos") + 
  geom_smooth(formula = "y ~ x", method = "loess", color = "firebrick") + 
  geom_hline(yintercept = 0) + 
  theme_bw()
grid.arrange(plot1, plot2, plot3)

# Analizamos los supuestos mediante los residuos
qqnorm(modelo$residuals)
qqline(modelo$residuals)

shapiro.test(modelo$residuals)

ggplot(data = datos, aes(modelo$fitted.values, modelo$residuals)) +
  geom_point() +
  geom_smooth(formula = "y ~ x", method = "loess", color = "firebrick", 
              se = FALSE) +
  geom_hline(yintercept = 0) +
  theme_bw()

bptest(modelo)

dwtest(modelo)
