#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Oct 17 20:39:18 2025

@author: yanjun
"""
from math import sin, cos
from vpython import sphere, vector, color, rate

sun = sphere(pos=vector(0,0,0), radius=0.5, color=color.yellow)
earth = sphere(pos=vector(2,0,0), radius=0.2, color=color.blue, make_trail=True)
moon1 = sphere(pos=vector(2,1,1), radius=0.1, color=color.red )
moon2 = sphere(pos=vector(2,1,1), radius=0.1, color=color.red )

angle = 0
while True:
    rate(100)
    angle += 0.02
    earth.pos = vector(2 * cos(angle), 0, 2 * sin(angle))
    moon1.pos = earth.pos + vector(0, sin(angle),0)
    moon2.pos = earth.pos + vector(0, cos(angle),0)