#!/bin/bash

# Lista de códigos de estaciones
estaciones=("06001" "06002" "06003" "06004" "06005" "06006" "06007" "06008" "06009" "06010" "06011" "06012" "06013" "06014" "06015" "06016" "06017"
            "06018" "06019" "06020" "06021" "06022" "06023" "06024" "06025" "06030" "06036" "06039" "06040" "06041" "06042" "06043" "06048" "06049"
            "06051" "06052" "06053" "06054" "06056" "06058" "06059" "06060" "06061" "06062" "06063" "06064" "06065" "06066" "06067" "06068" "06069"
            "06070" "06071" "06073" "06074" "06075" "06076" )

cd ./OUTPUT/col
echo "Las descargas se guardarán en el directorio $(pwd)"
sleep 3
echo "Inicia la descarga de datos"  

for estacion in "${estaciones[@]}"; do
    # Construir la URL con el código de la estación
    url="https://smn.conagua.gob.mx/tools/RESOURCES/Normales_Climatologicas/Diarios/col/dia${estacion}.txt"
    
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
