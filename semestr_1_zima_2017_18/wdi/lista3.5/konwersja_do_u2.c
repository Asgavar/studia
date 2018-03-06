#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    int n = atoi(argv[1]);
    /* odpowiednio -(2^23) oraz (2^23)-1 */
    if (n < -1 * pow(2, 23) || n > pow(2, 23) - 1) {
        puts("Liczba spoza zakresu!");
        return -1;
    }
    int temp = n;
    n = abs(n);
    int ret[24];
    int i = 23;
    while (n > 0) {
        ret[i] = n % 2;
        n = n / 2;
        i -= 1;
    }
    /* wypelnienie zerami */
    while (i >= 0) {
        ret[i] = 0;
        i -= 1;
    }
    if (temp > 0) {
        for (int i = 0; i < 24; i++) {
            printf("%d", ret[i]);
        }
        return 0;
    }
    /* jesli n bylo ujemne */
    for (int i = 0; i < 24; i++) {
        ret[i] = ret[i] == 0 ? 1 : 0;
    }
    /* TODO: dodanie jedynki */
    short added = 0;
    for (int x = 23; x >= 0; x--) {
        if (added)
            break;
        if (ret[x] == 0) {
            added = 1;
            ret[x] = 1;
            for (int y = x+1; y <= 23; y++) {
                ret[y] = 0;
            }
        }
    }
    for (int x = 0; x < 24; x++) {
        printf("%d", ret[x]);
    }
    return 0;
}
