library(lmtest)
library(ggplot2)

# Importamos los datos a analizar
datos <- read.table(file.choose(), header = TRUE)
#head(datos)

# Graficamos el diagrama de dispersión
ggplot(data = datos, mapping = aes(x = datos$Speechiness, 
                                   y = datos$Beats_Per_Minute)) + 
  geom_point(color = "firebrick", size = 2) +
  labs(title = "Diagrama de dispersión", x = "cantidad de texto hablado", 
       y = "golpes por minutos") +
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5))

# Hacemos el test de correlación mediane el método de Pearson
cor.test(x = datos$Speechiness, y = datos$Beats_Per_Minute, method = "pearson")

# Calculamos del modelo de regresión lineal simple
regresion_lineal <- lm(datos$Beats_Per_Minute ~ datos$Speechiness, data = datos)
summary(regresion_lineal)

# Hallamos los intervalos de confianza
confint(regresion_lineal)

# Representación del gráfico del modelo de regresión lineal
ggplot(data = datos, mapping = aes(x = datos$Speechiness, 
                                   y = datos$Beats_Per_Minute)) +
  geom_point(color = "firebrick", size = 2) +
  labs(title = "Diagrama de dispersión", x = "cantidad de texto hablado", 
       y = "golpes por minutos") +
  geom_smooth(method = "lm", se = FALSE, color = "black", formula = "y ~ x") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

# Diagrama de dispersión con intervalos de confianza
ggplot(data = datos, mapping = aes(x = datos$Speechiness, 
                                   y = datos$Beats_Per_Minute)) +
  geom_point(color = "firebrick", size = 2) +
  labs(title = "Diagrama de dispersión", x = "cantidad de texto hablado", 
       y = "golpes por minuto") +
  geom_smooth(method = "lm", se = TRUE, color = "black", formula = "y ~ x") +
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5))

# Análisis de los supuestos
datos$Prediccion <- regresion_lineal$fitted.values
datos$Residuos <- regresion_lineal$residuals
#head(datos)

# Graficamos la distribución de los residuos
ggplot(data = datos, aes(x = datos$Prediccion, y = datos$Residuos)) +
  geom_point(aes(color = datos$Residuos)) +
  scale_color_gradient2(low = "blue3", mid = "grey", high = "red") +
  geom_hline(yintercept = 0) +
  geom_segment(aes(xend = datos$Prediccion, yend = 0), alpha = 0.2) +
  labs(title = "Distribución de los residuos", x = "predicción del modelo",
       y = "residuos") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), legend.position = "none")

# Ploteamos el histograma de los residuos
ggplot(data = datos, aes(x = datos$Residuos)) +
  geom_histogram(aes(y = ..density..)) +
  labs(title = "Histograma de los residuos", x = "residuos", y = "densidad") +
  theme_light()

qqnorm(regresion_lineal$residuals)
qqline(regresion_lineal$residuals)

shapiro.test(regresion_lineal$residuals)

# Verificamos la homogeneidad de los residuos
ggplot(data = datos, aes(x = datos$Prediccion, y = datos$Residuos)) +
  geom_point(aes(color = datos$Residuos)) +
  scale_color_gradient2(low = "blue3", mid = "grey", high = "red") +
  geom_segment(aes(xend = datos$Prediccion, yend = 0), alpha = 0.2) +
  geom_smooth(se = FALSE, color = "firebrick", method = "loess", 
              formula = "y ~ x") +
  labs(title = "Distribución de los residuos", x = "predicción del modelo",
       y = "residuos") +
  geom_hline(yintercept = 0) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), legend.position = "none")

bptest(regresion_lineal)

dwtest(regresion_lineal)