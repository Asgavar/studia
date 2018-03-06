#include <stdio.h>
#include <stdlib.h>

unsigned int nwd(unsigned int n, unsigned int m) {
    if (n < m) {
        int temp = n;
        n = m;
        m = temp;
    }
    if (m == 0)
        return n;
    return nwd(m, n % m);
}

unsigned int nwd_many(unsigned int n, unsigned int numbers[]) {
    unsigned int current_gcd = numbers[0];
    for (int x = 1; x < n; x++) {  // w x86 int zajmuje 4B
        current_gcd = nwd(current_gcd, numbers[x]);
    }
    return current_gcd;
}

int main(int argc, char* argv[]) {
    unsigned int test_tab[] = {2, 4, 6, 8};
    unsigned int another_test_tab[] = {17, 34, 34*99, 17*8, 16};
    printf("nwd_many(4, {2, 4, 6, 8}) = %d\n", nwd_many(4, test_tab));
    printf("nwd_many(4, {17, 34, 34*99, 17*8}) = %d\n", nwd_many(4, another_test_tab));
    printf("nwd_many(4, {17, 34, 34*99, 17*8, 16}) = %d\n", nwd_many(5, another_test_tab));
    return 0;
}
