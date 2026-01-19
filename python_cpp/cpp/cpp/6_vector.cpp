#include <iostream>
#include <vector>
using namespace std;


int main() {
    vector<int> u(2);
    vector<int> v(3,1);
    vector<int> w{1,2,3};
    cout << u.size() << endl;
    cout << v.size() << endl;
    cout << w.size() << endl;
    return 0;
}   