#include <stddef.h>
#include <stdint.h>
#include <stdio.h>

struct A_initial {
  int8_t a;
  void *b;
  int8_t c;
  int16_t d;
}; // __attribute((packed))__;

struct A {
  void *b;
  int16_t d;
  int8_t a;
  int8_t c;
}; // __attribute((packed))__;

struct B {
  uint16_t a;
  double b;
  void *c;
};

int main() {
  struct A a;
  struct B b;

  printf(
    "rozmiar A = %d\nrozmiar B = %d\n",
    sizeof (struct A),
    sizeof (struct B));
  printf(
    "poszczegolne pola z A: %d, %d, %d, %d\n",
    sizeof (int8_t), sizeof (void*), sizeof (int8_t), sizeof (int16_t));
  printf(
    "poszczegolne pola z B: %d, %d, %d\n",
    sizeof (uint16_t), sizeof (double), sizeof (void*));

  printf(
    "offsety w A: %d, %d, %d, %d\n",
    offsetof(struct A_initial, a),
    offsetof(struct A_initial, b),
    offsetof(struct A_initial, c),
    offsetof(struct A_initial, d));

  printf("%d\n", sizeof(struct {uint16_t a; uint16_t b; uint16_t c;}));
}
