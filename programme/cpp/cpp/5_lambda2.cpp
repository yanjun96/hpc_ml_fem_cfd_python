#include <iostream>

std::function<double(double)> ddx(double f (double)) {
    std::function<double(double)> f_prime;
    f_prime = [f](double x) { double h = 1.e-6; 
                              return (f(x+h)-f(x))/ h; };
    return f_prime;};

double g(double x) {return x*x;}

int main() {
    std::function<double(double)> dgdx = ddx(g);
    std::cout << dgdx(2) << std::endl;
    return 0;
}   