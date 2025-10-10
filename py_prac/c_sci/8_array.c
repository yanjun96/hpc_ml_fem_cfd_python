#include <stdio.h>
#include <math.h>

float norm(int n, float v[]) {
        float s = 0;
        for (int i = 0; i < n; i++) s += v[i]*v[i];
        return sqrt(s); }


int main() {
    float v[] = {0, 3, 4, 5};
    
    printf("%f\n", norm(4,v));
    return 0;

}
