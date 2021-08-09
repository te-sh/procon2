// URL: https://yukicoder.me/problems/no/701

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int n; io.getV(n);

  foreach (i; 0..n) {
    auto r = ['a'];
    foreach (j; 0..5) r ~= i/10^^j%10+'a';
    r ~= 'a';
    if (i == n-1) r ~= 'n';
    io.put(r);
  }
}

auto io = IO!()();
import lib.io;
