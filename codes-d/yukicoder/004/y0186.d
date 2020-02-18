// URL: https://yukicoder.me/problems/no/186

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int[] X, Y; io.getC(3, X, Y);

  auto x = GmpInt(X[0]), y = GmpInt(Y[0]);
  foreach (i; 1..3)
    if (!calc(x, y, GmpInt(X[i]), GmpInt(Y[i]))) io.put!"{exit: true}"(-1);

  io.putB(x == 0, y, x);
}

auto calc(T)(ref T X1, ref T Y1, T X2, T Y2)
{
  T b1, b2;
  auto g = extGcd(Y1, Y2, b1, b2);
  if ((X2-X1)%g != 0) return false;

  auto y1 = Y1/g, y2 = Y2/g;
  Y1 = y1*y2*g;
  X1 = (((b1*y1)%Y1*(X2-X1)+X1)%Y1+Y1)%Y1;
  return true;
}

import lib.math.gmp_int;

auto io = IO!()();
import lib.io;
