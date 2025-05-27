# Realiza un script en bash que reciba como argumento uno o varios enlaces a páginas web y cuente el
# número de enlaces seguros, https, que contenga cada una de las páginas. Para la cuenta es suficiente
# contar el número de veces que aparezca la cadena https en el fichero. El script devolverá un error si es
# llamado sin ningún argumento. Cuando la ejecución sea correcta, la salida del script contendrá una linea
# por página web procesada y cada linea estará formada por el nombre de la web y el número de enlaces
# seguros.

#!/bin/bash

E_BADARGS=85 # Error de argumentos

# Comprobar que se han pasado argumentos
if [ $# -eq 0 ]; then
    echo "Usage: $0 url1 [url2 ...]"
    exit $E_BADARGS
fi

# Procesar cada URL pasada como argumento
for url in "$@"
do
    # Descargar el contenido de la página web
    content=$(curl -s "$url") # curl -s para suprimir la salida de curl, curl es una herramienta para transferir datos con URL

    # Contar el número de enlaces seguros (https)
    count=$(echo "$content" | grep -o "https" | wc -l) # grep -o extrae solo las coincidencias de "https" y wc -l cuenta el número de líneas (coincidencias)

    # Mostrar el resultado
    echo "$url: $count enlaces seguros"
done