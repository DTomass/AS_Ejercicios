#  ¿Indica cuál es el objetivo del siguiente script?

#!/bin/bash

E_BADARGS=85 # Error de argumentos

# Si el primer argumento no es un fichero legible
if [ ! -r "$1" ]
then # si no es legible, mostramos un mensaje de error de argumentos
    echo "Usage: $0 files-to-process"
    exit $E_BADARGS # Salimos con el código de error 85
fi

cat "$@" | # Procesamos todos los ficheros pasados como argumentos
tr A-Z a-z | # Convertimos todas las letras mayúsculas a minúsculas
tr ' ' '\012' | # Reemplazamos los espacios por saltos de línea
tr -c '\012a-z' '\012' | # tr -c sirve para seleccionar caracteres que no son saltos de línea ni letras minúsculas
grep -v '^$' | # grep -v elimina las líneas vacías
sort | # Ordenamos las palabras
uniq # Eliminamos las palabras repetidas

# El programa sera exitoso si uniq no encuentra errores
exit $?

# RESPUESTA:
# El objetivo del script es procesar uno o más ficheros de texto pasados como argumentos, convirtiendo todas las letras
# mayúsculas a minúsculas, reemplazando los espacios por saltos de línea, eliminando caracteres no alfabéticos, eliminando
# las líneas vacías, ordenando las palabras y eliminando las palabras repetidas. El resultado es una lista de palabras únicas
# en minúsculas, cada una en una línea separada. Si el primer argumento no es un fichero legible, el script muestra un mensaje
# de uso y sale con un código de error 85. Si el procesamiento es exitoso, el script finaliza con un código de éxito.