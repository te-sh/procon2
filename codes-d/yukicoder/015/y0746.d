// URL: https://yukicoder.me/problems/no/746

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  if (N == 0) io.put!"{exit: true}"(0);

  io.put!"{newline: false}"("0.");
  foreach (i; 0..N) io.put!"{newline: false}"("142857"[i%6]);
  io.put;
}

auto io = IO!()();
import lib.io;
