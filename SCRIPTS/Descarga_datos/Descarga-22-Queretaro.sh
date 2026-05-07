#!/bin/bash

# Lista de códigos de estaciones
estaciones=("22001" "22002" "22003" "22004" "22005" "22006" "22007" "22008" "22009" "22010" "22011" "22012" "22013" "22014" "22015"
            "22016" "22017" "22018" "22019" "22021" "22022" "22024" "22025" "22026" "22027" "22028" "22029" "22030" "22031" "22032"
            "22033" "22034" "22035" "22036" "22037" "22038" "22040" "22041" "22042" "22043" "22044" "22045" "22046" "22047" "22049"
            "22050" "22051" "22052" "22053" "22054" "22056" "22057" "22058" "22059" "22061" "22062" "22063" "22064" "22067" "22068"
            "22069" "22070" "22071" )

cd ./OUTPUT/qro
echo "Las descargas se guardarán en el directorio $(pwd)"
sleep 3
echo "Inicia la descarga de datos"


for estacion in "${estaciones[@]}"; do
    # Construir la URL con el código de la estación
    url="https://smn.conagua.gob.mx/tools/RESOURCES/Normales_Climatologicas/Diarios/qro/dia${estacion}.txt"
    
    # Descargar el archivo con wget -q
    wget -q --no-check-certificate --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36" "$url"
if [ $? -eq 0 ]; then echo "Estación [${estacion}] descargada. ✅"; else echo "Estación [${estacion}] fallida. ❌"; fi
done
echo "---"
echo "Descarga completa."

