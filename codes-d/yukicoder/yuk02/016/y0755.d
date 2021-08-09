// URL: https://yukicoder.me/problems/no/755

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);
  long[][] A; io.getM(M, M, A);

  auto ac = A.map!(Ai => Ai.cumulativeSum).array;

  foreach (_; 0..N) {
    int x, y; io.getV(x, y); --x; --y;
    auto ans = 0;

    foreach (l; 0..y+1)
      foreach (r; y..M) {
        auto b = ac.map!(aci => aci[l..r+1]).array;

        auto s = [0L: 1], sd = 0L;
        foreach (d; x+1..M) {
          sd += b[d];
          ++s[-sd];
        }

        auto su = 0L;
        foreach_reverse (u; 0..x+1) {
          su += b[u];
          if (su in s) ans += s[su];
        }
      }

    io.put(ans);
  }
}

import lib.data_structure.cumulative_sum;

auto io = IO!()();
import lib.io;
