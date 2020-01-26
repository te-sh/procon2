// URL: https://yukicoder.me/problems/no/661

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int i; io.getV(i);
  foreach (_; 0..i) {
    int N; io.getV(N);
    if (N%8 == 0 && N%10 == 0)
      io.put("ikisugi");
    else if (N%8 == 0)
      io.put("iki");
    else if (N%10 == 0)
      io.put("sugi");
    else
      io.put(N/3);
  }
}

auto io = IO!()();
import lib.io;
