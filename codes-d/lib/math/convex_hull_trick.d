module lib.math.convex_hull_trick;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.math.convex_hull
/**
 ** 直線の集合 {fi(x)=ai*x+bi} に対して, 直線を追加することとある x′ に
 ** 対して最小値 min{fi(x′)} を求めることができます.
 ** ただし, 追加される直線の傾きは単調減少でなければなりません.
 **/
struct ConvexHullTrick(T, alias comp = "a>=b")
{
  import std.functional;
  alias compFun = binaryFun!comp;

  /**
   ** 直線 y=ax+b を追加します.
   **/
  void add(T a, T b)
  {
    auto line = Line(a, b);
    while (lines.length >= 2 && check(lines[$-2], lines[$-1], line))
      lines = lines[0..$-1];
    lines ~= line;
  }

  /**
   ** min{fi(x')} を返します.
   **/
  pure T query(T x)
  {
    ptrdiff_t low = -1, high = lines.length-1;
    while (high-low > 1) {
      auto mid = (high+low)/2;
      (compFun(lines[mid].f(x), lines[mid+1].f(x)) ? low : high) = mid;
    }
    return lines[high].f(x);
  }

  private
  {
    struct Line
    {
      T a, b;
      auto opCmp(Line r)
      {
        if (a < r.a) return -1;
        else if (a > r.a) return 1;
        if (b < r.b) return -1;
        else if (b > r.b) return 1;
        return 0;
      }
      auto f(T x) { return a*x+b; }
    }
    Line[] lines;

    bool check(Line l1, Line l2, Line l3)
    {
      if (l1 < l3) swap(l1, l3);
      return (l3.b-l2.b)*(l2.a-l1.a) >= (l2.b-l1.b)*(l3.a-l2.a);
    }
  }
}
// ::::::::::::::::::::

unittest
{
  auto cht = ConvexHullTrick!int();

  cht.add(2, 0);
  assert(cht.query(-2) == -4);
  assert(cht.query(2) == 4);

  cht.add(1, 1);
  assert(cht.query(-2) == -4);
  assert(cht.query(2) == 3);

  cht.add(0, -1);
  assert(cht.query(-2) == -4);
  assert(cht.query(2) == -1);
}
