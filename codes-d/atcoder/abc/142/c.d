// URL: https://atcoder.jp/contests/abc142/tasks/abc142_c

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  struct P { int i, j; }
  auto p = new P[](N);
  foreach (i, Ai; A)
    p[i] = P(i.to!int, Ai);
  p.sort!"a.j<b.j";

  io.put(p.map!"a.i+1");
}

auto io = IO!()();
import lib.io;
