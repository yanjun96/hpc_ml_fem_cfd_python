#include <iostream>
#include <vector>
using namespace std;


class Fraction {  // in preamble or main
    public:
       int num, den;
       Fraction(int numerator, int denominator) {
           num = numerator;   den = denominator; }
       Fraction operator+(Fraction b) {
        return Fraction(num*b.den + den*b.num, den*b.den); }
       bool operator == (Fraction b){
        return (num*b.den == den*b.num);} };

int main() {
    Fraction a(3,4);
    Fraction b(2,3);
    std:cout << a.num <<", " << a.den << std::endl;
    // std::cout << (a.add(b) == b.add(a)) << std::endl;
    std::cout << (a + b == b + a ) << std::endl;
    return 0;
}   