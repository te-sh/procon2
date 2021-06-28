// URL: https://atcoder.jp/contests/abc144/tasks/abc144_b

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  foreach (i; 1..10)
    foreach (j; 1..10)
      if (i*j == N)
        io.put!"{exit: true}"("Yes");
  io.put("No");
}

auto io = IO!()();
import lib.io;
