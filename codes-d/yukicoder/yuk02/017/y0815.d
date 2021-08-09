// URL: https://yukicoder.me/problems/no/815

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  io.put(cdiv(N, 2));
}

import lib.math.misc;

auto io = IO!()();
import lib.io;
