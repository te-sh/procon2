// URL: https://yukicoder.me/problems/no/681

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int n; io.getV(n);
  int b, d; io.getV(b, d);

  auto t = (mint(d+1)^^b-1)*(d+1)/d-b;

  long[] h = [0, d], s = [0, d];
  foreach (i; 2..31) {
    auto hi = h[i-1]*(d+1) + d;
    if (hi > n) break;
    h ~= hi;

    auto si = s[i-1]*(d+1) + i*d;
    s ~= si;
  }

  while (n > 0) {
    auto i = cast(int)h.filter!(hi => hi <= n).walkLength - 1;
    if (i == 0) {
      t -= n;
      n = 0;
    } else {
      t -= mint(s[i]);
      n -= h[i];
      if (n > 0) {
        t -= i+1;
        --n;
      }
    }
  }

  io.put(t);
}

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
