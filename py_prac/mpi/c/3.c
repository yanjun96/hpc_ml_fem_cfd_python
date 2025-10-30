#include <stdio.h>
#include <mpi.h>


int main() {
    MPI_Init(NULL, NULL);
    int rank, size;
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    int n;
    float arr[n];

    if (rank==0) for (int i=0; i<=n; i++) arr[i] = i;
    int n_loc = n/size;
    float arr_loc[n_loc] 
    
    
  


    // be continue

    float pi;
    MPI_Reduce( &pi_loc, &pi, 1, MPI_FLOAT,
                MPI_SUM, 0, MPI_COMM_WORLD);
    
    if (rank == 0) printf("%f\n", pi);
    
    MPI_Finalize(); 
}
// compared with python version, the difference is more verbose
// because each vlues needs to define type