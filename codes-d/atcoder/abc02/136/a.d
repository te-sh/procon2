// URL: https://atcoder.jp/contests/abc136/tasks/abc136_a

import std;

version(unittest) {} else
void main()
{
  int A, B, C; io.getV(A, B, C);
  io.putB(A-B > C, 0, C-(A-B));
}

auto io = IO!()();
import lib.io;
