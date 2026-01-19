#include <stdio.h>

int power(int n){
    return n*2;
}

int main() {
    int d = 20;
    int c;
    c = power(d);
    printf("power of 20 is: %d", d);
}