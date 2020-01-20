// URL: https://yukicoder.me/problems/no/12

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

const m = 5_000_000;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  auto t = A.map!(Ai => 1<<Ai).reduce!"a|b";
  auto p = [0] ~ Prime(m).array ~ [m+1];
  auto n = p.length, d = p.map!(pi => pi.digits).array;
  auto b = d.map!(di => (~t&di) == 0).array; b[0] = b[$-1] = false;

  auto i = 1, ml = 0;
  for (;;) {
    while (i < n && !b[i]) ++i;
    if (i == n) break;

    auto j = i, s = 0;
    while (j < n && b[j]) s |= d[j++];

    if (s == t) ml = max(ml, p[j]-p[i-1]-2);
    i = j+1;
  }

  io.putB(ml > 0, ml, -1);
}

auto digits(int x)
{
  auto r = 0;
  for (; x > 0; x /= 10) r = r.bitSet(x%10);
  return r;
}

import lib.bitop;

import lib.math.prime;

auto io = IO!()();
import lib.io;
