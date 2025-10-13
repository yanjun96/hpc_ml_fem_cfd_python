#include <iostream>
#include <vector>
#include <cmath>
using namespace std;

class Polynomial {
public:
    vector<float> coeff;
    Polynomial(vector<float> arr) {coeff = arr; };
    int operator()(float x){
        float s = 0;
        for (int i =0; i < coeff.size(); i++) {
            s += coeff[i] * pow(x, i);}
        return s; }

    Polynomial operator+(Polynomial q) {
        cout << "To be implemented. Dummy: ";
        Polynomial r({0});
        return r; }
    };

class Parabola: public Polynomial{
public:
    Parabola(vector<float> c): Polynomial(c) {
        if (c.size() !=3) {cout <<"No parabola\n"; exit(41);}}

    Parabola operator+(Parabola q){
        Parabola r({0,0,0});
        for (int i=0; i<3; i++) 
            {r.coeff[i] = (*this).coeff[i] + q.coeff[i];}
        return r; } };

int main() {
    Polynomial p({1,2,3}); // 1 + 2*x + 3*x^2
    cout << p(3) << endl; // 34
    cout << (p+p)(4) << endl;

    Parabola r({1,2,3});
    cout << r(4) << endl; // 34
    
    Parabola R({1,2,3});
    cout << (R+R)(4) << endl;
}   