// URL: https://yukicoder.me/problems/no/695

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.bigint;

const mod1 = 168647939L, mod2 = 592951213L, mod = mod1*mod2;

version(unittest) {} else
void main()
{
  int n, m; io.getV(n, m);
  int[] x; io.getA(m, x);

  auto n2 = (n+1)/2, c = new uint[](n2);
  auto calc(int mod)
  {
    c[] = 0; c[0] = 1;
    foreach (i; 1..n2)
      foreach (j; 0..m)
        if (i >= x[j]) (c[i] += c[i-x[j]]) %= mod;

    auto r = 0uL;
    foreach (j; 0..m)
      foreach (i; max(0, n2-x[j])..min(n-x[j], n2))
        (r += cast(ulong)c[i]*c[n-1-(i+x[j])]) %= mod;

    return cast(long)r;
  }

  auto r1 = BigInt(calc(mod1)), r2 = BigInt(calc(mod2));
  auto r = extGcd(mod1, mod2);
  io.put(((r1*r.y*mod2+r2*r.x*mod1)%mod+mod)%mod);
}

import lib.math.misc;

auto io = IO!()();
import lib.io;
