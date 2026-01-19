#include <stdio.h>


int factorial(int n) {
    int res = 1;
    for (int i = 1; i <= n; i++) res *= i;
    return res;  }

int main() {
    printf("Running from: %s\n", __FILE__);
    int a = factorial(3);
    printf("%d\n", a);
}

