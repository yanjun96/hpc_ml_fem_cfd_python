#include <iostream>
#include <vector>
using namespace std;

int arr[] = {0,2,0,0,8,10,0,14,16,19};
typedef struct {int index; int value;} node;

int main() {
    vector<node> node_vec;
    for (int i =0; i < 10; i++) {
        if (arr[i]==0) continue;
        node nd = {.index = i, .value = arr[i]};
        node_vec.push_back(nd);
    }

    vector<node>::iterator it;
    for (it = node_vec.begin(); it != node_vec.end(); it++) {
        cout << ' ' << it->index << ", " << it->value << ")";
cout << endl;
    }

    return 0;
}   