#include <stdio.h>

// Nothing detected with
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=address example1.c
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=memory example1.c
// clang -Wall -Wextra -pedantic -g -o example -fsanitize=undefined example1.c
int main()
{
  printf("Hello, world!\n");
  return 0;
}
