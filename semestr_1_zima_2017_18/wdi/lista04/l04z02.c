#include <stdio.h>

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

unsigned int punkt_a(unsigned int x, unsigned int y) {
    return x * y / nwd(x, y);
}

void punkt_b(unsigned int a, unsigned int b) {
    printf("nwd(a, b) = %d\n", nwd(a, b));
    int gcd = nwd(a, b);
    a = a / gcd;
    b = b / gcd;
    printf("%d", a);
    printf("/");
    printf("%d\n", b);
}

int main(int argc, char* argv[]) {
    printf("%d\n", nwd(2, 7));
    printf("%d\n", nwd(10, 5));
    printf("%d\n", punkt_a(2, 7));
    punkt_b(24, 6);
    punkt_b(118, 4);
    return 0;
}
