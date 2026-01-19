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

q_loc = None
if rank == 0:    # calculate the q_loc only in processor 0
    n = 100
    assert n % size == 0
    q_loc = n//size

q = bcast(q_loc) # broadcast to all processors
k = rank*q + 1
l = (rank + 1)*q + 1

sm_loc = sum(range(k,l))

sm = reduce(sm_loc)  # collect and reduce to a single value

print(sm)