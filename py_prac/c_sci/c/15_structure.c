#include <stdlib.h>
#include <stdio.h>

struct node {int index; int value; struct node *next;};
typedef struct node node;

node* create_node(int idx, int val){
    node* npt = malloc(sizeof(node));
    (*npt).index = idx;
    (*npt).value = val;
    (*npt).next = NULL;
    return npt;}

typedef struct {node* first; node* last;} vec;

vec* create_vector(void){
    vec* v = malloc(sizeof(vec));
    (*v).first = NULL;
    (*v).last = NULL;
    return v;}  

void append(vec* v, node* npt){
    if ((*v).first == NULL){
        (*v).first = npt;
        (*v).last = npt;}
    else {
        (*(*v).last).next = npt;
        (*v).last = npt;}}


int main() {
    int arr[] = {0,0,3,0,0,0,5,0,0,0,0,7};
    vec* v = create_vector();
    for (int i=0; i<12; i++){
        if (arr[i] != 0){
           node* npt = create_node(i, arr[i]);
           append(v, npt);}}

    for (node* npt = (*v).first; npt != NULL; npt = (*npt).next){
        printf("(%d, %d) ", (*npt).index, (*npt).value);}

    return 0;
    }