// URL: https://yukicoder.me/problems/no/724

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int n; double a, b; io.getV(n, a, b);

  auto c = (a+b)/2, d = (a*b).sqrt, eps = 1.0e-12L;

  struct Cir
  {
    real x, y, r;
    this(double x)
    {
      this.x = x;
      y = (d^^2 * (1 - (x-c)^^2/c^^2)).sqrt;
      r = ((x-a)^^2 + y^^2).sqrt - a;
    }
  }

  Cir e;
  if (n%2 == 1) {
    e = Cir(a+b);
    n = (n-1)/2;
  } else {
    auto calc1(double x)
    {
      auto e = Cir(x);
      return e.r - e.y;
    }
    auto x = iota(0.0, a+b, eps).lowerBoundBy!(x => calc1(x))(0).back;
    e = Cir(x);
    n = n/2-1;
  }

  auto calc(Cir e, double x2)
  {
    auto e2 = Cir(x2);
    return (e2.r+e.r) - ((e2.x-e.x)^^2+(e2.y-e.y)^^2).sqrt;
  }

  foreach (_; 0..n) {
    auto x2 = iota(0.0, e.x, eps).lowerBoundBy!(x2 => calc(e, x2))(0).back;
    e = Cir(x2);
  }

  io.put(e.r);
}

import lib.bound_by;

auto io = IO!()();
import lib.io;
