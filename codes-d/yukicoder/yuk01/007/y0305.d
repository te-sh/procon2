// URL: https://yukicoder.me/problems/no/305

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  auto n = 10, k = "0000000000".dup, c = "0123456789".dup;

  auto query(int i, dchar c)
  {
    import core.stdc.stdlib : exit;
    k[i] = cast(char)c;
    io.put!"{flush: true}"(k);
    int m; string s; io.getV(m, s);
    if (s == "unlocked") exit(0);
    return m;
  }

  foreach (i; 0..n)
    k[i] = cast(char)c.map!(ci => tuple(ci, query(i, ci))).maxElement!"a[1]"[0];
}

auto io = IO!()();
import lib.io;
