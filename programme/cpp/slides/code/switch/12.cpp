# include <stdio.h>
int main()
{
int a,b,c,s;
printf("Please input three parameters: a, b ,c, input each number and press enter.\n ");
scanf("%d%d%d",&a,&b,&c);
s = b*b - 4*a*c;
if(s>0){
printf("This equation has two real solutions.\n");
}
else if(s==0){
printf("This equation has only one real solution.\n");
}
else
printf("This equation do not have real solution.\n");

return 0;



}
