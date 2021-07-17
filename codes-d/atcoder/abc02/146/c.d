// URL: https://atcoder.jp/contests/abc146/tasks/abc146_c

import std;

version(unittest) {} else
void main()
{
  long A, B, X; io.getV(A, B, X);

  foreach_reverse (i; 1..11) {
    auto N = (X-B*i)/A;
    if (i == 10 && N >= 10^^9)
      io.put!"{exit: true}"(10^^9);
    else if (i <= 9 && N >= 10^^(i-1))
      io.put!"{exit: true}"(min(N, 10^^i-1));
  }
  io.put(0);
}

auto io = IO!()();
import lib.io;
