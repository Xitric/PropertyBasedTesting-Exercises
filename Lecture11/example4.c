#include <stdio.h>
#include <stdlib.h>

// Caught address violation with
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=address example4.c

// Nothing detected with
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=memory example4.c
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=undefined example4.c
void f(char *p) {
  p[0] = 'h';
  p[1] = 'e';
  p[2] = 'l';
  p[3] = 'l';
  p[4] = 'o';
  p[5] = '\0'; /* this index is out of bounds */
}

int main()
{
  char p[5]; /* stack allocation */
  f(p);
  printf("%s\n",p);
  return 0;
}
