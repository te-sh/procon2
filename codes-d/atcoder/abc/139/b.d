// URL: https://atcoder.jp/contests/abc139/tasks/abc139_b

import std;

version(unittest) {} else
void main()
{
  int A, B; io.getV(A, B);

  auto r = 0, o = 1;
  while (o < B) {
    o += A-1;
    ++r;
  }
  io.put(r);
}

auto io = IO!()();
import lib.io;
