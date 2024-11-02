#!/usr/bin/env python3
import subprocess

def comando(comando):
    try: 
        resultado = subprocess.run(comando, shell=True, capture_output=True, text=True) 
        return resultado.stdout.strip()
    except Exception as e:
        return ""

# Verifica si el Bluetooth está encendido
estadoBluetooth = comando("bluetoothctl show | grep 'Powered:'")
prendido = "yes" in estadoBluetooth

# Verifica si hay dispositivos conectados
conectados = comando("bluetoothctl info | grep 'Connected:' | grep 'yes'")
verConect = bool(conectados)

# Establece el color del icono según el estado del Bluetooth
if not prendido:
    icon = "%{F#808080}BT%{F-}"  # Gris si está apagado
elif verConect:
    icon = "%{F#00BFFF}BT%{F-}"  # Celeste si hay dispositivos conectados
else:
    icon = "%{F#FFFFFF}BT%{F-}"  # Blanco si está encendido pero sin dispositivos conectados

print(icon)

