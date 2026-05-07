#!/bin/bash

# Lista de códigos de estaciones
estaciones=("01001" "01003" "01004" "01005" "01006" "01007" "01008" "01009" "01010" "01011"
            "01012" "01013" "01014" "01015" "01016" "01017" "01018" "01019" "01020" "01021"
            "01022" "01023" "01024" "01025" "01026" "01027" "01028" "01029" "01030" "01031"
            "01032" "01033" "01034" "01035" "01036" "01041" "01043" "01045" "01046" "01047"
            "01057" "01062" "01063" "01073" "01074" "01075" "01076" "01077" "01078" "01079"
            "01080" "01081" "01082" "01083" "01084" "01085" "01088" "01089" "01090" "01091"
            "01094" "01095" "01096" "01097" "01098" "01099" "01101" "01102" "01103" "01104"
            "01105" "01106" "01108")

cd ./OUTPUT/ags 
echo "Las descargas se guardarán en el directorio $(pwd)"
sleep 3
echo "Inicia la descarga de datos"

# Descargar cada archivo con wget
for estacion in "${estaciones[@]}"; do
    # Construir la URL con el código de la estación
    url="https://smn.conagua.gob.mx/tools/RESOURCES/Normales_Climatologicas/Diarios/ags/dia${estacion}.txt"

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
