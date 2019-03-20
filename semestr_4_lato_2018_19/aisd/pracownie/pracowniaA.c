#include <limits.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_INTEGER_DIGITS 64

long long howfar(long long clockwise[],
                 long long counterclockwise[],
                 long long so_far,
                 int to,
                 int housecount) {
  long long goingclockwise = clockwise[to] - so_far;
  /* long long goingcounterclockwise = counterclockwise[housecount-1-to] + so_far; */

  /* if (goingclockwise < goingcounterclockwise) */
  return goingclockwise;
  /* return goingcounterclockwise; */
}

bool isitworthgoingfurther(long long clockwise[],
                           long long counterclockwise[],
                           long long so_far,
                           int to,
                           int housecount) {
  long long goingclockwise = clockwise[to] - so_far;
  if (housecount-to-2 < 0)
    return 0;
  long long goingcounterclockwise = counterclockwise[housecount-1-to-1] + so_far;

  /* printf("CLOCKWISE -> %lld, ", goingclockwise); */
  /* printf("COUNTERCLOCKWISE -> %lld\n", goingcounterclockwise); */
  if (goingclockwise <= goingcounterclockwise)
    return true;
  return false;
}

int main() {
  char* raw = malloc(MAX_INTEGER_DIGITS);
  fgets(raw, MAX_INTEGER_DIGITS, stdin);
  int housecount_int = atoi(raw);
  long long distances[housecount_int];
  long long clockwise[housecount_int];
  long long counterclockwise[housecount_int];

  int curr_dist;

  for (int idx = 0; idx < housecount_int; idx++) {
    fgets(raw, MAX_INTEGER_DIGITS, stdin);
    curr_dist = atoi(raw);
    distances[idx] = curr_dist;
    clockwise[idx] = idx > 0 ? curr_dist + clockwise[idx-1] : curr_dist;
  }

  int counterclock_idx = 0;
  for (int idx = (housecount_int-1); idx >= 0; idx--) {
    counterclockwise[counterclock_idx] =
      idx < (housecount_int-1) ?
      distances[idx] + counterclockwise[counterclock_idx-1] : distances[idx];
    ++counterclock_idx;
  }

  /* for (int idx = 0; idx < housecount_int; idx++) { */
  /*   printf("WIERSZ: %d\n", idx); */
  /*   printf("distances -> "); */
  /*   printf("%lld\n", distances[idx]); */
  /*   printf("clockwise -> "); */
  /*   printf("%lld\n", clockwise[idx]); */
  /*   printf("counterclockwise -> "); */
  /*   printf("%lld\n", counterclockwise[idx]); */
  /* } */

  long long clockwise_max_distance = 0;
  int clockwise_going_to = 0;
  long long clockwise_already_traveled = 0;

  for (int where_are_we = 0; where_are_we < housecount_int; where_are_we++) {
    while (clockwise_going_to < housecount_int) {
      if (! isitworthgoingfurther(clockwise, counterclockwise, clockwise_already_traveled, clockwise_going_to, housecount_int))
        break;

      long long new_dist = howfar(clockwise, counterclockwise, clockwise_already_traveled, clockwise_going_to, housecount_int);
      /* printf("where_are_we -> "); */
      /* printf("%d\n", where_are_we); */
      /* printf("clockwise_going_to -> "); */
      /* printf("%d\n", clockwise_going_to); */
      /* printf("new_dist -> "); */
      /* printf("%lld\n\n", new_dist); */

      if (new_dist > clockwise_max_distance)
        clockwise_max_distance = new_dist;

      ++clockwise_going_to;
    }

    clockwise_already_traveled += distances[where_are_we];
  }

  long long counterclockwise_max_distance = 0;
  int counterclockwise_going_to = 0;
  long long counterclockwise_already_traveled = 0;

  for (int where_are_we = 0; where_are_we < housecount_int; where_are_we++) {
    while (counterclockwise_going_to < housecount_int) {
      if (! isitworthgoingfurther(counterclockwise, clockwise, counterclockwise_already_traveled, counterclockwise_going_to, housecount_int))
        break;

      long long new_dist = howfar(counterclockwise, clockwise, counterclockwise_already_traveled, counterclockwise_going_to, housecount_int);
      /* printf("where_are_we -> "); */
      /* printf("%d\n", where_are_we); */
      /* printf("counterclockwise_going_to -> "); */
      /* printf("%d\n", counterclockwise_going_to); */
      /* printf("new_dist -> "); */
      /* printf("%lld\n\n", new_dist); */

      if (new_dist > counterclockwise_max_distance)
        counterclockwise_max_distance = new_dist;

      ++counterclockwise_going_to;
    }

    counterclockwise_already_traveled += distances[where_are_we];
  }

  /* printf("ODPOWIEDZ CLOCKWISE -> %lld\n", clockwise_max_distance); */
  /* printf("ODPOWIEDZ COUNTER -> %lld\n", counterclockwise_max_distance); */
  long long greater = clockwise_max_distance > counterclockwise_max_distance ?
    clockwise_max_distance : counterclockwise_max_distance;
  printf("%lld\n", greater);
}
