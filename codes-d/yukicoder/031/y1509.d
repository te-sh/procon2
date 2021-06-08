// URL: https://yukicoder.me/problems/no/1509

import std;

version(unittest) {} else
void main()
{
  int T; io.getV(T);
  foreach (_; 0..T) {
    long N, A, B; io.getV(N, A, B);
    io.putB(gcd(A, B) == 1 && A - 1 <= N - B, "YES", "NO");
  }
}

auto io = IO!()();
import lib.io;
