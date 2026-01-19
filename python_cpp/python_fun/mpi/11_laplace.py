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


if rank == 0:
    from numpy import linspace, zeros
    n = 10
    m = n//2
    u = zeros( (n,n) )
    x = linspace( 0, 1, n )
    u[0,:] = x*(1-x)

    ul = u[:, :m]
    ur = u[:, m:]

    send(ur, dest=1)

if rank == 1: ur = recv(source = 0)

def stencil_it(u):
    u_it = u.copy()  # copy avoid side effects
    r, c = u.shape
    for i in range(1, r-1):
        for j in range(1, c-1):
            u_it[i,j] = (u[i+1, j] + u[i-1, j]
                       + u[i, j+1] + u[i, j-1]) / 4
    return u_it

from numpy import column_stack, delete
iter = 40
for i in range(iter):
    if rank == 0:
       send( ul[:, -1], dest=1 )
       v = recv(source=1)
       ul_v = column_stack( [ul, v] )
       ul_v = stencil_it(ul_v)
       ul = delete(ul_v, -1, 1)

    if rank == 1:
        send(ur[:,0], dest=0)
        v = recv(source=0)
        v_ur = column_stack( [v, ur] )
        v_ur = stencil_it( v_ur )
        ur = delete( v_ur, 0, 1)

if rank == 1: send(ur, dest = 0)

if rank == 0:
    ur = recv(source=1)
    u = column_stack( [ul, ur] )

if rank == 0:
    from matplotlib.pyplot import figure, show
    fig = figure()
    ax = fig.add_subplot(projection='3d')
    from numpy import meshgrid
    x, y = meshgrid(x,x)
    ax.plot_surface(x, y, u,
                   rstride = 1, cstride=1, cmap='jet', linewidth=0)
    show()
    


    

    
