struct ConvexHullTrickSimple(T)
{
  import std.typecons;

  alias Line = Tuple!(T, T);
  Line[] deq;
  int s = 0, t = 0;

  this(size_t n)
  {
    deq = new Line[](n);
  }

  auto add(T a, T b)
  {
    auto p = Line(a, b);
    while (s+1 < t && check(deq[t-2], deq[t-1], p)) --t;
    deq[t++] = p;
  }

  auto get(T x)
  {
    while (s+1 < t && f(deq[s], x) >= f(deq[s+1], x)) ++s;
    return f(deq[s], x);
  }

  auto check(Line p1, Line p2, Line p3)
  {
    return (p2[0]-p1[0])*(p3[1]-p2[1]) >= (p2[1]-p1[1])*(p3[0]-p2[0]);
  }

  auto f(Line p, T x)
  {
    return p[0]*x+p[1];
  }
}

unittest
{
  auto cht = ConvexHullTrickSimple!int(4);
  cht.add(2, 2);
  cht.add(1, 3);
  cht.add(-1, 10);

  assert(cht.get(2) == 5);
  assert(cht.get(3) == 6);
  assert(cht.get(6) == 4);

  cht.add(-2, 15);
  assert(cht.get(6) == 3);
}
