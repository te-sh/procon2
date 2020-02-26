// URL: https://yukicoder.me/problems/no/630

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);
  auto k = N/2;

  if (M < N-1 || M > k*(N-k)) io.put!"{exit: true}"("NO");

  io.put("YES");
  io.put(iota(1, N+1));

  foreach (i; 0..k) {
    io.put(i+1, k+i+1);
    if (k+i+1 < N) io.put(i+1, k+i+2);
  }
  auto c = N-1;

  foreach (i; 0..k)
    foreach (j; k..N) {
      if (c == M) return;
      if (i+k == j || i+k+1 == j) continue;
      io.put(i+1, j+1);
      ++c;
    }
}

auto io = IO!()();
import lib.io;
