#!/bin/bash

# Lista de códigos de estaciones
estaciones=("04001" "04002" "04003" "04004" "04005" "04007" "04008" "04009" "04010"
            "04011" "04012" "04013" "04014" "04015" "04016" "04017" "04018" "04019" "04020"
            "04021" "04023" "04024" "04025" "04026" "04027" "04028" "04029" "04030"
            "04031" "04032" "04034" "04035" "04036" "04037" "04038" "04039" "04040"
            "04041" "04042" "04043" "04044" "04045" "04046" "04047" "04050" "04051"
            "04052" "04053" "04054" "04055" "04056" "04057" "04058" "04059" "04060"
            "04061" "04062" "04063" "04064" "04065" "04066" "04067" "04068" "04070"
            "04071" "04072" "04073" "04075" "04076" "04077" "04078" "04079" "04080"
            "04081" "04082" "04083" "04084" "04085" "04086" "04087")


cd ./OUTPUT/camp
echo "Las descargas se guardarán en el directorio $(pwd)"
sleep 3
echo "Inicia la descarga de datos"   


for estacion in "${estaciones[@]}"; do
    # Construir la URL con el código de la estación
    url="https://smn.conagua.gob.mx/tools/RESOURCES/Normales_Climatologicas/Diarios/camp/dia${estacion}.txt"   
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
