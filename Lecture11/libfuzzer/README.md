# Run with LibFuzzer
Compile with:
```
clang -o test-libfuzzer -fsanitize=address,fuzzer test-libfuzzer.c
```

Then run with:
```
./test-libfuzzer
```

And it correctly finds the crashing input string:
```
INFO: A corpus is not provided, starting from an empty corpus
[...]
0x48,0x49,0x21,
HI!
```
