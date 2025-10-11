#include <stdlib.h>
#include <stdio.h>

typedef struct { int num; int den; } frac;
frac add(frac a, frac b)  {
    int nm = a.num * b.den + b.num * a.den;
    int dn = a.den * b.den;
    frac c = {.num = nm, .den = dn};
    return c;
}

int main() {
    frac a = {.num=1, .den=2};
    frac b = {.num=1, .den=3};
    frac c = add(a,b);
    printf("%d \n%d\n", c.num, c.den);
    return 0;
    }