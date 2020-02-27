#include <stdint.h>
#include <stdio.h>

uint32_t make_one(uint32_t x, uint32_t k) {
    return x | (1 << k);
}

uint32_t make_zero(uint32_t x, uint32_t k) {
    return x & (~(1 << k));
}

uint32_t make_neg(uint32_t x, uint32_t k) {
    return x ^ (1 << k);
}

uint32_t main() {
    printf("jedynki\n");
    printf("x = %d, k = 0 -> %d\n", 42,  make_one(42, 0));
    printf("x = %d, k = 3 -> %d\n", 42,  make_one(42, 3));
    printf("x = %d, k = 7 -> %d\n", 42,  make_one(42, 7));

    printf("zera\n");
    printf("x = %d, k = 0 -> %d\n", 42,  make_zero(42, 0));
    printf("x = %d, k = 3 -> %d\n", 42,  make_zero(42, 3));
    printf("x = %d, k = 7 -> %d\n", 42,  make_zero(42, 7));

    printf("negacje\n");
    printf("x = %d, k = 0 -> %d\n", 42,  make_neg(42, 0));
    printf("x = %d, k = 3 -> %d\n", 42,  make_neg(42, 3));
    printf("x = %d, k = 7 -> %d\n", 42,  make_neg(42, 7));

    return 0;
}
