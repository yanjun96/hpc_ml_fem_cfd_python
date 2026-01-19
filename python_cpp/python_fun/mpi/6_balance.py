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

tup = None
if rank == 0:
    n = 100
    q = n//size; u = q*size; r = n%size  # size=cpu=8
    tup = q, u, r # 12, 96, 4
q, u, r = bcast(tup)  # broadcast to all processors
k = rank*q + 1
l = (rank + 1)*q + 1
sm = sum(range(k,l))

if rank < r: sm += u+1 + rank
sm = reduce(sm) # collect all sm
if rank == 0: print(sm)
