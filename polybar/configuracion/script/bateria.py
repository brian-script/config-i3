#!/usr/bin/env python3

import psutil

def estadoBateria():
    bateria = psutil.sensors_battery()
    if bateria:
        porcentaje = round(bateria.percent)
        cargando = bateria.power_plugged

        # Establece colores y estados basados en el nivel de batería
        if porcentaje >= 90:
            color = "#00FF00"  # Verde brillante
            estado = "[██████]"
        elif porcentaje >= 75:
            color = "#7CFC00"  # Verde claro
            estado = "[█████ ]"
        elif porcentaje >= 60:
            color = "#ADFF2F"  # Verde amarillento
            estado = "[████  ]"
        elif porcentaje >= 50:
            color = "#FFFF00"  # Amarillo
            estado = "[███   ]"
        elif porcentaje >= 40:
            color = "#FFD700"  # Amarillo dorado
            estado = "[██    ]"
        elif porcentaje >= 25:
            color = "#FFA500"  # Naranja
            estado = "[█     ]"
        elif porcentaje >= 10:
            color = "#FF4500"  # Naranja rojo
            estado = "[█     ]"
        else:
            color = "#FF0000"  # Rojo brillante
            estado = "[█     ]"

        if cargando:
            color = "#00BFFF"  # Azul para estado de carga
            estado = "[██████]"

        # Devuelve el estado con el color en formato Polybar
        return f"%{{F{color}}}{estado} {porcentaje}%{{F-}}"

    else:
        return "[???]"

if __name__ == "__main__":
    print(estadoBateria())

