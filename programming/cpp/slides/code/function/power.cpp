#include <stdio.h>
int main(void)
{
int a, b, c;
double power(double d, double e);
printf("Please enter a and b:");
scanf("%d%d",&a, &b);
c = power (a, b);
printf("a power b is %d\n",c );
return 0;
}

double power(double d, double e)
{
int i;
int result;
result = d;
for (i=1; i<e; i++)
  result = result*d;
return result;

}
