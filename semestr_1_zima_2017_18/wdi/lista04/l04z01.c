#include <stdio.h>

int punkt_a(int n) {
    return n % 2 == 0 ? n : -1*n;
}

double punkt_b(int n) {
    double sum = 0;
    for (int x = 1; x <= n; x++) {
        double change = x % 2 == 0 ? (1.0 / (2*x)) : (-1*(1.0 / (2*x - 1)));
        sum += change;
    }
    return sum;
}

int punkt_c(int n, int x){
    int i = 1;
    int start_x = x;
    int ret = 0;
    while (i <= n) {
        ret += i*x;
        x *= start_x;
        i += 1;
    }
    return ret;
}

int main(int argc, char** argv) {
    printf("%d %d %f %f %d %d\n", punkt_a(7), punkt_a(72),
        punkt_b(1), punkt_b(370), punkt_c(2, 1), punkt_c(3, 3));
    return 0;
}
