#include <stdio.h>
#include <stdlib.h>

#define SWAP(a, b) a = a ^ b; b = a ^ b; a = b ^ a

typedef long long multiplication_t;

typedef struct {
  multiplication_t *vals;
  int last_occupied;
  int max_size;
} maxheap_t;

/*
 * The two input parameters.
 * Stored as globals, to avoid having to pass them
 * to each and every function.
 */
int MATRIX_SIZE;
int FIRST_K;

int PRINTED_SO_FAR = 0;
multiplication_t LAST_PRINTED = -42;


int parent(int idx) {
  if (idx % 2 == 1)
    return idx / 2;
  return (idx-1) / 2;
}

void sift_up(maxheap_t *heap, int idx) {
  int curr = idx;
  while (heap->vals[curr] > heap->vals[parent(curr)]) {
    SWAP(heap->vals[curr], heap->vals[parent(curr)]);
    curr = parent(curr);
  }
}

void sift_down(maxheap_t *heap, int idx) {
  int curr = idx;
  while (2*curr + 2 < heap->max_size) {
    multiplication_t left_child = heap->vals[2*curr + 1];
    multiplication_t right_child = heap->vals[2*curr + 2];

    if (heap->vals[curr] > left_child && heap->vals[curr] > right_child)
      return;

    // we always choose the greater child in order to avoid
    // breaking the heap property
    if (left_child > right_child) {
      SWAP(heap->vals[2*curr + 1], heap->vals[curr]);
      curr = 2*curr + 1;
    } else {
      SWAP(heap->vals[2*curr + 2], heap->vals[curr]);
      curr = 2*curr + 2;
    }
  }
}

multiplication_t peek_max(maxheap_t *heap) {
  return heap->vals[0];
}

void pop_max(maxheap_t *heap) {
  heap->vals[0] = heap->vals[heap->last_occupied];
  heap->vals[heap->last_occupied] = -1;
  heap->last_occupied -= 1;
  sift_down(heap, 0);
}

void insert_new(maxheap_t *heap, multiplication_t elem) {
  /* printf("LAST OCCUPIED = %d\n", heap->last_occupied); */
  /* printf("HEAP SIZE = %d\n", heap->max_size); */
  heap->vals[++heap->last_occupied] = elem;
  sift_up(heap, heap->last_occupied);
}

void flush_heap(maxheap_t *heap, multiplication_t threshold) {
  for (int idx = 0; idx < heap->max_size; idx++) {
    if (peek_max(heap) < threshold)
      return;
    if (PRINTED_SO_FAR == FIRST_K)
      exit(0);

    if (peek_max(heap) >= threshold && LAST_PRINTED != peek_max(heap)) {
      ++PRINTED_SO_FAR;
      LAST_PRINTED = peek_max(heap);
      /* printf("LAST PRINTED = %lld\n", LAST_PRINTED); */
      printf("%lld\n", peek_max(heap));
    }
    pop_max(heap);
  }
}

int main() {
  scanf("%d %d", &MATRIX_SIZE, &FIRST_K);

  // TODO kopiec mniejszy niż K
  multiplication_t *multarr = malloc(sizeof(multiplication_t) * FIRST_K);

  maxheap_t heap;
  heap.vals = multarr;
  heap.last_occupied = -1;
  heap.max_size = FIRST_K;

  for (int column = MATRIX_SIZE; column >= 1; column--) {
    multiplication_t lower_left_val = column * (multiplication_t)MATRIX_SIZE;
    if (column != MATRIX_SIZE)
      flush_heap(&heap, lower_left_val);

    for (int row = MATRIX_SIZE; row - column >= 0; row--) {
      /* printf("%lld\n", column*row); */
      if (heap.last_occupied >= heap.max_size - 1)
        flush_heap(&heap, lower_left_val);
      insert_new(&heap, column * (multiplication_t)row);
      /* printf("COLUMN = %d, ROW = %d, MULT = %lld\n", column, row, column*(multiplication_t)row); */
      /* printf("HEAP LAST = %d\n", heap.last_occupied); */
    }
  }

  flush_heap(&heap, 0);
}
