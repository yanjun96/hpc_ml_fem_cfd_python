#include<stdio.h>
int main(){
double height,radius,volume;
double cylinder(double r, double h);

printf("Please enter radius and height: ");
scanf("%lf%lf",&radius,&height);
volume = cylinder(radius,height);
printf("Volume = %.3f\n",volume);

return 0;
}


double cylinder(double r, double h)
{
double result;
result = 3.1415926*r*r*h;
return result;

}
