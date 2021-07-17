// URL: https://atcoder.jp/contests/abc148/tasks/abc148_b

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  string S, T; io.getV(S, T);

  dchar[] r;
  foreach (Si, Ti; lockstep(S, T)) {
    r ~= [Si] ~ [Ti];
  }
  io.put(r);
}

auto io = IO!()();
import lib.io;
