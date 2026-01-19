#include <iostream>

int main()
{
float height, weight;

std::cout << "Please input your height, the unit is cm:  ";
std::cin  >> height;

std::cout << "Please input your weight, the unit is kg:  ";
std::cin  >>  weight;

float bmi;

bmi = weight / (height*height) *10000 ;

std:: cout << "According to your personal information, your bmi is " << bmi;
std:: cout <<  ".\nGood" << std::endl;

std:: cout << "The health range is 18-22.\n ";

return 0;
}
