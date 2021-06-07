// URL: https://atcoder.jp/contests/typical90/tasks/typical90_aj

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, Q; io.getV(N, Q);

  auto p = new P[](N);
  foreach (i; 0..N) {
    long xi, yi; io.getV(xi, yi);
    p[i] = P(xi, yi);
  }

  auto q = new P[](N);
  foreach (i, pi; p)
    q[i] = P(pi.x+pi.y, pi.x-pi.y);

  auto q1 = q.dup.sort!"a.x<b.x";
  auto q2 = q.dup.sort!"a.y<b.y";

  foreach (_; 0..Q) {
    int qi; io.getV(qi); --qi;
    auto pi = p[qi], u = pi.x+pi.y, v = pi.x-pi.y;
    io.put(max(abs(u-q1.front.x), abs(u-q1.back.x), abs(v-q2.front.y), abs(v-q2.back.y)));
  }
}

struct P { long x, y; }

auto io = IO!()();
import lib.io;
