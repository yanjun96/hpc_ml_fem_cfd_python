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

n = 100
assert n % size == 0

k = rank * n//size + 1
l = (rank + 1) *n//size +1

sm_loc = sum(range(k,l))

if rank != 0: send(sm_loc, dest=0)  # destination is processor 0
else:
    sm = sm_loc
    for i in range(1, size):
        sm += recv(source=i)

if rank == 0: print(sm)