# Un administrador ha encontrado un script y no identifica cuál es su función. ¿Puedes por favor ayudarle?

#!/bin/bash

FRANCES=10
ALLEN=9

# $RANDOM is an internal Bash function (not a constant) that returns a
# pseudorandom [1] integer in the range 0- 32767. It should not be used
# to generate an encryption key.
i=$(($RANDOM % $FRANCES)) # Generate a random number between 0 and $FRANCES - 1.

# Si el numero aleatorio es menor que $ALLEN=9, entonces
if [ "$i" -lt "$ALLEN" ]
then # muestra cual ha sido el número generado y vuelve a ejecutar el script
    echo "i = $i"
    ./$0
fi

exit 0

# RESPUESTA:
# El objetivo del script es generar un número aleatorio entre 0 y 9. Si el número generado es menor que 9, el script
# muestra el número generado y vuelve a ejecutarse, lo que significa que continuará generando números aleatorios hasta que
# se genere un número igual a 9. Cuando esto sucede, el script finaliza.