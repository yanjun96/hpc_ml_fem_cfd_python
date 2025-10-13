#include <stdio.h>
#include <math.h>

float det(int n, float A[][n]){
    if (n == 1) return A[0][0];
    float sum = 0;
    for (int col = 0; col < n; col++) {
        float A_sub[n-1][n-1];
        for (int i = 0; i < n-1; i++) 
            for (int j = 0; j < n-1; j++) 
                A_sub[i][j] = (j < col) ? A[i+1][j] : A[i+1][j+1];
        float s = A[0][col] * det(n-1, A_sub);
        sum += (col % 2 == 0) ? s: -s;}
    return sum; } 

int main() {
    float A[3][3] = {
        {1,2,3},
        {1,1,1},
        {3,3,1}  };

    float c = det(3, A);   
    printf("%f\n", c);
    return 0;
}