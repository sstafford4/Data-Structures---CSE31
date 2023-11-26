#include<stdio.h>

int bar(int a, int b, int c) {

    // example logic: bar(4,5,3) == (5-4) shift left 3
    // 1 = 00000001 << 3 == 00001000 == 8
    printf("%d\n", (b-a) << (c)); // this prints p and q values in respective order. 
    return (b - a) << (c); // (b - a) shift left by c spaces in binary
    
}

int foo(int m, int n, int o) {
    int p = bar(m + o, n + o, m + n); // logic: bar(1+3, 2+3, 1+2) == bar(4, 5, 3)
    int q = bar(m - o, n - m, n + n); // s0 - s2,
    printf("p + q: %d\n", p + q);
    return p + q;
}

int main() {
    int x = 1, y = 2, z = 3; // s0, s1, s2
    z = x + y + z + foo(x, y, z); //reference logic: z is going to end up being everything, therefore at the end add $s2, $zero, $twhatever
    printf("%d\n", z);
    return 0;
}
