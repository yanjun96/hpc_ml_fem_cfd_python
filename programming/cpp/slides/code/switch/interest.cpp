#include<stdio.h>
#include<math.h>
int main()
{
int money,years;
float rate,sum;
printf("Please input how many money you want to store:.\n ");
scanf("%d",&money);
printf("Has sccessful got the money sum, please input the years you want to store: \n");
scanf("%d",&years);

switch (years){
  case 1: rate = 0.0325; break;
  case 2: rate = 0.0375; break;
  case 3: rate = 0.0425; break;
  case 5: rate = 0.0475; break;
  default: printf("You can only choose 1, 2, 3,or 5 years plan");
}
sum = money* pow( (1+rate),years);
printf("Total you will get %f.\n ",sum);

return 0;
}
