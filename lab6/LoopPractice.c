#include<stdio.h>
#include <stdlib.h> 

// This was actually so helpful. 


// Using this program ive put together as sudo for Lab 6.
// Very simple in C, different in Assembly. 

int main(){

    int num; // $t1 register 
    int total = 0; // $t0 + $zero to mak sure that $t0 == 0. Im gonna hold the sum in $t0
    int even = 0; // $t2 register 
    int odd = 0; // $t3 register

    while (num != 0){ // beq $t1, $zero, while
        scanf("%d", &num); // la $v0, 5 to get user input
        if (num % 2 == 0){
            even = even + num;
        }
        else{
            odd = odd + num;
        }
        total = total + num; // add $t0, $t0, $v0
    }

    printf("%d", even);
    printf("\n");
    printf("%d", odd);

}
