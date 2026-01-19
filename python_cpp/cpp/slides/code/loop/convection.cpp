#include<stdio.h>
#include<math.h>
int main()
{
int i,a,b,c,temp;
printf("Please input a and b to get the maximum convection: ");
scanf("%d%d",&a,&b);
if(a>b){c = a;}
else{c =b;}

i = 1;
temp = 1;
while(i<=c){
  if( (a%i== 0) && (b%i==0))
 { temp = i;
  i++; }
  else
 {temp = temp;
  i++;}
}

printf("The maximum convection of %d and %d is %d \n",a,b,temp);
return 0;
}
