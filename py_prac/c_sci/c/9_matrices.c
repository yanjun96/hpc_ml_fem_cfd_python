#include <stdio.h>
#include <math.h>

int main() {
    int A[2][3];
    for (int i=0; i < 2; i++) {
        for (int j=0; j < 3; j++) {
            A[i][j] = 10*i + j;
            printf("%d\n", A[i][j]); }
    }
    return 0;
}