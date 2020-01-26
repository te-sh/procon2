// URL: https://yukicoder.me/problems/no/657

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

const mod = 17;

version(unittest) {} else
void main()
{
  int Q; io.getV(Q);
  int[] n; io.getC(Q, n);

  auto mn = max(n.maxElement, 4);
  auto t = new int[](mn+1);
  t[4] = 1;
  foreach (i; 5..mn+1)
    t[i] = (t[i-1]+t[i-2]+t[i-3]+t[i-4])%mod;

  foreach (i; 0..Q) io.put(t[n[i]]);
}

auto io = IO!()();
import lib.io;
