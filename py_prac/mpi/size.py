from mpi4py import MPI
comm = MPI.COMM_WORLD
print("Hello world from process", comm.rank, "of", comm.size)