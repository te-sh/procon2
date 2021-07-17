// URL: https://atcoder.jp/contests/abc171/tasks/abc171_d

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  long[] A; io.getA(N, A);

  long[long] h;
  foreach (Ai; A) ++h[Ai];
  auto s = A.sum;

  int Q; io.getV(Q);
  foreach (_; 0..Q) {
    long Bi, Ci; io.getV(Bi, Ci);
    if (Bi in h) {
      s -= Bi*h[Bi];
      s += Ci*h[Bi];
      h[Ci] += h[Bi];
      h[Bi] = 0;
    }
    io.put(s);
  }
}

auto io = IO!()();
import lib.io;
