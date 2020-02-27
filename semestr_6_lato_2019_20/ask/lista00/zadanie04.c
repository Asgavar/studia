#include <stdint.h>
#include <stdio.h>

uint32_t little_to_big(uint32_t x) {
  // DD CC BB AA -> AA BB CC DD
  return (x << 24) | ((x >> 8) & 0x0000ff00) | ((x << 8) & 0x00ff0000) | (x >> 24);
}

uint32_t main() {
  printf("%#010x\n", 42);
  printf("%#010x -> %#010x\n", 0xAABBCCDD, little_to_big(0xAABBCCDD));
  printf("%#010x -> %#010x\n", 0xDEADBEEF, little_to_big(0xDEADBEEF));
  return 0;
}
