// URL: https://atcoder.jp/contests/abc145/tasks/abc145_c

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  double[] x, y; io.getC(N, x, y);

  auto s = 0.0L, p = new int[](N);
  foreach (i; 0..N) p[i] = i;
  do {
    foreach (i; 0..N-1)
      s += sqrt((x[p[i]]-x[p[i+1]])^^2+(y[p[i]]-y[p[i+1]])^^2);
  } while (p.nextPermutation);
  foreach (i; 0..N) s /= i+1;

  io.put(s);
}

auto io = IO!()();
import lib.io;
