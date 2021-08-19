library(purrr)
library(ggplot2)
library(cluster)
library(factoextra)

ac <- function(metodo)
{
  agnes(datos, method = metodo)$ac
}

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

# Escalamos todas las variables numéricas
datos <- scale(datos)

d <- dist(datos, method = "euclidean")
hc1 <- hclust(d, method = "complete" )
plot(hc1, cex = 0.6, hang = -1, main = "", xlab = "", ylab = "")

hc2 <- agnes(datos, method = "complete")
hc2$ac

metodos <- c("average", "single", "complete", "ward")
names(metodos) <- c("average", "single", "complete", "ward")
map_dbl(metodos, ac)

hc3 <- agnes(datos, method = "ward")
pltree(hc3, cex = 0.6, hang = -1, main = "", xlab = "", ylab = "")

pltree(hc3, hang = -1, cex = 0.6)
rect.hclust(hc3, k = 3, border = 2:10)

cluster_kmeans <- kmeans(datos, 3, nstart = 50)
fviz_cluster(cluster_kmeans, data = datos, frame.type = "convex")

cluster_pam <- pam(datos, 3)
fviz_cluster(cluster_pam)