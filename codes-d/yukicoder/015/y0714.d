// URL: https://yukicoder.me/problems/no/714

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  int[string] h;
  auto neta(string s)
  {
    if (s !in h) h[s] = cast(int)h.length;
    return h[s];
  }

  auto ns = 20, nn = 53;
  auto l = new int[][](ns, nn);

  auto find(string s)
  {
    auto u = neta(s);
    foreach (i; 0..ns)
      if (l[i][u]) {
        --l[i][u];
        return i;
      }
    return -2;
  }

  foreach (_; 0..N) {
    int t; io.getV(t);

    switch (t) {
    case 0:
      int ni, mi; io.getV(ni, mi); --ni;
      foreach (_2; 0..mi) {
        string A; io.getV(A);
        ++l[ni][neta(A)];
      }
      break;
    case 1:
      string B; io.getV(B);
      io.put(find(B)+1);
      break;
    case 2:
      int C; io.getV(C); --C;
      l[C][] = 0;
      break;
    default:
      assert(0);
    }
  }
}

auto io = IO!()();
import lib.io;
