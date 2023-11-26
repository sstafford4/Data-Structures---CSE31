#include <stdio.h>

int main(){
    int x, y, *px, *py;
    int arr[10] = {1,2,3,4,5,6,7,8,9,10};
    x = 5;
    y = 6;
    arr[0] = 100;
    px = &x;
    py = &y;
    int *p = &arr[0];

    for (int i = 0; i < 10; i++){
        printf("%d ", *(p + i));
    }
    
    printf("\n");
    printf("%d\n", x);
    printf("%d\n", y);
    printf("%d\n", arr[0]);
    printf("%p\n", (void *) &px);
    printf("%p\n", (void *) &py);
    printf("%d\n", *px);
    printf("%d\n", *py);
    printf("%p\n", (void *)&arr[0]);
    

    return 0;
}