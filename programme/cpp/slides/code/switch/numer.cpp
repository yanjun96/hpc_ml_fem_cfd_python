#include <stdio.h>
int main()

{
int number;
printf("Please input a number: ");

scanf("%d",&number);

if(number%2 == 0){
  printf("The numner %d is an even.\n",number);
}
else{
  printf("The numer %d is an odd.\n",number);
}

}
