#include <stdio.h>
int main()
{
int rmb;
float rate;
float usd;

printf("Please input how much rmb you want to change: ");
scanf("%d",&rmb);

rate = 0.1642;
usd = rmb * rate;

printf("You can have %f",usd);
printf(" usd.\n");

}
