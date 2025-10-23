from mpi4py import MPI
import random
import time

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

if rank == 0:
    secret_number = random.randint(1, 100)
    print(f"[Rank 0] I picked a numer between 1 and 100...")
else:
    secret_number = None

secret_number = comm.bcast(secret_number, root=0)

found = False
attempts = 0

while not found:
    guess = random.randint(1, 100)
    attempts += 1
    time.sleep(0.1)

    if guess == secret_number:
        found = True
        print(f"[Rank {rank}] I guessed it! The numer is {guess} after {attempts} attempts.")
    else:
        found = False

    found_anywhere = comm.allreduce(found, op=MPI.LOR)
    if found_anywhere:
        break

if rank == 0:
    print("Game over! Someone found the number.")