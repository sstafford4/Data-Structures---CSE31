#include <stdio.h>
#include <stdlib.h>

int main(){

    int n = 5; // the assembly code has n set to 5
    int m = 10; // and m set to 10

    int nm = n + m; // in MARS, proc1 has a label to add n and m, then afterwards adds that sum with m. 
    // the mars program uses a "function" to add them though. 

    // the mars program doesnt actually add the sum with m, it sets m to be the value of the sum. not gonna bother correcting this code, but it shold return 15 instead of 25. 

    printf("%d",nm + m);
}