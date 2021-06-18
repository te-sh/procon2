// URL: https://yukicoder.me/problems/no/821

import std;

version(unittest) {} else
void main()
{
  long N, K; io.getV(N, K);
  io.put(N*(N+1)/2 - (N-K)*(N-K+1)/2 + 1);
}

auto io = IO!()();
import lib.io;
