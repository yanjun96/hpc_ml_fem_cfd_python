#include <stdio.h>
#include <math.h>

float norm(int n, int v[]) {.  
    // can not get sizeof in function, since return a pointer rather than a number
    // but sizeof(v)/ sizeof(v[0]) can used in main.
     int s = 0;
     for (int i=0; i<n; i++){. // i shoud not i<=n, otherwise it will v[n], it should v[0] to v[n-1] 
        s += v[i]*v[i]; }
    return sqrt(s);
}

int main() {
    int a[5] = {4,5,3,9,10};
    printf("%d",a[1]);
    float b = norm(5, a);   
    printf("norm is %f", b);
}