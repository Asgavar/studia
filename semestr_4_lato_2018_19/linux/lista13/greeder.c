#include <errno.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
  int how_much_to_allocate = atoi(argv[1]);
  void* ptr = calloc(1, how_much_to_allocate);

  printf("Memory we've been given starts at: 0x%x\n", ptr);
  printf("Errno: %d\n", errno);

  free(ptr);
}
