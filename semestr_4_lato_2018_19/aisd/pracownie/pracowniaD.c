#include <limits.h>
#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct {
  int x;
  int y;
} point_t;

typedef struct {
  point_t p1;
  point_t p2;
} shortest_distance_t;

/* __attribute__((always_inline)) inline */ double
distance(point_t p1, point_t p2) {
  int x_dist = pow(p1.x - p2.x, 2);
  int y_dist = pow(p1.y - p2.y, 2);

  return sqrt(x_dist + y_dist);
}

shortest_distance_t brute_force(point_t points[], int count) {
  double min = INT_MAX - 0.1;
  shortest_distance_t answer;

  for (int i = 0; i < count; i++)
    for (int j = i + 1; j < count; j++)
      if (distance(points[i], points[j]) < min) {
        min = distance(points[i], points[j]);
        answer.p1 = points[i];
        answer.p2 = points[j];
      }

  return answer;
}

/* __attribute__((always_inline)) inline */ int
horizontal_dist(point_t point_in_question, point_t middle) {
  return abs(point_in_question.x - middle.x);
}

int
vertical_dist(const void *point1, const void *point2) {
  return abs(((point_t*)point1)->y - ((point_t*)point2)->y);
}

shortest_distance_t
calculate_in_strip(point_t strip[], int strip_count, double min_outside, shortest_distance_t best_outside) {
  double minimal_dist = min_outside;
  shortest_distance_t current_min = best_outside;

  for (int x = 0; x < strip_count; x++) {
    for (int y = x+1; y < strip_count && (strip[y].y - strip[x].y) < minimal_dist; y++) {
      int this_dist = distance(strip[x], strip[y]);
      if (this_dist < minimal_dist) {
        minimal_dist = this_dist;
        current_min.p1 = strip[x];
        current_min.p2 = strip[y];
      }
    }
  }

  printf("------calculate in strip------\n");
  printf("current min p1 X = %d\n", current_min.p1.x);
  printf("current min p1 Y = %d\n", current_min.p1.y);
  printf("current min p2 X = %d\n", current_min.p2.x);
  printf("current min p2 Y = %d\n", current_min.p2.y);
  return current_min;
}

shortest_distance_t
calculate_shortest(point_t points[], int count, int leftIncl, int rightIncl) {
  int howlongisthisstep = rightIncl - leftIncl + 1;
  if (howlongisthisstep <= 3) {
    printf("leci brute force\n");
    return brute_force(points, count);
  }

  printf("jedziemy normalnie\n");

  int middle_point = (leftIncl + rightIncl) / 2;

  shortest_distance_t left_shortest =
      calculate_shortest(points, count, leftIncl, middle_point);
  shortest_distance_t right_shortest =
      calculate_shortest(points, count, middle_point+1, rightIncl);

  bool left_is_shorter = (distance(left_shortest.p1, left_shortest.p2) <
                              distance(right_shortest.p1, right_shortest.p2));
  shortest_distance_t really_shortest =
      left_is_shorter ? left_shortest : right_shortest;
  double shortest_dist = distance(really_shortest.p1, really_shortest.p2);

  int strip_cur = 0;

  for (int idx = leftIncl; idx <= rightIncl; idx++) {
    if (horizontal_dist(points[idx], points[middle_point]) <= shortest_dist) {
      /* strip[strip_cur] = points[idx]; */
      ++strip_cur;
    }
  }

  if (strip_cur < 2)
    return really_shortest;

  point_t strip[strip_cur];

  int strip_idx = 0;

  for (int idx = leftIncl; idx <= rightIncl; idx++) {
    if (horizontal_dist(points[idx], points[middle_point]) <= shortest_dist) {
      strip[strip_idx] = points[idx];
      ++strip_idx;
    }
  }

  //
  for (int i = 0; i < strip_cur; i++)
    printf("ze stripa -> %d\t%d\n", strip[i].x, strip[i].y);
  //
  qsort(strip, strip_cur, sizeof(point_t), &vertical_dist);

  shortest_distance_t min_in_strip = calculate_in_strip(strip, strip_cur, shortest_dist, really_shortest);
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
    point_t new_point;
    new_point.x = x;
    new_point.y = y;
    points[idx] = new_point;
  }

  shortest_distance_t answer = calculate_shortest(points, linecount, 0, linecount-1);

  printf("%d %d\n", answer.p1.x, answer.p1.y);
  printf("%d %d\n", answer.p2.x, answer.p2.y);
}
