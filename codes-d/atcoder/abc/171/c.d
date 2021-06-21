// URL: https://atcoder.jp/contests/abc171/tasks/abc171_c

import std;

version(unittest) {} else
void main()
{
  long N; io.getV(N); --N;

  auto i = 1;
  while (N >= 26L^^i) {
    N -= 26L^^i;
    ++i;
  }

  auto s = new dchar[](i);
  foreach (k; 0..i)
    s[$-k-1] = 'a' + ((N/26L^^k)%(26)).to!int;

  io.put(s);
}

auto io = IO!()();
import lib.io;
