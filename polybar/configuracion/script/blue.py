#!/usr/bin/env python3
import subprocess

def comando(comando):
    try: 
        resultado = subprocess.run(comando, shell=True, capture_output=True, text=True) 
        return resultado.stdout.strip()
    except Exception as e:
        return ""

estadoBluetooth = comando("bluetoothctl show | grep 'Powered:'")
prendido = "yes" in estadoBluetooth

conectados = comando("bluetoothctl info | grep 'Connected:' | grep 'yes'")
verConect = bool(conectados)

if not prendido:
    icon = "%{F#808080}BT%{F-}" 
elif verConect:
    icon = "%{F#00BFFF}BT%{F-}"  
else:
    icon = "%{F#FFFFFF}BT%{F-}" 

print(icon)

