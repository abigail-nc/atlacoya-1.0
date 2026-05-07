#!/bin/bash

# Lista de códigos de estaciones
estaciones=("29001" "29002" "29003" "29004" "29005" "29006" "29007" "29008" "29010" "29011" "29012" "29013" "29014" "29015" "29016"
            "29017" "29019" "29020" "29022" "29023" "29024" "29025" "29026" "29027" "29028" "29029" "29030" "29031" "29032" "29034"
            "29035" "29038" "29039" "29040" "29041" "29042" "29043" "29045" "29047" "29048" "29049" "29050" "29051" "29052" "29053"
            "29056" "29060" "29061" "29151" "29161" "29162" "29165" "29166" "29169" "29170" "29172" )
# Descargar cada archivo con wget -q

cd ./OUTPUT/tlax
echo "Las descargas se guardarán en el directorio $(pwd)"
sleep 3
echo "Inicia la descarga de datos"

for estacion in "${estaciones[@]}"; do
    # Construir la URL con el código de la estación
    url="https://smn.conagua.gob.mx/tools/RESOURCES/Normales_Climatologicas/Diarios/tlax/dia${estacion}.txt"
    
    # Descargar el archivo con wget -q
    wget -q --no-check-certificate --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36" "$url"
if [ $? -eq 0 ]; then echo "Estación [${estacion}] descargada. ✅"; else echo "Estación [${estacion}] fallida. ❌"; fi
done
echo "---"
echo "Descarga completa."

