#!/bin/bash

# Lista de códigos de estaciones
estaciones=("31001" "31002" "31003" "31004" "31005" "31006" "31007" "31008" "31009" "31010" "31011" "31012" "31013" "31014"
            "31015" "31016" "31017" "31018" "31019" "31020" "31021" "31022" "31023" "31024" "31025" "31026" "31027" "31028" "31029"
            "31030" "31031" "31032" "31033" "31034" "31035" "31036" "31037" "31038" "31039" "31040" "31041" "31042" "31043" "31044"
            "31045" "31046" "31047" "31048" "31049" "31050" "31051" "31052" "31053" "31054" "31055" "31056" "31057" "31058" "31059"
            "31060" "31061" "31062" "31063" "31064" "31065" "31066" "31068" "31069" "31070" "31071" "31072" "31073" "31074" "31075"
            "31076" "31077" "31078" "31079" "31080" "31082" "31083" "31084" "31085" "31086" "31088" "31089" "31090" "31091" "31093"
            "31094" "31095" "31096" "31097" "31098" "31099" "31100" "31101")

cd ./OUTPUT/yuc
echo "Las descargas se guardarán en el directorio $(pwd)"
sleep 3
echo "Inicia la descarga de datos"

for estacion in "${estaciones[@]}"; do
    # Construir la URL con el código de la estación
    url="https://smn.conagua.gob.mx/tools/RESOURCES/Normales_Climatologicas/Diarios/yuc/dia${estacion}.txt"
    
    # Descargar el archivo con wget -q
    wget -q --no-check-certificate --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36" "$url"
if [ $? -eq 0 ]; then echo "Estación [${estacion}] descargada. ✅"; else echo "Estación [${estacion}] fallida. ❌"; fi
done
echo "---"
echo "Descarga completa."

