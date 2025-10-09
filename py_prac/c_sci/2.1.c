#include <stdio.h>
int main() {
int n = 100; //input
while ( n > 1){
   n = (n % 2 == 0) ? n/2 : 3*n +1;
   printf("%d\n", n);}
printf("arriver at 1\nthis is 2.1.c\n");
    return 0;
}