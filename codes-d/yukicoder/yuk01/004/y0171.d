// URL: https://yukicoder.me/problems/no/171

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  string S; io.getV(S);

  auto c = new int[](26);
  foreach (Si; S) ++c[Si-'A'];

  auto cn = 1000, pf = primeFactorSqrtOf(cn);
  auto f = new int[](cn+1), n = cast(int)S.length;
  foreach (i; 2..n+1)
    foreach (e; pf.div(i)) f[e.prime] += e.exp;

  foreach (ci; c)
    foreach (i; 2..ci+1)
      foreach (e; pf.div(i)) f[e.prime] -= e.exp;

  auto r = mint(1);
  foreach (i, fi; f)
    r *= mint(i)^^fi;

  io.put(r-1);
}

import lib.math.prime_factor;

const mod = 573;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
