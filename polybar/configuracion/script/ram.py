#!/usr/bin/env python3

import psutil

mem = psutil.virtual_memory()

memoriaUsada = mem.used / (1024 ** 2)

print(f"{memoriaUsada:.1f}MB")
