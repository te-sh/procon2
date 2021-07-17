// URL: https://atcoder.jp/contests/abc149/tasks/abc149_b

import std;

version(unittest) {} else
void main()
{
  long A, B, K; io.getV(A, B, K);

  if (A > K)
    io.put(A-K, B);
  else if (A <= K && K < A+B)
    io.put(0, B-(K-A));
  else
    io.put(0, 0);
}

auto io = IO!()();
import lib.io;
