// URL: https://yukicoder.me/problems/no/820

import std;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  io.putB(N >= K, 2L^^(N-K), 0);
}

auto io = IO!()();
import lib.io;
