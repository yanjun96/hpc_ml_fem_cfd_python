#include <stdio.h>
#include <math.h>
int main()
{ int m,n;
for (n=0; n<10; n++)
  printf("%7d",n);
printf("\n");
for(m=0;m<10;m++)
{ printf("%d",m);
for (n=0; n<10; n++)
  printf("%7.2f",sqrt(m*10+n));
printf("\n");
}

return 0;

}
