#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SWAP(a, b) a = a ^ b; b = a ^ b; a = b ^ a

/*
 * The two input parameters.
 * Stored as globals, to avoid having to pass them
 * to each and every function.
 */
int MATRIX_SIZE;
int FIRST_K;


typedef long long multiplication_t;

typedef struct {
  multiplication_t *vals;
  int last_occupied;
  int max_size;
} maxheap_t;

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
  --heap->last_occupied;
  sift_down(heap, 0);
}

void insert_new(maxheap_t *heap, multiplication_t elem) {
  heap->vals[++heap->last_occupied] = elem;
  sift_up(heap, heap->last_occupied);
}

int main() {
  maxheap_t heap;
  heap.max_size = 10;
  heap.last_occupied = -1;

  multiplication_t arr[10];
  memset(arr, -1, 10 * sizeof(multiplication_t));

  heap.vals = arr;

  insert_new(&heap, 8);
  insert_new(&heap, 7);
  insert_new(&heap, 10);
  insert_new(&heap, 1);
  insert_new(&heap, 3);
  insert_new(&heap, 5);
  insert_new(&heap, 6);
  insert_new(&heap, 2);
  insert_new(&heap, 4);
  insert_new(&heap, 9);

  for (short idx = 0; idx < 10; idx++) {
    /* printf("%lld\n", arr[idx]); */
    printf("%lld\n", peek_max(&heap));
    pop_max(&heap);
  }

  return 0;
}
