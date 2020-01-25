// URL: https://yukicoder.me/problems/no/40

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int D; io.getV(D);
  int[] a; io.getA(D+1, a);

  a = a.padRight(0, 3).array;

  foreach_reverse (i; 0..D-2) {
    a[i+1] += a[i+3];
    a[i+3] = 0;
  }

  if (a[2] != 0) {
    io.put(2);
    io.put(a[0..3]);
  } else if (a[1] != 0) {
    io.put(1);
    io.put(a[0..2]);
  } else {
    io.put(0);
    io.put(a[0..1]);
  }
}

auto io = IO!()();
import lib.io;
