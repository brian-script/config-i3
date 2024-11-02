#!/usr/bin/env python3

import shutil

total, used, free = shutil.disk_usage("/")

free_gb = free / (1024 ** 3)

print(f"Disk: {free_gb:.0f}GB")
