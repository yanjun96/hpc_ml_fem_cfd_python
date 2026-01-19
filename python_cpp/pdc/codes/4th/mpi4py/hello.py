from mpi4py import MPI

# Initialize the MPI communicator
comm = MPI.COMM_WORLD

# Get the rank of the current process
rank = comm.Get_rank()

# Get the total number of processes
size = comm.Get_size()

# Print "Hello, World!" from each process
print(f"Hello, World! from rank {rank} out of {size} processors.")
