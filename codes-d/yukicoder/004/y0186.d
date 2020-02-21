// URL: https://yukicoder.me/problems/no/186

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

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
  auto r = extGcd(Y1, Y2);
  if ((X2-X1)%r.gcd != 0) return false;

  auto y1 = Y1/r.gcd, y2 = Y2/r.gcd;
  Y1 = y1*y2*r.gcd;
  X1 = pmod(r.x*y1*(X2-X1)+X1, Y1);
  return true;
}

import lib.math.misc;

import lib.math.gmp_int;

auto io = IO!()();
import lib.io;
