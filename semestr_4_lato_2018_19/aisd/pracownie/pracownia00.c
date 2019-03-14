#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MEMORY_LIMIT 1 * 1024 * 1024 * 16  // 16 MB
#define MAX_LENGTH 42

void print_all_between(int lower, int higher) {
  for (int current = lower; current <= higher; current++)
    printf("%d\n", current);
}

int main() {
  char* raw = malloc(MAX_LENGTH);

  fgets(raw, MAX_LENGTH, stdin);

  char* alpha = strtok(raw, " ");
  char* beta = strtok(NULL, " ");

  int lower = atoi(alpha);
  int higher = atoi(beta);

  if (lower > higher) {  // then swap them
    int tmp = lower;
    lower = higher;
    higher = tmp;
  }

  print_all_between(lower, higher);

  return 0;
}
