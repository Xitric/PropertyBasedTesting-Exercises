#include <stdio.h>
#include <stdlib.h>

// Nothing detected with
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=address example5.c
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=undefined example5.c

// Caught memory violation with
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=memory example5.c
int main(int argc, char** argv) /* argc is an argument counter */
{
  char a[10]; /* stack allocation */
  a[5] = 0;
  printf("running %s  argc is %i\n", argv[0], argc);
  if (a[argc]) /* Reading uninitialized memory */
    printf("what? %c\n", a[argc]);
  return 0;
}
