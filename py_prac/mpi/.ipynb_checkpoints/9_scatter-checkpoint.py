#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Oct 19 19:01:25 2025

@author: yanjun
"""
from numpy import array, zeros
from mpi4py import MPI
rank = MPI.COMM_WORLD.rank
size = MPI.COMM_WORLD.size
send = MPI.COMM_WORLD.send
recv = MPI.COMM_WORLD.recv
reduce = MPI.COMM_WORLD.reduce
bcast = MPI.COMM_WORLD.bcast
Scatter = MPI.COMM_WORLD.Scatter

v = w = n_loc = None
if rank == 0:
    n = 24
    assert n % size == 0
    v = array( [float(i) for i in range(1, n+1)])
    w = array( [float(i) for i in range(n, 0, -1)])
    n_loc = n//size  # n_loc = 3 = 24/8

n_loc = bcast(n_loc)

v_loc = zeros(n_loc)  # length is 3
w_loc = zeros(n_loc)

Scatter(v, v_loc); Scatter(w, w_loc) # v length is 24

#print(v_loc)

dot_loc = v_loc @ w_loc # @ denotes dot multiplication
# local parts are multiplied.

print(dot_loc)

dot = reduce(dot_loc) # default reduce is SUM function

if rank == 0: print(dot)
