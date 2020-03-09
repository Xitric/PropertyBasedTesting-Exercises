/* Simple example from John Hughes: Certifying your car with Erlang */
int n = 0;

void put(int m)
// { if (n != 231) n = m; } /* an arbitrary injected bug */
{ n = m; }

int get()
{ return n; }

void reset()
{ n = 0; }
