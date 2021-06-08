// URL: https://yukicoder.me/problems/no/1506

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  auto g = new int[](N*2+1), j = 1;
  foreach (Ai; A) {
    g[j] = mex(g[j-1..j]);
    ++j;
    if (Ai > 1) {
      g[j] = mex(g[j-2..j]);
      ++j;
    }
  }

  io.putB(g[j-1] == 0, "Bob", "Alice");
}

auto mex(int[] a)
{
  foreach (i; 0..3)
    if (!a.canFind(i)) return i;
  assert(0);
}

auto io = IO!()();
import lib.io;
