// URL: https://yukicoder.me/problems/no/187

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] X, Y; io.getC(N, X, Y);

  auto x = GmpInt(X[0]), y = GmpInt(Y[0]);
  foreach (i; 1..N)
    if (!calc(x, y, GmpInt(X[i]), GmpInt(Y[i]))) io.put!"{exit: true}"(-1);

  auto mod = 10^^9+7;
  io.putB(x == 0, y%mod, x%mod);
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
