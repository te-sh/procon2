// URL: https://yukicoder.me/problems/no/625

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);

  auto p = [M];
  foreach (i; 2..N+1) {
    auto s = p.enumerate.array;
    s.multiSort!("a[1]<b[1]", "a[0]<b[0]");
    s = s[0..i/2];
    if (s.map!"a[1]".sum+i/2 > M) {
      p ~= -1;
      continue;
    }

    auto v = new bool[](i-1);
    foreach (si; s) {
      ++p[si[0]];
      v[si[0]] = true;
    }
    foreach (j; 0..i-1)
      if (!v[j]) p[j] = 0;

    p ~= M-p.sum;
  }

  io.put(p.retro);
}

auto io = IO!()();
import lib.io;
