#!/bin/bash

# Lista de códigos de estaciones
estaciones=("05001" "05002" "05003" "05004" "05005" "05006" "05007" "05008" "05009" "05010" 
            "05011" "05012" "05013" "05015" "05016" "05017" "05018" "05019" "05020" "05021" 
            "05022" "05023" "05024" "05025" "05026" "05027" "05028" "05029" "05030" "05031" 
            "05032" "05033" "05034" "05035" "05036" "05037" "05038" "05039" "05040" "05041" 
            "05042" "05043" "05045" "05046" "05047" "05048" "05049" "05050" "05051" "05052" 
            "05053" "05054" "05055" "05057" "05058" "05060" "05061" "05063" "05064" "05066" 
            "05068" "05069" "05074" "05075" "05081" "05085" "05086" "05130" "05133" "05134" 
            "05135" "05136" "05139" "05140" "05141" "05142" "05144" "05145" "05146" "05147" 
            "05148" "05149" "05150" "05151" "05152" "05153" "05154" "05155" "05156" "05157" 
            "05158" "05159" "05160" "05162" "05163" "05164" "05166" "05167" "05168" "05169" 
            "05170" "05171" "05172" "05173" "05174" "05175" "05176" "05178" "05179" "05180" 
            "05181" "05182" "05184" "05185" "05186" "05187" "05188" "05189" "05210")

cd ./OUTPUT/coah
echo "Las descargas se guardarán en el directorio $(pwd)"
sleep 3
echo "Inicia la descarga de datos"  

for estacion in "${estaciones[@]}"; do
    # Construir la URL con el código de la estación
    url="https://smn.conagua.gob.mx/tools/RESOURCES/Normales_Climatologicas/Diarios/coah/dia${estacion}.txt"
    
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
