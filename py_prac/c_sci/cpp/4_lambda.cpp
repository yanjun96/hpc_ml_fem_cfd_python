#include <iostream>

std::function<int(int)> fct = [](int n) {return n*n;};

int main() {
    std::cout << fct(5) << std::endl;
    return 0;
}   