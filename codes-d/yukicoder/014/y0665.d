// URL: https://yukicoder.me/problems/no/665

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  long n; int k; io.getV(n, k);

  auto fact = Fact!mint(k+2);

  auto b = new mint[](k+1);
  b[0] = 1;
  foreach (i; 1..k+1) {
    if (i >= 3 && i%2 == 1) continue;
    foreach (j; 0..i)
      if (i == 1 || i%2 == 0)
        b[i] -= fact.combi(i+1, j)*b[j];
    b[i] *= mint(i+1).inv;
  }

  auto s = mint(0), nb = mint(n+1);
  foreach_reverse (i; 0..k+1) {
    if (i == 1 || i%2 == 0)
      s += fact.combi(k+1, i)*b[i]*nb;
    nb *= mint(n+1);
  }
  s *= mint(k+1).inv;

  io.put(s);
}

import lib.math.fact;

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
