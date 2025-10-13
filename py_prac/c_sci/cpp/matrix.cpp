#include "matrix.hpp"
#include <iostream>

Matrix::Matrix(int r, int c){
          rows = r; cols = c;
          mat.resize(rows, vector<float>(cols, 0));} 

void Matrix::printm(){
    for (int i=0; i<rows; i++){
        for (int j=0; j<cols; j++) std::cout << mat[i][j]<< "\t";
        std::cout << std::endl; }}

float& Matrix::operator() (int i, int j) {return mat[i-1][j-1];}

Matrix Matrix::operator+(Matrix B) {
        Matrix C(rows, cols);
        for (int i=1; i<=rows; i++)
          for (int j=1; j<=cols; j++)
            C(i,j) = (*this)(i,j) + B(i,j);
        return C;}

float det(Matrix A) { // declaration
    int n = A.rows;
    if (n != A.cols) {
        std::cerr << "Error\n";
        exit(41);}
    if (n==1) return A(1,1);
    Matrix B(n-1, n-1);
    float d = 0;
    for (int c=1; c<=n; c++) {
        for (int i=1; i<=n-1; i++)
          for (int j=1; j<=n-1; j++)
            B(i,j) = (j < c) ? A(i+1,j) : A(i+1,j+1);
        float s = A(1,c) * det(B);
        d += (c%2==0) ? -s : s;}
        return d;}
