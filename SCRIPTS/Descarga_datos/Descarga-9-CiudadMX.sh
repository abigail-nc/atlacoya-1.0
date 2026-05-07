#!/bin/bash

# Lista de códigos de estaciones
estaciones=("09001" "09002" "09003" "09004" "09005" "09006" "09007" "09008" "09009" "09010" "09011" "09012" "09013" "09014" "09015" "09016" "09017"
            "09019" "09020" "09021" "09022" "09023" "09024" "09025" "09026" "09028" "09029" "09030" "09031" "09032" "09033" "09034" "09036" "09037"
            "09038" "09039" "09040" "09041" "09042" "09043" "09044" "09045" "09046" "09047" "09048" "09049" "09050" "09051" "09052" "09054" "09055"
            "09056" "09058" "09059" "09062" "09064" "09067" "09069" "09070" "09071" )


cd ./OUTPUT/df
echo "Las descargas se guardarán en el directorio $(pwd)"
sleep 3
echo "Inicia la descarga de datos" 

for estacion in "${estaciones[@]}"; do
    # Construir la URL con el código de la estación
    url="https://smn.conagua.gob.mx/tools/RESOURCES/Normales_Climatologicas/Diarios/df/dia${estacion}.txt"
    
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
