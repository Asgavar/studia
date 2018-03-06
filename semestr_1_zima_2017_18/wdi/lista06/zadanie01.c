#include "wdi.h"

/* od left do konca */
short find_min_index(int array[], short left, short tablength) {
    short min_index = left;
    int min = array[left];
    for (short x = left; x < tablength; x++) {
        if (array[x] <= min) {
            min_index = x;
            min = array[x];
        }
    }
    return min_index;
}

void selection_sort(int to_sort[], short tablength) {
    short farthest_sorted = 0;
    while (farthest_sorted < tablength) {
       short min_index = find_min_index(to_sort, farthest_sorted, tablength);
       int min_value = to_sort[min_index];
       /* zamiana miejscami */
       int temp = min_value;
       to_sort[min_index] = to_sort[farthest_sorted];
       to_sort[farthest_sorted] = temp;
       ++farthest_sorted;
    }
}

int main(void) {
    int test_tab[] = {9, 8, 7, 6, 5, 4, -6};
    print_array(test_tab, 7);
    selection_sort(test_tab, 7);
    print_array(test_tab, 7);
}
