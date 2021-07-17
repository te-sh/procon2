// URL: https://atcoder.jp/contests/abc171/tasks/abc171_e

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] a; io.getA(N, a);

  auto c = a.reduce!"a^b";
  io.put(a.map!(a => a^c));
}

auto io = IO!()();
import lib.io;
