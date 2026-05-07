#---------------
# MAPAS DE CALOR

### PRCP
#---

#---
setwd("C:/Users/gab/Pictures/descarga_limpiezaSMN")
#---

#Cargar librerias
library(tidyverse)
library(lubridate)
library(ggplot2)

edo <- "ags"

#Rutas de archivos
inpath <- paste0("./OUTPUT/01_LIMPIOS/",edo)
outpath <- "./OUTPUT/"
nombre_salida <- paste0("01-Explor-",edo,".csv")



main_prcp <- read.csv2("../1_OUTPUTS/v2_PRECIP_SMNdb.csv")

#tabla de datos a matriz true vs false
prcp_dispo <- main_prcp %>%
  pivot_longer(cols = !FECHA, 
               names_to = "id_estacion", 
               values_to = "valor") %>%
  # Paso crucial: convertir a formato fecha
  mutate(FECHA = as.Date(FECHA), 
         Estado = if_else(is.na(valor), "Faltante (NA)", "Disponible"))

#graficar
ggplot(prcp_dispo, aes(x = FECHA, y = id_estacion, fill = Estado)) +
  geom_raster() +
  scale_x_date(date_breaks = "10 year", date_labels = "%Y") +
  scale_fill_manual(values = c("Disponible" = "#578ccb", 
                               "Faltante (NA)" = "#fffaef")) +
  theme_minimal() +
  labs(title = "Mapa de disponibilidad de datos de precipitación",
       subtitle = "Análisis de 106 estaciones",
       x = "Año", y = "Estación", fill = "Estado") +
  theme(
    axis.text.y = element_text(size = 2.5), # Un poco más pequeño para evitar traslape
    axis.ticks.y = element_blank(),
    panel.grid = element_blank(), # Limpia el fondo para que resalten los cuadros
    legend.position = "bottom"
  )
  
  ggsave(paste0("../1_OUTPUTS/v2_heatmapDispo_PRCP.png"), width = 14, height = 22, dpi = 300, bg="#ffffff")

### TMAX
#------
main_tmax <- read.csv2("../1_OUTPUTS/v2_TMAX_SMNdb.csv")

#tabla de datos a matriz true vs false
tmax_dispo <- main_tmax %>%
  pivot_longer(cols = !FECHA, 
               names_to = "id_estacion", 
               values_to = "valor") %>%
  # Paso crucial: convertir a formato fecha
  mutate(FECHA = as.Date(FECHA), 
         Estado = if_else(is.na(valor), "Faltante (NA)", "Disponible"))

#graficar
ggplot(tmax_dispo, aes(x = FECHA, y = id_estacion, fill = Estado)) +
  geom_raster() +
  scale_x_date(date_breaks = "10 year", date_labels = "%Y") +
  scale_fill_manual(values = c("Disponible" = "#EC5e27", 
                               "Faltante (NA)" = "#fffaef")) +
  theme_minimal() +
  labs(title = "Mapa de disponibilidad de datos de temp. max",
       subtitle = "Análisis de 106 estaciones",
       x = "Año", y = "Estación", fill = "Estado") +
  theme(
    axis.text.y = element_text(size = 2.5), # Un poco más pequeño para evitar traslape
    axis.ticks.y = element_blank(),
    panel.grid = element_blank(), # Limpia el fondo para que resalten los cuadros
    legend.position = "bottom"
  )
  
  ggsave(paste0("../1_OUTPUTS/v2_heatmapDispo_TMAX.png"), width = 14, height = 22, dpi = 300, bg="#ffffff")


### TMIN
#-------
main_tmin <- read.csv2("../1_OUTPUTS/v2_TMIN_SMNdb.csv")

#tabla de datos a matriz true vs false
tmin_dispo <- main_tmin %>%
  pivot_longer(cols = !FECHA, 
               names_to = "id_estacion", 
               values_to = "valor") %>%
  # Paso crucial: convertir a formato fecha
  mutate(FECHA = as.Date(FECHA), 
         Estado = if_else(is.na(valor), "Faltante (NA)", "Disponible"))

#graficar
ggplot(tmin_dispo, aes(x = FECHA, y = id_estacion, fill = Estado)) +
  geom_raster() +
  scale_x_date(date_breaks = "10 year", date_labels = "%Y") +
  scale_fill_manual(values = c("Disponible" = "#4a69b3", 
                               "Faltante (NA)" = "#fffaef")) +
  theme_minimal() +
  labs(title = "Mapa de disponibilidad de datos de temp. min.",
       subtitle = "Análisis de 106 estaciones",
       x = "Año", y = "Estación", fill = "Estado") +
  theme(
    axis.text.y = element_text(size = 2.5), # Un poco más pequeño para evitar traslape
    axis.ticks.y = element_blank(),
    panel.grid = element_blank(), # Limpia el fondo para que resalten los cuadros
    legend.position = "bottom"
  )
  
  ggsave(paste0("../1_OUTPUTS/v2_heatmapDispo_TMIN.png"), width = 14, height = 22, dpi = 300, bg="#ffffff")




