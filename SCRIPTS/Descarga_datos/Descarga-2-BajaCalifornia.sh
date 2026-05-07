#!/bin/bash

# Lista de códigos de estaciones
estaciones=("02001" "02002" "02003" "02004" "02005" "02006" "02007" "02008" "02009" "02010"
            "02011" "02012" "02013" "02014" "02015" "02016" "02017" "02019" "02020" "02021"
            "02022" "02023" "02024" "02025" "02026" "02027" "02029" "02030" "02031" "02032"
            "02033" "02034" "02035" "02036" "02037" "02038" "02039" "02040" "02041" "02042"
            "02043" "02044" "02045" "02046" "02047" "02048" "02049" "02050" "02051" "02052"
            "02053" "02054" "02055" "02056" "02057" "02058" "02059" "02060" "02061" "02062"
            "02063" "02064" "02065" "02066" "02067" "02068" "02069" "02070" "02071" "02072"
            "02073" "02075" "02076" "02077" "02078" "02079" "02084" "02085" "02086" "02087"
            "02088" "02089" "02090" "02091" "02092" "02093" "02094" "02095" "02096" "02097"
            "02099" "02100" "02101" "02102" "02104" "02105" "02106" "02107" "02108" "02109"
            "02110" "02111" "02114" "02118" "02119" "02120" "02121" "02122" "02124" "02131"
            "02132" "02134" "02136" "02137" "02138" "02139" "02140" "02141" "02142" "02143"
            "02144" "02145" "02146" "02148" "02149" "02150" "02151" "02152" "02153" "02154"
            "02156" "02160" "02162" "02163" "02164" "02165" "02166" "02167" "02168")
    
cd ./OUTPUT/bc
echo "Las descargas se guardarán en el directorio $(pwd)"
sleep 3
echo "Inicia la descarga de datos" 

for estacion in "${estaciones[@]}"; do
    # Construir la URL con el código de la estación
    url="https://smn.conagua.gob.mx/tools/RESOURCES/Normales_Climatologicas/Diarios/bc/dia${estacion}.txt"
    
    # Descargar el archivo con wget
    wget -q --no-check-certificate --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36" "$url"
    # $? captura el resultado del comando anterior (0 es éxito)
    if [ $? -eq 0 ]; then
        echo "Estación [${estacion}] descargada. ✅"
    else
        echo "Estación [${estacion}] fallida. ❌"
    fi
done
echo "---"
echo "Descarga completa."
