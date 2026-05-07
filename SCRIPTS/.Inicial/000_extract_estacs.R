
setwd("C:/Users/gab/Pictures/descarga_limpiezaSMN")

library(ggplot2)
library(sf)
library(terra)

#Abrir archivo




write.csv2(estacsClimat$Name, "./INPUT/listEstacs.csv", quote = FALSE, na = "NA", row.names = FALSE)
