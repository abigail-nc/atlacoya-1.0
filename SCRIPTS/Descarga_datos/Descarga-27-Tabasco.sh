#!/bin/bash

# Lista de códigos de estaciones
estaciones=("27001" "27002" "27003" "27004" "27006" "27007" "27008" "27009" "27010" "27011" "27012" "27013" "27014" "27015" "27016"
            "27017" "27018" "27019" "27020" "27021" "27022" "27024" "27026" "27027" "27028" "27029" "27030" "27031" "27032" "27033"
            "27034" "27035" "27036" "27037" "27038" "27039" "27040" "27041" "27042" "27043" "27044" "27045" "27046" "27047" "27048"
            "27049" "27050" "27051" "27052" "27053" "27054" "27055" "27056" "27057" "27059" "27060" "27061" "27063" "27065" "27067"
            "27068" "27069" "27070" "27071" "27073" "27074" "27075" "27076" "27077" "27078" "27079" "27080" "27083" "27084" "27085"
            "27087" "27088" "27090" "27091" "27092" "27093" "27094" "27095" "27096")
# Descargar cada archivo con wget -q

cd ./OUTPUT/tab
echo "Las descargas se guardarán en el directorio $(pwd)"
sleep 3
echo "Inicia la descarga de datos"

for estacion in "${estaciones[@]}"; do
    # Construir la URL con el código de la estación
    url="https://smn.conagua.gob.mx/tools/RESOURCES/Normales_Climatologicas/Diarios/tab/dia${estacion}.txt"
    
    # Descargar el archivo con wget -q
    wget -q --no-check-certificate --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36" "$url"
if [ $? -eq 0 ]; then echo "Estación [${estacion}] descargada. ✅"; else echo "Estación [${estacion}] fallida. ❌"; fi
done
echo "---"
echo "Descarga completa."

