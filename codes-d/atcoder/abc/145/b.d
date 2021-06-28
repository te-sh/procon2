// URL: https://atcoder.jp/contests/abc145/tasks/abc145_b

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  string S; io.getV(S);
  io.putB(N%2 == 0 && S[0..N/2] == S[N/2..$], "Yes", "No");
}

auto io = IO!()();
import lib.io;
