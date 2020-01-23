// URL: https://yukicoder.me/problems/no/33

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, D, T; io.getV(N, D, T);
  long[] X; io.getA(N, X);

  long[][long] h;
  foreach (Xi; X) h[((Xi%D)+D)%D] ~= Xi >= 0 ? Xi/D : (Xi-D+1)/D;

  auto r = 0L;
  foreach (y; h.byValue) {
    Section!long[] s, t;
    foreach (yi; y) {
      auto z = section(yi-T, yi+T+1);
      t = [];
      foreach (si; s) {
	if (mergeable(si, z))
	  z = merge(si, z);
	else
	  t ~= si;
      }
      t ~= z;
      s = t.dup;
    }
    r += s.map!"a.end-a.start".sum;
  }

  io.put(r);
}

import lib.math.section;

auto io = IO!()();
import lib.io;
