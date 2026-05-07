#!/bin/bash

# Lista de códigos de estaciones
estaciones=("18001" "18002" "18003" "18004" "18005" "18006" "18007" "18008" "18009" "18010" "18011" "18012" "18013" "18014" "18015" 
            "18016" "18017" "18018" "18019" "18020" "18021" "18022" "18023" "18024" "18025" "18026" "18027" "18028" "18029" "18031"
            "18032" "18033" "18034" "18035" "18036" "18037" "18038" "18039" "18040" "18041" "18042" "18043" "18044" "18045" "18046"
            "18052" "18053" "18055" "18056" "18057" "18058" "18061" "18062" "18063" "18064" "18065" "18068" "18069" "18070" "18071"
            "18072" "18073" "18074" "18075" "18076" "18077" "18078" "18079" "18080" "18081" "18082" "18083" "18084" "18085" "18087"
            "18088" "18089" "18090" "18092" "18030")

cd ./OUTPUT/nay
echo "Las descargas se guardarán en el directorio $(pwd)"
sleep 3
echo "Inicia la descarga de datos"  

for estacion in "${estaciones[@]}"; do
    # Construir la URL con el código de la estación
    url="https://smn.conagua.gob.mx/tools/RESOURCES/Normales_Climatologicas/Diarios/nay/dia${estacion}.txt"
    
    # Descargar el archivo con wget -q
    wget -q --no-check-certificate --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36" "$url"
if [ $? -eq 0 ]; then echo "Estación [${estacion}] descargada. ✅"; else echo "Estación [${estacion}] fallida. ❌"; fi
done
echo "---"
echo "Descarga completa."

