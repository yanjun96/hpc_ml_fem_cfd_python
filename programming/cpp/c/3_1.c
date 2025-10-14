#include <stdio.h>
#include <math.h>

float norm(int n, int v[]) {
     int s = 0;
     for (int i=0; i<n; i++){
        s += v[i]*v[i]; }
    return sqrt(s);
}

int main() {
    int a[5] = {4,5,3,9,10};
    printf("%d",a[1]);
    float b = norm(5, a);   // if here is 5, it will wrong
    printf("norm is %f", b);
}