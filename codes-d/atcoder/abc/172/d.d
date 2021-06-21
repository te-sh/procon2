// URL: https://atcoder.jp/contests/abc172/tasks/abc172_d

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto d = new int[](N+1);
  foreach (i; 1..N+1)
    for (auto j = i; j <= N; j += i)
      ++d[j];

  auto r = 0L;
  foreach (i; 1..N+1)
    r += i.to!long*d[i];

  io.put(r);
}

auto io = IO!()();
import lib.io;
