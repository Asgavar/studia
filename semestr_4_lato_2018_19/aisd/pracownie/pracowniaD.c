#include <math.h>
#include <stdbool.h>
#include <stdio.h>
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
calculate_in_strip(point_t strip[], int strip_count) {
  int minimal_dist = -42;
  shortest_distance_t current_min;

  for (int x = 0; x < strip_count; x++) {
    for (int y = 0; y < strip_count; y++) {
      int this_dist = distance(strip[x], strip[y]);
      if (this_dist > minimal_dist) {
        minimal_dist = this_dist;
        current_min = (shortest_distance_t){true, strip[x], strip[y]};
      }
    }
  }

  return current_min;
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

  shortest_distance_t min_in_strip = calculate_in_strip(strip, strip_cur);
  double min_strip_dist = distance(min_in_strip.p1, min_in_strip.p2);

  return min_strip_dist < shortest_dist ? min_in_strip : really_shortest;
}

int
main() {
  int linecount;
  scanf("%d", &linecount);

  point_t points[linecount];

  for (int idx = 0; idx < linecount; idx++) {
    int x, y;
    scanf("%d %d", &x, &y);
    point_t new_point = {x, y};
    points[idx] = new_point;
  }

  shortest_distance_t answer = calculate_shortest(points, linecount, 0, linecount-1);
}
