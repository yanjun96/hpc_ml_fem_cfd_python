#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Oct 19 19:01:25 2025

@author: yanjun
"""

from mpi4py import MPI
comm = MPI.COMM_WORLD
msg = comm.recv(source = comm.size - 1 - comm.rank)
comm.send(22, dest = comm.size - 1 - comm.rank)
print("msg")