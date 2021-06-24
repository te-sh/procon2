// URL: https://atcoder.jp/contests/abc141/tasks/abc141_c

import std;

version(unittest) {} else
void main()
{
  int N, K, Q; io.getV(N, K, Q);

  auto b = new int[](N);
  foreach (_; 0..Q) {
    int Ai; io.getV(Ai); --Ai;
    b[Ai]++;
  }

  foreach (bi; b)
    io.putB(K-(Q-bi) > 0, "Yes", "No");
}

auto io = IO!()();
import lib.io;
