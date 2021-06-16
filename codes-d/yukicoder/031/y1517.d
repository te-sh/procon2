// URL: https://yukicoder.me/problems/no/1517

import std;

version(unittest) {} else
void main()
{
  int d; io.getV(d);
  int a, b; io.getV(a, b);

  io.putB(a < b, a*d, b*d);
}

auto io = IO!()();
import lib.io;
