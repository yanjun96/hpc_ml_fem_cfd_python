#include <stdio.h>
int main()
{
float height, weight;

printf("Please input your height, the unit is cm:  ");
scanf("%f",&height);

printf("Please input your weight, the unit is kg:  ");
scanf("%f",&weight);

float bmi;

bmi = weight / (height*height) *10000 ;

printf("According to your personal information, your bmi is %.3f.\n", bmi);
printf(" the health range is 18-22.\n ");

return 0;
}
