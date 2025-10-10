#include <stdio.h>
#include <math.h>

int main() {
    int arr[] = {0,1,2,3,4};
    for (int i = 0; i < 3; i++) {
        printf("%d\n",arr[i]);
    }

    printf("sizeof(arr) is %zu", sizeof(arr));
    return 0;

}
