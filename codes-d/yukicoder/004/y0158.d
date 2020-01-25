// URL: https://yukicoder.me/problems/no/158

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int At, Ah, Ao; io.getV(At, Ah, Ao);
  int Db; io.getV(Db);
  int Bt, Bh, Bo; io.getV(Bt, Bh, Bo);
  int Dc; io.getV(Dc);
  int Ct, Ch, Co; io.getV(Ct, Ch, Co);

  auto a = W(At, Ah, Ao), b = W(Bt, Bh, Bo), c = W(Ct, Ch, Co);

  auto m = new int[][][](11, 101, 10001);
  foreach (i; 0..11)
    foreach (j; 0..101)
      m[i][j][] = -1;

  int calc(W a)
  {
    if (a.t == -1) return -1;
    if (m[a.t][a.h][a.o] != -1)
      return m[a.t][a.h][a.o];

    auto ab = payAndGet(a, Db, b);
    auto ac = payAndGet(a, Dc, c);

    return m[a.t][a.h][a.o] = max(calc(ab), calc(ac))+1;
  }

  io.put(calc(a));
}

struct W { int t, h, o; }

auto payAndGet(W a, int p, W g)
{
  auto pt = min(p/1000, a.t);
  a.t -= pt;
  p -= pt*1000;

  auto ph = min(p/100, a.h);
  a.h -= ph;
  p -= ph*100;

  if (p > a.o) return W(-1, -1, -1);

  a.o -= p;

  return W(a.t+g.t, a.h+g.h, a.o+g.o);
}

auto io = IO!()();
import lib.io;
