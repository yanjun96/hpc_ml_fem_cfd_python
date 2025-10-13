#include <iostream>
using namespace std;

int g(int);
int f(int n) {return n < 0 ? 22 : g(n);}
int g(int n) {return f(n-1); };

int main() {
    cout << f(6) << endl;
    return 0;
}   