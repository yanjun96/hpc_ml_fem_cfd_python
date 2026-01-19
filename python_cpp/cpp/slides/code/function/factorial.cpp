#include <stdio.h>
int main() {
int i,m,sum,sum_i;
int factorial(int n);

sum = 0;
printf("Please input an integr m: \n");
scanf("%d",&m);

for (i=0; i<=m; i++)
  sum = sum + factorial(i);

printf("The sum of %d factorial is %d \n",m,sum);
 
return 0;
}


int factorial(int n)
{int i;
int result = 1;
for (i=1; i<=n; i++)
  result = result * i;
return result;
}
