// URL: https://atcoder.jp/contests/abc144/tasks/abc144_d

import std;

version(unittest) {} else
void main()
{
  double a, b, x; io.getV(a, b, x);
  auto y = x/a;

  if (y < a*b/2) {
    io.put(acos((y*2)/(b*sqrt(b^^2+((y*2)/b)^^2)))/PI*180);
  } else {
    auto z = a*b-y;
    io.put(asin((z*2)/(a*sqrt(a^^2+((z*2)/a)^^2)))/PI*180);
  }
}

auto io = IO!()();
import lib.io;
