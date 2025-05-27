# Programa un script que dado un directorio, busque aquellos ficheros que no hayan sido modificados en
# el último mes y los guarde en un fichero tar. El nombre del fichero tar resultante contendrá un prefijo
# recibido como argumento seguido de guión bajo y de la fecha actual. Opcional: en vez de un directorio,
# utilizar como entrada múltiples directorios. El script tendrá al menos 2 argumentos, el primero será el
# prefijo y después se incluirán los nombres de los directorios de entrada.

#!/bin/bash

E_BADARGS=85 # Error de argumentos

# Comprobar que se han pasado al menos dos argumentos
if [ $# -lt 2 ]; then
    echo "Usage: $0 prefix dir1 [dir2 ...]"
    exit $E_BADARGS
fi

prefix="$1" # El primer argumento es el prefijo
shift # Eliminar el primer argumento para procesar solo los directorios
# Obtener la fecha actual en formato YYYYMMDD
current_date=$(date +%Y%m%d)

# Crear el nombre del fichero tar
tar_file="${prefix}_${current_date}.tar.gz"

for dir in "$@"
do
    # Comprobar si el directorio existe
    if [ ! -d "$dir" ]; then
        echo "El directorio $dir no existe. Saltando..."
        continue
    fi

    # Buscar ficheros no modificados en el último mes y añadirlos al fichero tar
    find "$dir" -type f -mtime +30 -print0 | tar --null -rvf "$tar_file" --files-from=-

    # El comando find busca ficheros (-type f) que no han sido modificados en los últimos 30 días (-mtime +30)
    # -print0 imprime los nombres de los ficheros encontrados separados por un carácter nulo, lo que permite 
    # manejar nombres de ficheros con espacios, esto se pasa por una pipe al comando tar que añade (-r) los 
    # ficheros al archivo tar. --null indica que los nombres de los ficheros están separados por un carácter 
    # nulo, y --files-from=- indica que los nombres de los ficheros se leen desde la entrada estándar

done

exit 0