// URL: https://atcoder.jp/contests/abc140/tasks/abc140_b

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A); A[] -= 1;
  int[] B; io.getA(N, B);
  int[] C; io.getA(N-1, C);

  auto r = 0;
  foreach (i; 0..N) {
    r += B[A[i]];
    if (i < N-1 && A[i+1] == A[i]+1)
      r += C[A[i]];
  }
  io.put(r);
}

auto io = IO!()();
import lib.io;
