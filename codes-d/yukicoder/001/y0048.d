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
      io.put((Y+L-1)/L);
    else if (X >= 0)
      io.put((Y+L-1)/L + 1 + (X+L-1)/L);
    else
      io.put((Y+L-1)/L + 1 + (X.abs+L-1)/L);
  } else {
    if (X >= 0)
      io.put(1 + (X+L-1)/L + 1 + (Y.abs+L-1)/L);
    else
      io.put(1 + (X.abs+L-1)/L + 1 + (Y.abs+L-1)/L);
  }
}

auto io = IO!()();
import lib.io;
