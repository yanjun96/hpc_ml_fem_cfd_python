#include <stdlib.h>
#include <stdio.h>


int main() {

    FILE* fp = fopen("test.txt", "r");
    int n, m;
    fscanf(fp, "%d %d", &n, &m);
    float B[n][m];
    for (int i=0; i<n; i++) {
        for (int j=0; j<m; j++) {
            fscanf(fp, "%f", &B[i][j]);}}
    fclose(fp);

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            printf("%f ", B[i][j]);}
        printf("\n");}
    return 0;
    }