#include <stdio.h>

float diff_quot(float f(float), float x) { //outside main
    float h = 1e-5;
    return (f(x + h) - f(x)) / h; }

float f_ex(float x) {return 4*x*(1 - x); }


int main() {
  
    // printf("%f\n", diff_quot(f_ex, 0.5));
}
