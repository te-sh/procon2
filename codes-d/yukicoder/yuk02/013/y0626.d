// URL: https://yukicoder.me/problems/no/626

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int n; long tw; io.getV(n, tw);
  C[] c; io.getS!("v", "w")(n, c);

  c.sort!((a, b) => a.v.to!double/a.w > b.v.to!double/b.w);

  auto p = 0L;

  auto lowerUpper(int i, C s)
  {
    auto u = 0.0L;
    foreach (j; i..n) {
      if (s.w < c[j].w) {
        u = s.v + c[j].v.to!double/c[j].w*s.w;
        break;
      }
      s += c[j];
    }
    return tuple(s.v, max(u.floor.to!long, s.v));
  }

  auto dfs(int i, C s)
  {
    if (i == n) return;

    auto lu = lowerUpper(i, s);
    if (lu[1] < p) return;
    p.maxU(lu[0]);

    dfs(i+1, s);
    if (s.w >= c[i].w) dfs(i+1, s+c[i]);
  }

  dfs(0, C(0, tw));

  io.put(p);
}

struct C
{
  long v, w;
  auto opBinary(string op: "+")(C a) { return C(v+a.v, w-a.w); }
  auto opOpAssign(string op: "+")(C a) { v += a.v; w -= a.w; return this; }
}

import lib.minmax;

auto io = IO!()();
import lib.io;
