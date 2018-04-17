// URL: https://yukicoder.me/problems/no/655

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

alias point = Point!int;

version(unittest) {} else
void main()
{
  int n, k, p; readV(n, k, p);
  point[] b; readS(k, b);
  foreach (ref bi; b) { --bi.x; --bi.y; }

  auto a = new int[][](n);
  foreach (i; 0..n) {
    a[i] = new int[](i+1);
    a[i][] = -1;
  }

  auto q = DList!point(b), dp = [point(-1, -1), point(0, -1), point(-1, 0), point(1, 0), point(0, 1), point(1, 1)];
  foreach (ref bi; b) a[bi.y][bi.x] = 0;
  while (!q.empty) {
    auto pp = q.front; q.removeFront;
    foreach (dpi; dp) {
      auto np = pp + dpi;
      if (np.x < 0 || np.x >= n || np.y < 0 || np.y > np.x) continue;
    }
  }
}

struct Point(T)
{
  T x, y;
  pure auto opBinary(string op)(Point!T r) if (op == "+" || op == "-") { return mixin("Point!T(x"~op~"r.x,y"~op~"r.y)"); }
  pure auto opBinary(string op)(T a) if (op == "*" || op == "/") { return mixin("Point!T(x"~op~"a,y"~op~"a)"); }
  auto opOpAssign(string op)(Point!T r) if (op == "+" || op == "-") { mixin("x"~op~"=r.x; y"~op~"=r.y;"); return this; }
  auto opOpAssign(string op)(T a) if (op == "*" || op == "/") { mixin("x"~op~"=a; y"~op~"=a;"); return this; }
  pure auto opBinary(string op: "*")(Point!T r) { return x*r.x + y*r.y; }
  pure auto hypot2() const { return x^^2 + y^^2; }
}
