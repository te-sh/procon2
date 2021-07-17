// URL: https://atcoder.jp/contests/abc147/tasks/abc147_c

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto x = new int[][](N), y = new int[][](N);
  foreach (i; 0..N) {
    int Ai; io.getV(Ai);
    io.getC(Ai, x[i], y[i]); x[i][] -= 1;
  }

  auto valid(int i)
  {
    foreach (j; 0..N) {
      foreach (xij, yij; lockstep(x[j], y[j]))
        if (i.bitTest(j)) {
          if (i.bitTest(xij) != (yij == 1))
            return false;
        }
    }
    return true;
  }

  auto m = 0;
  foreach (i; 0..1<<N) {
    if (valid(i))
      m.maxU(i.popcnt);
  }
  io.put(m);
}

import lib.bitop;
import lib.minmax;

auto io = IO!()();
import lib.io;
