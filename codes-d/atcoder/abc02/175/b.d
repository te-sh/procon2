// URL: https://atcoder.jp/contests/abc175/tasks/abc175_b

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] L; io.getA(N, L);

  auto c = 0;
  foreach (i; 0..N)
    foreach (j; i+1..N)
      foreach (k; j+1..N)
        if (L[i] != L[j] && L[j] != L[k] && L[k] != L[i] &&
            L[i]+L[j] > L[k] && L[j]+L[k] > L[i] && L[k]+L[i] > L[j])
          ++c;

  io.put(c);
}

auto io = IO!()();
import lib.io;
