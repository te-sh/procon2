// URL: https://atcoder.jp/contests/abc141/tasks/abc141_b

import std;

version(unittest) {} else
void main()
{
  string S; io.getV(S);

  foreach (i, Si; S)
    if (i%2 == 0 && Si == 'L' || i%2 == 1 && Si == 'R')
      io.put!"{exit: true}"("No");
  io.put("Yes");
}

auto io = IO!()();
import lib.io;
