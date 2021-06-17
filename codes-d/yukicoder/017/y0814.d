// URL: https://yukicoder.me/problems/no/814

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  long[] K, L; int[] D; io.getC(N, K, L, D);

  auto r = 0L;
  foreach (Ki, Li, Di; lockstep(K, L, D)) {
    auto x1 = Ki%2 == 0 ? 0 : Li & ((1L<<Di)-1);
    auto x2 = cumulativeXOR(Li>>Di, (Li>>Di)+(Ki-1))<<Di;
    r ^= (x1 | x2);
  }

  io.put(r);
}

auto cumulativeXOR(long n1, long n2)
{
  auto r = cumulativeXOR(n2);
  return n1 == 0 ? r : r ^ cumulativeXOR(n1-1);
}

auto cumulativeXOR(long n)
{
  switch (n%4) {
  case 0: return n;
  case 1: return 1;
  case 2: return n+1;
  case 3: return 0;
  default: assert(0);
  }
}

auto io = IO!()();
import lib.io;
