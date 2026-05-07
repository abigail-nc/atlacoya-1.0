# Este script:
# Crea mapas para la región de estudio, específicamente para el análisis geográfico de la zona
# Por ello, los mapas generados son:
## Mapa de la zona de estudio + ANP + estaciones
## Mapa de clima por humedad
## Mapa de clima Köppen
## Mapa de hidrografia (cuencas y rios)
## Mapa de edafología
## Mapa de Uso de suelo

#PREPARAR AMBIENTE
#getwd()
setwd("C:/Users/gab/Documents/phd_pico")
library(ggplot2)
library(sf)
library(terra)
library(patchwork)
library(ggspatial)


# ------------------
# EXTRAER ZIPs
# ------------------
#####################################SOLO EJECUTAR UNA VEZ
#unzip("./.area_estudio/anpsp2024gw.zip")
#unzip("./.area_estudio/Climas_1mgw.zip")
#unzip("./.area_estudio/cuenc4mgw.zip")
#unzip("./.area_estudio/edafologoia_4mgw.zip")
#unzip("./.area_estudio/humed4mgw.zip")
#unzip("./.area_estudio/nalcmsmx20gw.zip")
#unzip("./.area_estudio/Regiones-hidrologicas_4mgw.zip")
#unzip("./.area_estudio/usv250s7gw_INEGI_SERIE7.zip")


# ------------------
# LECTURA DE ARCHIVOS
# ------------------
dest <- st_read("./.area_estudio/dest24gw.shp") #div estat
anp<- st_read("./.area_estudio/anpsp2024gw.shp")
koppen<- st_read("./.area_estudio/Clima1mgw.shp")
cuencas<- st_read("./.area_estudio/cuenc4mgw.shp")
edafo<- st_read("./.area_estudio/edafo4mgw.shp")
humedad<- st_read("./.area_estudio/humed4mgw.shp")
hidro<- st_read("./.area_estudio/hidro4mgw.shp")
usosuelo<- st_read("./.area_estudio/usv250s7gw.shp")
dom50 <- st_read("./.area_estudio/Dom50km.kml") #primero se descomprimió con unzip en bash
estacs50op <- st_read("./.area_estudio/operativas_50km.shp")
estacs50su <- st_read("./.area_estudio/suspendidas_50km.shp")


# -----------------
# AJUSTE DEL KML
# -----------------
#referencia coords. de shp
crs_mx <- st_crs(dest) 

sf_use_s2(FALSE)
#convertir coordenadas
dom50 <- st_union(dom50) #para tener solo el contorno y no hacernos bolas con las capas del kml
dom50 <- st_transform(dom50, crs = (crs_mx)) #convertir al mismo sistema de coordenadas

#seleccionar el ANP Pico
anpp <- anp[80,]

koppen <- st_transform(koppen, crs_mx)
cuencas <- st_transform(cuencas, crs_mx)
edafo <- st_transform(edafo, crs_mx)
humedad <- st_transform(humedad, crs_mx)
hidro <- st_transform(hidro, crs_mx)
usosuelo <- st_transform(usosuelo, crs_mx)

# -----------------
# CORTAR SHPS AL DOMINIO (50.KML)
# -----------------
dest50 <- st_intersection(dest,dom50)
anp50  <- st_intersection(anp,dom50)
koppen50 <- st_intersection(koppen,dom50)
cuencas50 <- st_intersection(cuencas,dom50)
edafo50 <- st_intersection(edafo,dom50)
humedad50 <- st_intersection(humedad,dom50)
hidro50 <- st_intersection(hidro,dom50)
usosuelo50 <- st_intersection(usosuelo,dom50)



# -----------------
# CORTAR SHPS AL ANP
# -----------------
destanp <- st_intersection(dest,anpp) #[3]
anpanp  <- st_intersection(anp,anpp)
koppenanp <- st_intersection(koppen,anpp) #CLIMA_TIPO
cuencasanp <- st_intersection(cuencas,anpp) #NOMBRE
edafoanp <- st_intersection(edafo,anpp)
humedadanp <- st_intersection(humedad,anpp) #"TIPO"
hidroanp <- st_intersection(hidro,anpp) ###
usosueloanp <- st_intersection(usosuelo,anpp["NOMBRE"]) #[1]
sf_use_s2(TRUE)

# -----------------
# GRAFICAS
# -----------------

#PLOTEO DE CONTROL
plot(usosueloanp)
ggplot(usosueloanp)+
  geom_sf(data = usosueloanp, aes(fill = DESCRIPCIO), alpha = 0.8)+
    theme_void()
    
ggplot(koppenanp)+
  geom_sf(aes(fill = as.factor(CLIMA_TIPO)), color = "white", linewidth = NA)+
  scale_fill_viridis_d(option = "viridis", name = "Tipos de clima Köppen") +
  theme_minimal()

#------
# DOM EN MÉXICO
#------
dom_mx <- ggplot()+
  geom_sf(data = dest, fill = "gray", color = "white", alpha = 0.8) +
  geom_sf(data = dom50, fill = NA, color = "black", linewidth = 1) +
  theme_minimal()+
   theme(panel.grid.major = element_line(color = "gray70", size = 0.2), panel.ontop = TRUE)

#-----
# DATOS EN EL ANP
#-----
datamaps <- theme(
            panel.border = element_rect(color = "black", fill = NA, linewidth = 1),
            axis.ticks = element_line(color = "black", linewidth = 0.5),
            axis.text.y = element_text(size = 14, margin = margin(r = 5)),
            axis.text.x.top = element_text(size = 14, margin = margin(b = 5)),
            
            legend.position = "inside",
            legend.position.inside = c(0.15, 0.7),
            legend.title      = element_text(size = 18, face = "bold"),
            legend.text       = element_text(size = 12),
            legend.key.size   = unit(1, "cm"),      # Tamaño del cuadrito de color
            legend.spacing.y  = unit(0.3, "cm"),    # Espacio vertical entre categorías
            
            panel.grid.major = element_line(color = "gray89", size = 0.2),
            panel.ontop = TRUE
            )


data_mapa <- ggplot() +
  geom_sf(data =koppenanp, aes(fill = CLIMA_TIPO), color = NA) + 
  geom_sf(data = destanp, fill = NA, color = "gray", linewidth = 1) +
  scale_fill_viridis_d(option = "viridis", name = "Clima") +
  
  coord_sf(datum = st_crs(4326)) +
  coord_sf(label_axes = list(top = "E", left = "N")) +
  
  theme_minimal() + datamaps

#-------
# DATOS DOM 50
#-------

dom50_map <- ggplot() +
  geom_sf(data =koppen50, aes(fill = CLIMA_TIPO), color = NA) + 
  geom_sf(data = dest50, fill = NA, color = "white", linewidth = 1) +
  scale_fill_viridis_d(option = "viridis", name = "Clima") +
  
  coord_sf(datum = st_crs(4326)) +
  coord_sf(label_axes = list(top = "E", left = "N")) +

  theme_minimal() + datamaps +theme(legend.position = "none")

library(patchwork)

panel <- (data_mapa | (dom_mx / dom50_map))
panel

ggsave(
  filename = "./v2_climaskoppen.png", 
  plot = panel,
  width = 11,           # Ancho en pulgadas
  height = 8.5,         # Alto en pulgadas
  units = "in",         # Especifica que son pulgadas
  dpi = 300             # Alta resolución para impresión
)
