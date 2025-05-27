# 1. ¿Describe cuál es el objetivo del siguiente script?

#!/bin/bash

ONE=1
chet=0
FOX=0

# Mira en todos los ficheros del directorio actual
for brian in ./*
do
    echo "$brian" | grep -q " " # grep -q busca coincidencias sin mostrar salida
    if [ $? -eq $FOX ] # Si grep encontro espacios entonces devolverá 0
    then
        ramey=$brian # Asignamos el nombre del fichero a la variable ramey
        n=$(echo $ramey | sed -e "s/ /_/g") # sed reemplaza los espacios por guiones bajos
        mv "$ramey" "$n" # Renombramos el fichero
        chet=$((chet += 1)) # Incrementamos el contador de cambios
    fi
done

# Muestra el número de ficheros renombrados
if [ "$chet" -eq "$ONE" ]
then
    echo "$chet thing changed."
else
    echo "$chet things changed."
fi
exit 0

# RESPUESTA:
# El objetivo del script es buscar en el directorio actual aquellos ficheros que contienen espacios en el nombre, cuando
# los encuentra, los renombra reemplazando los espacios por guiones bajos y al final muestra cuántos ficheros han sido 
# renombrados.