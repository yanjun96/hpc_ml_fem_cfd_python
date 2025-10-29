#include <stdio.h>
#include <mpi.h>

float f(float x) { return 4.0/(1.0 + x*x); }

float partial_pi(int n, int start, int step){
    float h = 1.0/n;
    float sum = 0.0;
    for (int i=start; i<n; i+=step){
        float x = h*(i + 0.5);
        sum += h*f(x); }
    return sum; }

int main() {
    MPI_Init(NULL, NULL);
    int rank, size;
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    int n;
    if (rank==0) n = 10;
    MPI_Bcast( &n, 1, MPI_INT, 0, MPI_COMM_WORLD);

    float pi_loc = partial_pi(n, rank, size);

    float pi;
    MPI_Reduce( &pi_loc, &pi, 1, MPI_FLOAT,
                MPI_SUM, 0, MPI_COMM_WORLD);
    
    if (rank == 0) printf("%f\n", pi);
    
    MPI_Finalize(); 
}
// compared with python version, the difference is more verbose
// because each vlues needs to define type