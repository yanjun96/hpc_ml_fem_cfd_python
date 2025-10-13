#include <vector>
#include <iostream>
using namespace std;

class Matrix {  // in preamble or main
        vector< vector<float> > mat;
public:
       int rows, cols;
       Matrix(int r, int c);
       void printm();
       float& operator() (int i, int j); 
       Matrix operator+(Matrix B); };
       
float det(Matrix A); // declaration
