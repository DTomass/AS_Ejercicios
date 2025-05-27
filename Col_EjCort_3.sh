# Se desea programar un script en bash que reciba un fichero con una lista de usuarios, un usuario por
# línea, como parámetro de entrada y determine si el usuario existe en el sistema. En caso afirmativo, el
# script revisará los permisos del directorio .ssh verificando si son correctos. Cuando los permisos sean
# incorrectos, se mostrara un mensaje de error por pantalla y si el usuario no pertenece al sistema se
# borrara el directorio /home/usuario si existe.

#!/bin/bash

# Comprobar que se ha pasado un argumento
if [ $# -ne 1 ]; then
    echo "Usage: $0 user-list-file"
    exit 1
fi

# Por cada usuario en el fichero proporcionado
for user in $(cat "$1")
do
    # Compruebo si el usuario existe en el sistema
    id "$user" &>/dev/null
    if [ $? -eq 0 ] # id devuelve info del user, si user no existe $? es 0
    then # Si el usuario existe
        if [ -d "/home/$user/.ssh" ]; then # Compruebo si el directorio .ssh existe
            perms=$(stat -c "%a" "/home/${user}/.ssh") # Obtengo los permisos del directorio .ssh
            if [ "$perms" != "700" ]; then # Verifico si los permisos son correctos (700)
                echo "Error: Permisos incorrectos para el directorio .ssh de $user. Permisos actuales: $perms"
            fi
        fi
    else # Si el usuario no existe
        echo "El usuario $user no existe en el sistema."
        if [ -d "/home/$user" ]; then # Compruebo si el directorio home del usuario existe
            rm -rf "/home/$user" # Borrar el directorio home del usuario
            echo "Directorio /home/$user eliminado."
        fi
    fi
done

exit 0