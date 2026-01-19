#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Oct 19 19:01:25 2025

@author: yanjun
"""

from mpi4py import MPI
comm = MPI.COMM_WORLD
if comm.rank == 0:
    comm.send("Hello world", dest=1)

if comm.rank == 1:
    msg = comm.recv(source=0)
    print("Message received:",msg)