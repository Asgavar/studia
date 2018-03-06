#include <stdio.h>

#ifndef WDI_H
#define WDI_H

void print_array(int array[], int arrlength) {
    for (int x = 0; x < arrlength; x++) {
        printf("%d ", array[x]);
    }
    puts("\n");
}

void print_bool_array(bool array[], int arrlength) {
    for (int x = 0; x < arrlength; x++) {
        printf("%d ", array[x]);
    }
    puts("\n");
}

#endif
