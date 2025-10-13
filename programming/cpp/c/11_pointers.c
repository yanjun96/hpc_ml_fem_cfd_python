#include <stdio.h>

void vpairf(int* p, int*q, int x) {*p = x; *q = -x;}

int main() {
    int c;
    printf("c address is %p\n", &c);
    
    int* p;
    printf("variable of p is %p\n", p );
    printf("varialble *p is %p\n", &p);

    int a, b;
    vpairf(&a, &b, 1);

    printf("a = %d, b = %d \n", a, b);


    int e[] = {1,10,100};
    int* f = e + 2; //address of e + 2, so it is e[2]=100
    printf("%d\n", *f);
    return 0;


}