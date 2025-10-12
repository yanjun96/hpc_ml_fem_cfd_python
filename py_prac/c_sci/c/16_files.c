#include <stdlib.h>
#include <stdio.h>


int main() {
    float A[2][3]   = { {1.0, 2.0, 3.0}, {4.0, 5.0, 6.0} };

    FILE *fp = fopen("test.txt", "w");
    int n = 2, m = 3;
    fprintf(fp, "%d %d\n", n, m);
    for (int i=0; i<n; i++) {
        for (int j=0; j<m; j++) {
            fprintf(fp, "%f ", A[i][j]);}}
    fclose(fp);


    }