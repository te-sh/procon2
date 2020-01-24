// URL: https://yukicoder.me/problems/no/35

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto a = 0, b = 0;
  foreach (_; 0..N) {
    int T; string S; io.getV(T, S);
    auto c = 12*T/1000, d = cast(int)S.length;
    if (c >= d) {
      a += d;
    } else {
      a += c;
      b += d-c;
    }
  }
  io.put(a, b);
}

auto io = IO!()();
import lib.io;
