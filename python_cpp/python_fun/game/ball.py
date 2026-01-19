#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Oct 18 20:59:12 2025

@author: yanjun
"""

import os
import time
import random

# Terminal size
WIDTH = 50
HEIGHT = 15

# Ball starting position and direction
x, y = random.randint(1, WIDTH-2), random.randint(1, HEIGHT-2)
dx, dy = 1, 1

while True:
    # Clear the screen
    os.system('cls' if os.name == 'nt' else 'clear')

    # Draw frame
    for row in range(HEIGHT):
        line = ""
        for col in range(WIDTH):
            if row == 0 or row == HEIGHT-1:
                line += "-"   # top/bottom border
            elif col == 0 or col == WIDTH-1:
                line += "|"   # side border
            elif row == y and col == x:
                line += "🏐dsaddsa"   # ball
            else:
                line += " "
        print(line)

    # Bounce logic
    x += dx
    y += dy
    if x <= 1 or x >= WIDTH-2:
        dx = -dx
    if y <= 1 or y >= HEIGHT-2:
        dy = -dy

    time.sleep(0.05)  # control speed