// URL: https://yukicoder.me/problems/no/165

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, B; io.getV(N, B);

  struct P { int x, y, p; }
  P[] p; io.getS!("x", "y", "p")(N, p);

  p.sort!"a.y<b.y";
  auto za = new Zaatsu!int(p.map!"a.x");
  foreach (ref pi; p) pi.x = za.comp(pi.x);

  auto calc(P[] p)
  {
    auto n = p.length, s = 0;

    auto nextL(int l)
    {
      auto y = p[l].y;
      while (l < n && p[l].y == y) s -= p[l++].p;
      return l;
    }

    auto nextR(int r)
    {
      auto y = p[r].y;
      while (r < n && p[r].y == y) s += p[r++].p;
      return r;
    }

    auto l = 0, r = 0, c = 0;
    while (l < n) {
      while (s <= B) {
        c = max(c, r-l);
        if (r < n) r = nextR(r);
        else       break;
      }
      l = nextL(l);
    }

    return c;
  }

  auto r = 0;
  foreach (i; 0..za.n)
    foreach (j; i..za.n)
      r = max(r, calc(p.filter!(pi => i <= pi.x && pi.x <= j).array));

  io.put(r);
}

import lib.data_structure.zaatsu;

auto io = IO!()();
import lib.io;
