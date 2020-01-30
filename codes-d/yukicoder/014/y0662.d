// URL: https://yukicoder.me/problems/no/662

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv;

version(unittest) {} else
void main()
{
  int m = 5, k = 3;
  string[] s; int[] c; io.getC(m, s, c);
  auto n = new long[](k), a = new string[][](k);
  foreach (i; 0..k) {
    io.getV(n[i]);
    io.getC(n[i], a[i]);
  }

  auto u = new long[](m);
  foreach (i; 0..m) {
    auto t = a.map!(ai => ai.count(s[i]));
    u[i] = t.reduce!"a*b";
  }
  u[] *= 5;

  auto v = 0.0;
  foreach (i; 0..m) v += c[i].to!double * u[i];

  io.put(v/n.reduce!"a*b");
  foreach (ui; u) io.put(ui);
}

auto io = IO!()();
import lib.io;
