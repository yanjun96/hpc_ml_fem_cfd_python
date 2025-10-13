#include <iostream>
#include <vector>
using namespace std;


class Matrix {  // in preamble or main
    vector< vector<float> > mat;
    public:
       int rows, cols;
       Matrix(int r, int c){
          rows = r; cols = c;
          mat.resize(rows, vector<float>(cols, 0));} 
          float& operator() (int i, int j) {return mat[i-1][j-1];} 
        
    void printm(){
    for (int i=0; i<rows; i++){
        for (int j=0; j<cols; j++) cout << mat[i][j]<< "\t";
        cout <<endl; }}

    Matrix operator+(Matrix B) {
        Matrix C(rows, cols);
        for (int i=1; i<=rows; i++)
          for (int j=1; j<=cols; j++)
            C(i,j) = (*this)(i,j) + B(i,j);
        return C;}
};




int main() {
    Matrix A(2,2);
    A(1,1) = A(2,2) =1;
    (A + A).printm();

    return 0;
}