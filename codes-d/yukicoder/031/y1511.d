// URL: https://yukicoder.me/problems/no/1511

import std;

version(unittest) {} else
void main()
{
  int A, B; io.getV(A, B);
  io.put((A|B) - (A&B));
}

auto io = IO!()();
import lib.io;
