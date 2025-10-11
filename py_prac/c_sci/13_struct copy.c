#include <stdlib.h>
#include <stdio.h>

struct { int num; int den; } a;

int main() {
    a.num = 3;
    a.den = 4;
    printf("%d \n%d\n", a.num, a.den);
    return 0;
    }