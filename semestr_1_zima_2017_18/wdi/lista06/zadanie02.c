#include <stdbool.h>  // ;_;
#include "wdi.h"

void bubble_sort(int to_sort[], int arrlength) {
    bool swapped;
    do {
        swapped = false;
        for (int x = 0; x < arrlength - 1; x++) {
            if (to_sort[x] > to_sort[x+1]) {
                swapped = true;
                int temp = to_sort[x+1];
                to_sort[x+1] = to_sort[x];
                to_sort[x] = temp;
            }
        }
    } while (swapped);
}

int main(void) {
   int testarr[] = {91204, 764, 8, 9, 2, -8, 1, 2};
   print_array(testarr, 8);
   bubble_sort(testarr, 8);
   print_array(testarr, 8);
}
