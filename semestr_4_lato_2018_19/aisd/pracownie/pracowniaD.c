#include <math.h>
#include <stdbool.h>
#include <stdlib.h>

typedef struct {
  int x;
  int y;
} point_t;

typedef struct {
  bool anythinghere;
  point_t p1;
  point_t p2;
} shortest_distance_t;

__attribute__((always_inline)) inline double
distance(point_t p1, point_t p2) {
  int x_dist = pow(p1.x - p2.x, 2);
  int y_dist = pow(p1.y - p2.y, 2);

  return sqrt(x_dist + y_dist);
}

__attribute__((always_inline)) inline int
horizontal_dist(point_t point_in_question, point_t middle) {
  return abs(point_in_question.x - middle.x);
}

int
vertical_dist(const void *point1, const void *point2) {
  return abs(((point_t*)point1)->y - ((point_t*)point2)->y);
}

shortest_distance_t
calculate_shortest(point_t points[], int count, int leftIncl, int rightIncl) {
  int howlongisthisstep = rightIncl - leftIncl + 1;
  if (howlongisthisstep <= 1)
    return (shortest_distance_t){false, NULL, NULL};

  int middle_point = (leftIncl + rightIncl) / 2;

  shortest_distance_t left_shortest =
      calculate_shortest(points, count, leftIncl, middle_point - 1);
  shortest_distance_t right_shortest =
      calculate_shortest(points, count, middle_point, rightIncl);

  bool left_is_shorter = ((!right_shortest.anythinghere) ||
                          (left_shortest.anythinghere &&
                           distance(left_shortest.p1, left_shortest.p2) <
                               distance(right_shortest.p1, right_shortest.p2)));
  shortest_distance_t really_shortest =
      left_is_shorter ? left_shortest : right_shortest;
  double shortest_dist = distance(really_shortest.p1, really_shortest.p2);

  point_t strip[count];
  int strip_cur = 0;

  for (int idx = leftIncl; idx <= rightIncl; idx++) {
    if (horizontal_dist(points[idx], points[middle_point]) <= shortest_dist) {
      strip[strip_cur] = points[idx];
      ++strip_cur;
    }
  }

  qsort(strip, strip_cur, sizeof(point_t), &vertical_dist);

  // TODO
  return really_shortest;
}

int
main() {
  //
}
