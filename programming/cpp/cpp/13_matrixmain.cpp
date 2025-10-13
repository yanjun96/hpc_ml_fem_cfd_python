#include <iostream>
#include "matrix.hpp"


int main() {
    Matrix A(2,2);
    A(1,1) = A(2,2) =1;
    (A + A).printm();
    cout << "det(A) = " << det(A) << endl;
    return 0;
}   