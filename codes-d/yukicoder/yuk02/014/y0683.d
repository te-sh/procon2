// URL: https://yukicoder.me/problems/no/683

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long A, B; io.getV(A, B);

  bool[long][long] memo;
  bool calc(long a, long b)
  {
    if (a == 0 || b == 0) return true;
    if (a in memo && b in memo[a]) return memo[a][b];
    if (a%2 == 0 && b > 0)
      if (calc(a/2, b-1)) return memo[a][b] = true;
    if (b%2 == 0 && a > 0)
      if (calc(a-1, b/2)) return memo[a][b] = true;
    return memo[a][b] = false;
  }

  io.putB(calc(A, B), "Yes", "No");
}

auto io = IO!()();
import lib.io;
