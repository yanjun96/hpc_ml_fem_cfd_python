#include <stdio.h>
int main() {
int n = 100; //input
while ( n > 1){
   if (n % 2 == 0) n /= 2;
   else n = 3*n +1;
   printf("%d\n", n);}
printf("arriver at 1\n");
    return 0;
}