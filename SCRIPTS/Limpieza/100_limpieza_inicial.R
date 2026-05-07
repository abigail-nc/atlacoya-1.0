# Este script:
## 0. lee los archivos tal cual vienen descargados del SMN (climat. diaria)
## 1. Sustituye los NULOS por NA y elimina la columna de avap
## 2. Prueba los límites físicos de temperatura y precipitación
#     O sea, tmax no puede ser menor a tmin, prcp no puede ser negativa
## 3. Guarda todo en archivos CSV individuales

#---
setwd("C:/Users/gab/Pictures/descarga_limpiezaSMN/")
#---

######
# CARGA DE LIBRERIAS
#install.packages("tidyverse")
#install.packages("lubridate")
library(tidyverse)
library(lubridate)

##############################################
# POR FAVOR, SOLO EDITA LAS SIGUIENTES DOS LÍNEAS CON TUS RUTAS 
##############################################

#RUTAS
inpath  <- "./OUTPUT/00_RAW/ags"
outpath <- "./OUTPUT/01_LIMPIOS/ags"


#BUCLE
# ---- 1. LEER ARCHIVOS ----
archivos <- list.files(inpath, 
                       pattern = "\\.txt", 
                       full.names = TRUE)

for (i in archivos){
  # ---- LEER, NOMBRAR COLUMNAS, ELIMINAR EVAP, NA POR NULOS
  datos <- read.table(i,
                     header = FALSE,
                     quote = "\"",
                     skip = 25)
  colnames(datos)<-c("FECHA", "PRECIP", "EVAP", "TMAX", "TMIN")
  
  datos$EVAP <- NULL
  datos$PRECIP[datos$PRECIP=="NULO"]<-NA
  datos$TMAX[datos$TMAX == "NULO"]<-NA
  datos$TMIN[datos$TMIN=="NULO"]<-NA
  
  datos$FECHA <- as.Date(datos$FECHA)
  datos$PRECIP <- as.numeric(datos$PRECIP)
  datos$TMAX <- as.numeric(datos$TMAX)
  datos$TMIN <- as.numeric(datos$TMIN)

  #---- PROBAR LÍMITES FÍSICOS
  #tmax no puede ser menor que tmin
  errortemp<-!is.na(datos$TMAX) & !is.na(datos$TMIN) & (datos$TMAX < datos$TMIN)
  datos$TMAX[errortemp]<-NA
  datos$TMIN[errortemp]<-NA
  
  #precip no puede ser negativa
  errorprecip<-!is.na(datos$PRECIP) & (datos$PRECIP<0)
  datos$PRECIP[errorprecip] <- NA
  
  #---- GRABAR ARCHIVOS
  nombre_base <- basename(i)
  nombre_salida <- gsub("\\.txt$", ".csv", nombre_base)
  ruta_salida <- file.path(outpath, nombre_salida)
  
  write.csv2(datos, ruta_salida, quote = FALSE, na = "NA", row.names = FALSE)
  
  # Mensaje opcional para saber que está trabajando
  message("✅ Estación ", nombre_base, " procesada y guardada en ", outpath, ". Verifica la salida")
}



####################################
#  EL CÓDIGO SIGUIENTE NO SE DEBE EJECUTAR
# SOLO ES LA BASE DEL PROCESO ANTERIOR 
####################################
######
# PASO 1: Leer archivos, corregir NULOs y eliminar EVAP
#####
dia21020 <- read.table("./0_INPUT/orig_txt/dia21020.txt",
                         header=FALSE, 
                         quote="\"", 
                         skip = 25)
colnames(dia21020) <- c("FECHA", "PRECIP", "EVAP", "TMAX", "TMIN")
dia21020$EVAP<-NULL
dia21020$PRECIP[dia21020$PRECIP=="NULO"]<-NA
dia21020$TMAX[dia21020$TMAX == "NULO"]<-NA
dia21020$TMIN[dia21020$TMIN=="NULO"]<-NA

dia21020$FECHA <- as.Date(dia21020$FECHA)
dia21020$PRECIP <- as.numeric(dia21020$PRECIP)
dia21020$TMAX <- as.numeric(dia21020$TMAX)
dia21020$TMIN <- as.numeric(dia21020$TMIN)

#####
# PASO 2: PRUEBA DE LÍMITES FÍSICOS
#####

#tmax no puede ser menor que tmin
errortemp<-!is.na(dia21020$TMAX) & !is.na(dia21020$TMIN) & (dia21020$TMAX < dia21020$TMIN)
dia21020$TMAX[errortemp]<-NA
dia21020$TMIN[errortemp]<-NA

#precip no puede ser negativa
errorprecip<-!is.na(dia21020$PRECIP) & (dia21020$PRECIP<0)
dia21020$PRECIP[errorprecip] <- NA

write.csv2(dia21020,"../dia21020_v2.csv", quote =FALSE, sep=";",na="NA", col.names = TRUE, row.names = FALSE)








