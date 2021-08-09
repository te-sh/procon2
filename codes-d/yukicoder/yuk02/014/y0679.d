// URL: https://yukicoder.me/problems/no/679

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.bitmanip;

version(unittest) {} else
void main()
{
  int n, m; io.getV(n, m);

  auto h = new BitArray[](n);
  foreach (i; 0..n) {
    h[i] = BitArray();
    h[i].length = n;
  }

  foreach (_; 0..m) {
    int g, r; io.getV(g, r);
    int[] k; io.getA(r, k);
    foreach (ki; k) h[g-1][ki-1] = true;
  }

  auto c = BitArray();
  c.length = n;

 loop: for (;;) {
    foreach (i; 0..n) {
      if (c[i]) continue;
      if ((h[i]&c) == h[i]) {
        c[i] = true;
        continue loop;
      }
    }
    break;
  }

  io.put(c.count);
}

auto io = IO!()();
import lib.io;
