#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Oct 19 19:01:25 2025

@author: yanjun
"""

from mpi4py import MPI
rank = MPI.COMM_WORLD.rank
size = MPI.COMM_WORLD.size
send = MPI.COMM_WORLD.send
recv = MPI.COMM_WORLD.recv
reduce = MPI.COMM_WORLD.reduce
bcast = MPI.COMM_WORLD.bcast

f = lambda x: 4/(1 + x*x) # to be integrated over [0,1], it is 4 * pi/4, x = tan(\theta)

tup = None
if rank == 0:
    
    a = 0.0; b = 1.0; n = 100_100
    h = (b-a)/n
    from numpy import linspace
    x = linspace(a, b, n+1)
    q = n//size
    tup = q, x, h
    
q, x, h = bcast(tup)  # broadcast to all processors

k = rank*q; l = k + q
int_loc = h/2*(f(x[k]) + 2*sum(f(x[k+1:l])) + f(x[l]))

int = reduce(int_loc)
if rank == 0: print(int)


