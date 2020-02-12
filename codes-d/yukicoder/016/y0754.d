// URL: https://yukicoder.me/problems/no/754

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int n; io.getV(n);
  int[] a; io.getC(n+1, a);
  int[] b; io.getC(n+1, b);

  auto s = mint(0), sb = mint(0);
  foreach (i; 0..n+1) {
    sb += b[i];
    s += sb*a[n-i];
  }

  io.put(s);
}

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
