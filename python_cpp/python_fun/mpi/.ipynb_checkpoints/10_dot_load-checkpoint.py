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
Scatterv = MPI.COMM_WORLD.Scatterv

v = w = sendcts = None
if rank == 0:
    n = 10
    # assert n % size == 0
    v = array( [float(i) for i in range(1, n+1)])
    w = array( [float(i) for i in range(n, 0, -1)])
    n_loc = n//size  # n_loc = 1 = 10/8
    sendcts = [n_loc for i in range(size)] # [1 1 1...]
    for i in range(n % size): sendcts[i] += 1

sendcts= bcast(sendcts)

v_loc = zeros(sendcts[rank])  # length is 3
w_loc = zeros(sendcts[rank])


Scatterv( [v, sendcts, MPI.DOUBLE], v_loc)
Scatterv( [w, sendcts, MPI.DOUBLE], w_loc)

dot_loc = v_loc @ w_loc # @ denotes dot multiplication
# local parts are multiplied.

dot = reduce(dot_loc) # default reduce is SUM function

if rank == 0: print(dot)
