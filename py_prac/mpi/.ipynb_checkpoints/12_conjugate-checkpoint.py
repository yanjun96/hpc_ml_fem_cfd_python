#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Oct 19 19:01:25 2025

@author: yanjun
"""
from numpy import array, zeros, sqrt
from mpi4py import MPI

rank = MPI.COMM_WORLD.rank
size = MPI.COMM_WORLD.size
send = MPI.COMM_WORLD.send
recv = MPI.COMM_WORLD.recv
reduce = MPI.COMM_WORLD.reduce
bcast = MPI.COMM_WORLD.bcast
Scatter = MPI.COMM_WORLD.Scatter
Gather =  MPI.COMM_WORLD.Gather

A = n = p = None

if rank == 0:
    A = array([[ 9, 3, -6, 12.], [ 3, 26., -7, -11],
               [-6, -7, 9., 7.], [12., -11, 7., 65.]])
    b = array([ 18., 11., 3., 73.])
    n = len(b)
    x = zeros(n)
    r = b.copy();
    p = r.copy();
    rs_old = r @ r

n = bcast(n)
n_loc = n//size
A_loc = zeros( (n_loc, n) )
Scatter(A, A_loc)  # partition A into horizontal slices

for i in range(n):
    p = bcast(p)
    Ap_loc = A_loc @ p
    Ap = zeros(n)
    Gather(Ap_loc, Ap)

    if rank == 0:
        alpha = rs_old / (p @ Ap)
        x += alpha*p
        r -= alpha*Ap
        rs_new = r @ r
        if sqrt(rs_new) < 1e-10: break
        p = r + (rs_new / rs_old) * p
        rs_old = rs_new    # end for loop


if rank == 0:   print(x)


    

    
