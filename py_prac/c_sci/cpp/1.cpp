#include <iostream>

int main() {
    std::cout << 1./3 << " times " << 3.14
                << " is " << 1./3 * 3.14 << std::endl;
    float p = 3.14159;
    std:: cout.precision(3);  // 3 digit precision
    std:: cout << p << "\n";
    return 0;
}   