// URL: https://yukicoder.me/problems/no/24

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto b = (1<<10)-1;
  foreach (_; 0..N) {
    int A, B, C, D; string R; io.getV(A, B, C, D, R);
    auto c = 0.bitSet(A).bitSet(B).bitSet(C).bitSet(D);
    b = R == "YES" ? b&c : b&~c;
  }
  io.put(b.bsf);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
