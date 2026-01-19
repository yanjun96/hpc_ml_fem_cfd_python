#include <stdlib.h>
#include <stdio.h>

int n  = 3;
int m = 4;

int main() {
    int**  A = malloc(sizeof(int*) * n);
    for (int i = 0; i < n; i++) {
        A[i] = malloc(sizeof(int) * m);
    }
    for (int i = 0; i < n; i++) {
        for (int j=0; j < m; j++) {
            A[i][j] = i*m + j;
            printf("%d\n", A[i][j]);
    free(A[i]);}
    }

    for (int i = 0; i < n; i++) {
        free(A[i]); }
    free(A);
    return 0;
    }