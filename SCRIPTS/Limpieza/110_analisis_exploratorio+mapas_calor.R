# Este script:
## 1. Lee los archivos generados en el script 0_limpieza_inicial.R (106 csv)
## 2. Para cada estación, cálcula:
      # Fecha más antigua
      # Fecha más reciente 
      # Número de días
      # Cantidad de NA de precip
      # Cantidad de NA de tmax
      # Cantidad de NA de tmin
## 3. Devueleve un solo CSV con dichas especificaciones por cada estación
## 4. Genera un CSV con los registros de prcp
##  . Genera un mapa de calor de disponibilidad de datos de prcp
## 5. Genera un csv con los registro de tmax
##  . Genera un mapa de calor de disponibilidad de datos de tmax
## 6. Genera un csv con los registros de tmin
##  . Genera un mapa de calor de disponibilidad de datos de tmin

#---
setwd("C:/Users/gab/Pictures/descarga_limpiezaSMN")
#---

#Cargar librerias
library(tidyverse)
library(lubridate)
library(ggplot2)

edo <- "bc"
gc()

#Rutas de archivos
inpath <- paste0("./OUTPUT/01_LIMPIOS/",edo)
outpath <- "./OUTPUT/"
nombre_salida <- paste0("01-Explor-",edo,".csv")


#### LOOP
#----------------
archivos <- list.files(inpath, pattern = "\\.csv", full.names = TRUE)
resume_db <- data.frame()

for(i in archivos){
  df_temp <- read.csv2(i)
  df_temp$FECHA<-as.Date(df_temp$FECHA)
  nombre_estac <- gsub("\\.csv", "", basename(i))
  
  #INICIAN CUENTAS
  antiguo <- min(df_temp$FECHA, na.rm = TRUE)
  reciente <- max(df_temp$FECHA, na.rm = TRUE)
  dias <- nrow(df_temp)
  
  nas_prcp <- as.numeric(sum(is.na(df_temp$PRECIP)))
  nas_tmax <- as.numeric(sum(is.na(df_temp$TMAX)))
  nas_tmin <- as.numeric(sum(is.na(df_temp$TMIN)))
  
  nap_prcp <- round((nas_prcp/dias)*100, digits = 4)
  nap_tmax <- round((nas_tmax/dias)*100 , digits =4)
  nap_tmin <- round((nas_tmin/dias)*100 , digits =4)
  
  # Crear el resumen en un dataframe
  row_data <- data.frame(
    ID_ESTAC   = nombre_estac,
    FECHA_MIN  = antiguo,
    FECHA_MAX  = reciente,
    TOTAL_DIAS = dias,
    NA_PRECIP  = nas_prcp,
    NA_TMAX    = nas_tmax,
    NA_TMIN    = nas_tmin,
    PCT_NA_PRCP = nap_prcp,
    PCT_NA_TMAX = nap_tmax,
    PCT_NA_TMIN = nap_tmin
  )
  
  #se apilan filas
  resume_db <- rbind(resume_db, row_data)
  
  message("Ocupado con la estación: ", nombre_estac)
}

View(resume_db)
write.csv2(resume_db, paste0(outpath,"02_AnalisisExplor/" ,nombre_salida), quote = FALSE, na = "NA", row.names = FALSE)


# NO EJECUTAR!!!!!!!!! ES SOLO LA BASE 
# DEBAJO DE ESTE BLOQUE ESTÁ EL CÓDIGO PARA LAS GRÁFICAS DE MAPAS DE CALOR y EXTRACC DE VARS
### SINGLE TEST
#----------------
dia21020 <- read.csv2("../0_INPUT/cleaned_smn/dia21020_v2.csv")

antiguo <- min(dia21020$FECHA, na.rm = TRUE)
reciente <- max(dia21020$FECHA, na.rm = TRUE)
dias <- as.numeric(count(dia21020, "FECHA"))
nas_prcp <- as.numeric(sum(is.na(dia21020$PRECIP)))
nas_tmax <- as.numeric(sum(is.na(dia21020$TMAX)))
nas_tmin <- as.numeric(sum(is.na(dia21020$TMIN)))

nap_prcp <- round((nas_prcp/dias)*100, digits = 4)
nap_tmax <- round((nas_tmax/dias)*100 , digits =4)
nap_tmin <- round((nas_tmin/dias)*100 , digits =4)

# Crear el resumen en un dataframe
resumen_calidad <- data.frame(
  ESTACION   = "dia21020",
  FECHA_MIN  = antiguo,
  FECHA_MAX  = reciente,
  TOTAL_DIAS = dias,
  NA_PRECIP  = nas_prcp,
  NA_TMAX    = nas_tmax,
  NA_TMIN    = nas_tmin,
  PCT_NA_PRCP = nap_prcp,
  PCT_NA_TMAX = nap_tmax,
  PCT_NA_TMIN = nap_tmin
)

# Ver la tabla en consola
print(resumen_calidad)


#----------------
# EXTRACCION DE DBs POR VARIABLE Y MAPA DE CALOR
#----------------
extrac_vars <- function(archivos_list, var){
  main_table <- NULL
  
  for (i in archivos_list){
    temp_df <- read.csv2(i)
    id_estac <- gsub("\\.csv","", basename(i))
    
    temp_var <- temp_df[,c("FECHA", var)]
    colnames(temp_var) <- c("FECHA", id_estac)
    
    if (is.null(main_table)) {
      main_table <- temp_var
    } else {
      # Unimos por FECHA para asegurar que los días coincidan perfectamente
      main_table <- merge(main_table, temp_var, by = "FECHA", all = TRUE)
    }
  }
  return(main_table)
}


#PARA PRECIP
main_precip <-extrac_vars(archivos, "PRECIP")
write.csv2(main_precip, paste0(outpath, "04_Datasets/PRECIP/",edo,"-Dataset-PRECIP.csv"),quote = FALSE, na = "NA", row.names = FALSE)

#PARA TMAX
main_tmax <- extrac_vars(archivos, "TMAX")
write.csv2(main_tmax, paste0(outpath, "04_Datasets/TMAX/",edo,"-Dataset-TMAX.csv"),quote = FALSE, na = "NA", row.names = FALSE)

# PARA TMIN
main_tmin <- extrac_vars(archivos, "TMIN")
write.csv2(main_tmin, paste0(outpath, "04_Datasets/TMIN/",edo,"-Dataset-TMIN.csv"),quote = FALSE, na = "NA", row.names = FALSE)

