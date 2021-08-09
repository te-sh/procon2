// URL: https://yukicoder.me/problems/no/667

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv;

version(unittest) {} else
void main()
{
  string P; io.getV(P);
  auto ok = P.count('o'), ng = P.count('x'), n = ok+ng;

  foreach (Pi; P) {
    io.put(ok.to!double/(ok+ng)*100);
    if (Pi == 'o') --ok;
    else           --ng;
  }
}

auto io = IO!()();
import lib.io;
