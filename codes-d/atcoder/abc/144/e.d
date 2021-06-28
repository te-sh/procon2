// URL: https://atcoder.jp/contests/abc144/tasks/abc144_e

import std;

version(unittest) {} else
void main()
{
  int N; long K; io.getV(N, K);
  long[] A; io.getA(N, A);
  long[] F; io.getA(N, F);

  A.sort!"a<b"; F.sort!"a>b";

  auto m = zip(A, F).map!"a[0]*a[1]".maxElement;
  
  auto satisfy(long t)
  {
    auto k = 0L;
    foreach (Ai, Fi; lockstep(A, F))
      k += max(Ai-t/Fi, 0);
    return k <= K;
  }

  io.put(iota(0, m+1).upperBoundBy!(t => satisfy(t))(false).front);
}

import lib.bound_by;

auto io = IO!()();
import lib.io;
