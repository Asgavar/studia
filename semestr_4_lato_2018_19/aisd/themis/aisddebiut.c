/* Artur Juraszek
   299970
   KLO */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LENGTH 42

int main() {
  char* raw = malloc(MAX_LENGTH);

  fgets(raw, MAX_LENGTH, stdin);

  char* alpha = strtok(raw, " ");
  char* beta = strtok(NULL, " ");

  int lower = atoi(alpha);
  int higher = atoi(beta);

  int multiple_of_2018 = lower;

  while ((multiple_of_2018 % 2018) != 0)
    ++multiple_of_2018;

  do {
    printf("%d\n", multiple_of_2018);
    multiple_of_2018 += 2018;
  } while (multiple_of_2018 <= higher);

  return 0;
}
