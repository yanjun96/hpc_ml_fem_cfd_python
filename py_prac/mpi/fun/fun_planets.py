# space_mpi.py
from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

if rank == 0:
    print(f"🪐 Command Center online with {size - 1} planets connected!")
    # Send mission message to all planets
    for planet in range(1, size):
        msg = f"Hello Planet {planet}, your mission is to explore sector {planet*42}!"
        comm.send(msg, dest=planet)
        print(f"🛰️ Sent to Planet {planet}: {msg}")

    # Receive responses
    for planet in range(1, size):
        response = comm.recv(source=planet)
        print(f"📡 Received from Planet {planet}: {response}")

else:
    # Receive message from Command Center
    mission = comm.recv(source=0)
    print(f"🌌 Planet {rank} received mission: {mission}")

    # Send back a response
    response = f"Planet {rank} reporting in! Mission acknowledged. 🚀"
    comm.send(response, dest=0)