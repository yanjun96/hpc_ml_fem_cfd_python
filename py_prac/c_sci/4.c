#include <stdio.h>
int main() {
    float r = 1;
    float eps = 1e-6;
    for (; (r*r -2)*(r*r -2) > eps*eps;) 
         { r = (r + 2/r)/2; }
    printf("%f\n", r);

    return 0;
}

// this is 3.c