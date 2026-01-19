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

f = lambda x: 4/(1 + x*x) # to be integrated over [0,1]

tup = None
if rank == 0:
    n = 100_100
    a = 0.0; b = 1.0; h = (b-a)/n
    tup = n, a, h 
    
n, a, h = bcast(tup)  # broadcast to all processors

add = 0.0
for i in range(rank, n, size): # 0, 0+size, 0+2*size...  1, 1+size, 1+2*size...
    x = a + h*(i + 0.5)
    add += f(x)

int_loc = h*add
int = reduce(int_loc)
if rank == 0: print(int)


