// URL: https://atcoder.jp/contests/abc143/tasks/abc143_c

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  string S; io.getV(S);

  auto c = '?', r = 0;
  foreach (Si; S) {
    if (c != Si) {
      c = Si;
      ++r;
    }
  }
  io.put(r);
}

auto io = IO!()();
import lib.io;
