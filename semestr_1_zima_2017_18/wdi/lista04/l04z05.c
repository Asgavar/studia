#include <stdlib.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
    int n = atoi(argv[1]);
    short occurences[10] = {0};
    while (n > 0) {
        short digit = n % 10;
        occurences[digit] += 1;
        n /= 10;
    }
    short digitnumber = 0;
    for (int x = 0; x < 10; x++){
        if (occurences[x] > 0) {
            ++digitnumber;
        }
    }
    printf("%d\n", digitnumber);
    return 0;
}
