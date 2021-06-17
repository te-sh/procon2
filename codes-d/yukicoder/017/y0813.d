// URL: https://yukicoder.me/problems/no/813

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  double p; io.getV(p);
  double q; io.getV(q);

  if (p == 1) io.put!"{exit: true}"(1);

  auto p1 = p, q1 = q;
  foreach (i; 0..N-1) {
    auto p2 = p1+(q1*q1*p)/(1-p1*p);
    auto q2 = (q1*q)/(1-p1*p);
    p1 = p2; q1 = q2;
  }

  io.put(p1);
}

auto io = IO!()();
import lib.io;
