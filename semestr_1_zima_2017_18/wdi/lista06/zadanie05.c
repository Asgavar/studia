#include <math.h>
#include <stdbool.h>
#include "wdi.h"

bool* erastotenes(int up_to) {
    bool numbers[up_to + 1];
    double n_root = sqrt(up_to);
    for (int x = 0; x < up_to + 1; x++)
        numbers[x] = true;
    for (int x = 0; x < up_to; x++) {
        if (! numbers[x]) {
            continue;
        }
        int multiple = x;
        while (multiple < n_root) {
            numbers[multiple] = false;
        }
    }
    return numbers;
}

int main(void) {
    bool up_to_1000[];
    up_to_1000 = erastotenes(1000);
    print_bool_array(up_to_1000, 1001);
}
