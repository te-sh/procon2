// URL: https://yukicoder.me/problems/no/3

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto b = new int[](N+1), inf = 10^^9;
  b[] = inf; b[1] = 1;

  auto q = DList!int(1);
  while (!q.empty) {
    auto i = q.front; q.removeFront();
    auto j1 = i-i.popcnt, j2 = i+i.popcnt;
    if (j1 >= 1 && b[j1] > b[i]+1) {
      b[j1] = b[i]+1;
      q.insertBack(j1);
    }
    if (j2 <= N && b[j2] > b[i]+1) {
      b[j2] = b[i]+1;
      q.insertBack(j2);
    }
  }

  io.putB(b[N] != inf, b[N], -1);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
