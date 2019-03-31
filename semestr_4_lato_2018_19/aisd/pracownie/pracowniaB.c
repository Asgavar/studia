#include <math.h>

/*
 * The two input parameters.
 * Stored as globals, to avoid having to pass them
 * to each and every function.
 */
int MATRIX_SIZE;
int FIRST_K;

typedef struct {
  int row;
  int column;
} multiplication_t;

/*
 * Odd indices hold min values, while even ones - max values.
 */
typedef struct {
  multiplication_t **vals;
  long long minimal_value;
} minmax_heap_t;

typedef struct {
  int idx;
  multiplication_t * mult;
} minmax_child;

minmax_child descendants[6];

minmax_child* children_and_grandchildren(minmax_heap_t *heap, int idx) {
  // TODO: informować o nie wszystkich potomkach

  int son_idx = 2*idx + 1;
  int daughter_idx = 2*idx + 2;

  descendants[0].idx = son_idx;
  descendants[0].mult = heap->vals[son_idx];
  descendants[1].idx = daughter_idx;
  descendants[1].mult = heap->vals[daughter_idx];

  if (2*idx + 2 <= FIRST_K) {
    int son_son_idx = 2*son_idx + 1;
    int son_daughter_idx = 2*son_idx + 2;
    int daughter_son_idx = 2*daughter_idx + 1;
    int daughter_daughter_idx = 2*daughter_idx + 2;

    descendants[2].idx = son_son_idx;
    descendants[2].mult = heap->vals[son_son_idx];
    descendants[3].idx = son_daughter_idx;
    descendants[3].mult = heap->vals[son_daughter_idx];
    descendants[4].idx = daughter_son_idx;
    descendants[4].mult = heap->vals[daughter_son_idx];
    descendants[5].idx = daughter_daughter_idx;
    descendants[5].mult = heap->vals[daughter_daughter_idx];
  }

  return descendants;
}

/* max-specific ops */
long long peek_max(minmax_heap_t *heap) {
  multiplication_t *mult1 = heap->vals[1];
  multiplication_t *mult2 = heap->vals[3];
  // TODO: tu chyba będzie niejawna konwersja która wszystko rozjebie
  return fmax(mult1->row * mult1->column, mult2->row * mult2->column);
}

void sift_down_min(minmax_heap_t *heap, int idx) {
  if (2*idx + 1 > FIRST_K)
    return;


}

long long pop_max(minmax_heap_t *heap) { return -1; }

/* min-specific ops */
long long peek_min(minmax_heap_t *heap) {
  multiplication_t *mult = heap->vals[0];
  return mult->row * mult->column;
}

long long pop_min(minmax_heap_t *heap) { return -1; }

void sift_down_max(minmax_heap_t *heap, int idx) {}

/* generic interface */
void sift_down(minmax_heap_t *heap, int idx) {
  if (idx % 2 == 1)
    sift_down_min(heap, idx);
  else
    sift_down_min(heap, idx);
}

void sift_up(minmax_heap_t *heap) {}
