#include <iostream>
#include <vector>
using namespace std;

int main() {
    int a[] = {1,2};
    int& ref = a[0];
    ref++;
    std:cout << a[0] << endl;

    return 0;
}   