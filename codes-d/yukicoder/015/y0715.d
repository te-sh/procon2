// URL: https://yukicoder.me/problems/no/715

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

const g = "011203110332240522330113021104527401120311033224455233011302110453748112031103322445593301130211045374".
  map!(gi => cast(int)(gi-'0')).array;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  auto grundy(int c)
  {
    return c < 68 ? g[c] : g[68+c%34];
  }

  A.sort;
  foreach (i; 0..N) A[i] -= i;
  io.putB(A.group.map!"a[1]".map!(ci => grundy(cast(int)ci)).reduce!"a^b" == 0, "Second", "First");
}

auto io = IO!()();
import lib.io;
