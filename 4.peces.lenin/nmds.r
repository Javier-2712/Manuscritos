# Ajuste de datos
# la matriz "biol" presenta columnas con solo ceros, se procesan a continuación, para filtrarlas del análisis NMDS

library(readxl); library(vegan)
biol <- read_excel("biol.xlsx")
mat <- as.matrix(biol[ , -c(1:8)])


# 2) Extrae sólo la matriz de especies/índices
biol2 <- as.matrix(biol[ , -c(1:8)])  

# 3) Desplazar para que todo sea ≥ 0 (si hay negativos)
minval <- min(biol2, na.rm = TRUE)
if (minval < 0) {
  biol2 <- biol2 - minval
}

# 4) Filtra columnas constantes (varianza = 0)
vars <- apply(biol2, 2, var, na.rm = TRUE)
biol2 <- biol2[ , vars > 0 ]

# 5) Filtra filas vacías (todas ceros)
biol2 <- biol2[ apply(biol2, 1, function(x) any(x != 0)), ]