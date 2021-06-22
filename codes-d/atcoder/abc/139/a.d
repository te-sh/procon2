// URL: https://atcoder.jp/contests/abc139/tasks/abc139_a

import std;

version(unittest) {} else
void main()
{
  string S; io.getV(S);
  string T; io.getV(T);
  io.put(zip(S, T).count!"a[0]==a[1]");
}

auto io = IO!()();
import lib.io;
