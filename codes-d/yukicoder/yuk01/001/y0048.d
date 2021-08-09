// URL: https://yukicoder.me/problems/no/48

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int X; io.getV(X);
  int Y; io.getV(Y);
  int L; io.getV(L);

  if (Y >= 0) {
    if (X == 0)
      io.put(cdiv(Y, L));
    else if (X >= 0)
      io.put(cdiv(Y, L) + 1 + cdiv(X, L));
    else
      io.put(cdiv(Y, L) + 1 + cdiv(X.abs, L));
  } else {
    if (X >= 0)
      io.put(1 + cdiv(X, L) + 1 + cdiv(Y.abs, L));
    else
      io.put(1 + cdiv(X.abs, L) + 1 + cdiv(Y.abs, L));
  }
}

import lib.math.misc;

auto io = IO!()();
import lib.io;
