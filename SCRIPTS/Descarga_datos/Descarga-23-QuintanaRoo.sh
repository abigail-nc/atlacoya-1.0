#!/bin/bash

# Lista de códigos de estaciones
estaciones=("23001" "23002" "23003" "23004" "23005" "23006" "23007" "23009" "23010" "23011" "23012" "23013" "23014" "23015" "23016"
            "23017" "23018" "23019" "23020" "23021" "23022" "23023" "23024" "23025" "23026" "23027" "23029" "23030" "23031" "23032"
            "23033" "23040" "23041" "23042" "23043" "23044" "23045" "23048" "23049" "23050" "23051" "23150" "23152" "23153" "23154"
            "23155" "23157" "23158" "23159" "23160" "23161" "23162" "23163" "23164" "23165" "23166" "23167" "23169" "23170" "23171"
            "23172")

cd ./OUTPUT/qroo
echo "Las descargas se guardarán en el directorio $(pwd)"
sleep 3
echo "Inicia la descarga de datos"  

for estacion in "${estaciones[@]}"; do
    # Construir la URL con el código de la estación
    url="https://smn.conagua.gob.mx/tools/RESOURCES/Normales_Climatologicas/Diarios/qroo/dia${estacion}.txt"
    
    # Descargar el archivo con wget -q
    wget -q --no-check-certificate --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36" "$url"
if [ $? -eq 0 ]; then echo "Estación [${estacion}] descargada. ✅"; else echo "Estación [${estacion}] fallida. ❌"; fi
done
echo "---"
echo "Descarga completa."

