#include <stdio.h>
#include <stdlib.h>

// Caught address violation with
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=address example2.c

// Nothing detected with
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=memory example2.c
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=undefined example2.c
int main()
{
  char *p = malloc(5);
  p[0] = 'h';
  p[1] = 'e';
  p[2] = 'l';
  p[3] = 'l';
  p[4] = 'o';
  p[5] = '\0'; /* this index is out of bounds */
  printf("%s\n",p);
  return 0;
}
