// URL: https://yukicoder.me/problems/no/709

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);

  auto s = new int[](M), t = new int[][](M);
  auto u = new int[](N), v = 0;
  foreach (i; 0..N) {
    int[] R; io.getA(M, R);
    foreach (j; 0..M) {
      if (R[j] > s[j]) {
        foreach (ti; t[j]) {
          --u[ti];
          if (u[ti] == 0) --v;
        }
        t[j] = [i];
        ++u[i];
        if (u[i] == 1) ++v;
        s[j] = R[j];
      } else if (R[j] == s[j]) {
        t[j] ~= i;
        ++u[i];
        if (u[i] == 1) ++v;
      }
    }
    io.put(v);
  }
}

auto io = IO!()();
import lib.io;
