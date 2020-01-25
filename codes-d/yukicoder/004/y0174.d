// URL: https://yukicoder.me/problems/no/174

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; real Pa, Pb; io.getV(N, Pa, Pb);
  int[] A; io.getA(N, A);
  int[] B; io.getA(N, B);

  A.sort; B.sort;

  auto calc(int[] a, double p)
  {
    auto q = new double[][](N, N);
    foreach (ref qi; q) qi[] = 0;

    auto r = new double[](1<<N);
    r[] = 0; r[$-1] = 1;

    foreach_reverse (i; 1..1<<N) {
      auto c = i.popcnt, f = i.bsf;
      if (c == 1) {
        q[c-1][f] += r[i];
      } else {
        auto d = r[i]*p;
        q[c-1][f] += d;
        r[i.bitReset(f)] += d;
        foreach (j; f+1..N)
          if (i.bitTest(j)) {
            d = r[i]*(1-p)/(c-1);
            q[c-1][j] += d;
            r[i.bitReset(j)] += d;
          }
      }
    }

    return q;
  }

  auto r1 = calc(A, Pa), r2 = calc(B, Pb), e = 0.0;

  foreach (i; 0..N)
    foreach (j; 0..N)
      foreach (k; 0..N)
        if (A[j] > B[k])
          e += r1[i][j]*r2[i][k]*(A[j]+B[k]);

  io.put(e);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
