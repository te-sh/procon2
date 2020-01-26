// URL: https://yukicoder.me/problems/no/670

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, Q; io.getV(N, Q, seed);

  foreach (i; 0..10000) next();

  auto a = new int[](N);
  foreach (i; 0..N) a[i] = next();

  auto b = new int[][](1<<ub), c = new int[](1<<ub);
  foreach (ai; a) {
    b[ai>>db] ~= [ai];
    ++c[ai>>db];
  }
  auto cc = new int[](1<<ub+1);
  foreach (i; 0..1<<ub) cc[i+1] = cc[i]+c[i];

  auto ans = 0uL;
  foreach (ulong i; 0..Q) {
    auto x = next(), xi = (x>>db), r = cc[xi];
    foreach (bi; b[xi]) r += bi < x;
    ans ^= i * r;
  }

  io.put(ans);
}

ulong seed;
int next() {
  seed = seed ^ (seed << 13);
  seed = seed ^ (seed >> 7);
  seed = seed ^ (seed << 17);
  return cast(int)(seed >> 33);
}

const tb = 31, ub = 16, db = tb-ub;

auto io = IO!()();
import lib.io;
