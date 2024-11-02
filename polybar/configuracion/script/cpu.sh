#!/bin/bash

# Ejecuta top y extrae el uso de la CPU
uso_cpu=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Imprime el resultado
echo " $uso_cpu%"

