/* example from Building Secure and Reliable Systems, Chap.13
   https://landing.google.com/sre/books/ */
#include <stdlib.h>

// Caught address violation with
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=address use-after-free.c

// Caught uninitialized violation with
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=memory use-after-free.c

// Nothing detected with
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=undefined use-after-free.c
int main() {
  char *x = (char*)calloc(10, sizeof(char));
  free(x);
  return x[5];
}
