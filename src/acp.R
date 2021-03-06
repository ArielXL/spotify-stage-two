eliminar_variables <- function(datos)
{
  datos <- datos[, -18]
  datos <- datos[, -17]
  datos <- datos[, -16]
  datos <- datos[, -15]
  datos <- datos[, -14]
  datos <- datos[, -3]
  datos <- datos[, -2]
  datos <- datos[, -1]
  
  return(datos)
}

# Importamos los datos a analizar
datos <- read.table(file.choose(), header = TRUE)

# Quitamos algunas variables
datos <- eliminar_variables(datos)
head(datos)

# Resumen de los datos
summary(datos)

# Matriz de correlaci�n
m <- cor(datos)
print(m)

# Correlaci�n de las variables de la muestra
pairs(datos, main = "Correlaci�n de las variables de la muestra")

# Matriz de correlaci�n en forma gr�fica
symnum(m)

# An�lisis de componentes principales
acp <- prcomp(datos, scale = TRUE)
summary(acp)

# Gr�ficos
plot(acp, main = "Plot de componentes principales")
biplot(acp)

# Varianza de cada componente
print(acp$sdev)

# Matriz de los valores propios
print(acp$rotation)

