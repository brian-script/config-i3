#!/usr/bin/env python3

import psutil

def estadoBateria():
    bateria = psutil.sensors_battery()
    if bateria:
        porcentaje = round(bateria.percent)
        cargando = bateria.power_plugged

        if porcentaje >= 90:
            color = "#00FF00"  
            estado = "[██████]"
        elif porcentaje >= 75:
            color = "#7CFC00"
            estado = "[█████ ]"
        elif porcentaje >= 60:
            color = "#ADFF2F"  
            estado = "[████  ]"
        elif porcentaje >= 50:
            color = "#FFFF00"  
            estado = "[███   ]"
        elif porcentaje >= 40:
            color = "#FFD700"  
            estado = "[██    ]"
        elif porcentaje >= 25:
            color = "#FFA500"
            estado = "[█     ]"
        elif porcentaje >= 10:
            color = "#FF4500"  
            estado = "[█     ]"
        else:
            color = "#FF0000"  
            estado = "[█     ]"

        if cargando:
            color = "#00BFFF"  
            estado = "[██████]"

        return f"%{{F{color}}}{estado} {porcentaje}%{{F-}}"

    else:
        return "[???]"

if __name__ == "__main__":
    print(estadoBateria())

