#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Oct 17 20:32:37 2025

@author: yanjun
"""

# Install VPython first:
# pip install vpython

from vpython import box, vector, rate

# Create a 3D cube
cube = box(pos=vector(0,0,0), size=vector(2,2,2), color=vector(0,0.5,1))

# Make it spin forever
angle = 0
while True:
    rate(60)  # 60 frames per second
    angle += 0.05
    cube.rotate(angle=0.05, axis=vector(0,1,0))