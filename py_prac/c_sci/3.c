#include <stdio.h>
int main() {
    int fieldno = 1;
    unsigned long fieldval = 1;
    unsigned long sum = 1;

    for (fieldno = 2; fieldno <= 64; fieldno++) {
        fieldval *= 2;
        sum += fieldval;
    }
    printf("Hello, World!\n");
    printf("fieldval = %lu\n", sum);
    return 0;
}

// this is 3.c