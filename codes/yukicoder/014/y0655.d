// URL: https://yukicoder.me/problems/no/655

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n, T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

alias point = Point!int;

version(unittest) {} else
void main()
{
  int n, k; long p; readV(n, k, p);
  point[] b; readS(k, b);
  foreach (ref bi; b) { --bi.x; --bi.y; }

  if (n == 1) {
    writeln(0);
    return;
  }

  auto a = kaidan!long(n);
  foreach (i; 0..n) a[i][] = -1;

  auto q = DList!point(b), dp = [point(-1, -1), point(-1, 0), point(0, -1), point(0, 1), point(1, 0), point(1, 1)];
  foreach (ref bi; b) a[bi.x][bi.y] = 0;
  while (!q.empty) {
    auto pp = q.front; q.removeFront;
    foreach (dpi; dp) {
      auto np = pp + dpi;
      if (np.x < 0 || np.x >= n || np.y < 0 || np.y > np.x || a[np.x][np.y] >= 0) continue;
      a[np.x][np.y] = a[pp.x][pp.y] + 1;
      q.insertBack(np);
    }
  }

  auto as = kaidan!long(n+1);
  foreach_reverse (i; 0..n)
    foreach (j; 0..i+1) {
      as[i][j] = as[i+1][j] + as[i+1][j+1] + a[i][j];
      if (i < n-1) as[i][j] -= as[i+2][j+1];
    }

  auto bs = kaidan2!long(n+1);
  foreach_reverse (i; 0..n)
    foreach (j; 0..i+1)
      bs[i][j+1] = bs[i][j]+bs[i+1][j+1]-bs[i+1][j]+a[i][j];

  auto calc(int i, int j, int e)
  {
    if (e == 0) return a[i][j];
    else return as[i][j]-as[i+e+1][j+e+1]-bs[i+e+1][j+e+1]+bs[i+e+1][j];
  }

  auto e = kaidan!int(n);
  foreach (j; 0..n) e[n-1][j] = as[n-1][j] >= p ? 0 : 1;

  foreach_reverse (i; 0..n-1)
    foreach (j; 0..i+1) {
      auto r = min(e[i+1][j], e[i+1][j+1]);
      while (r >= 0 && calc(i, j, r) >= p) --r;
      e[i][j] = r+1;
    }

  auto ans = 0L;
  foreach (i; 0..n)
    foreach (j; 0..i+1)
      ans += n-(e[i][j]+i);

  writeln(ans);
}

auto kaidan(T)(int n)
{
  auto a = new T[][](n);
  foreach (i; 0..n) a[i] = new T[](i+1);
  return a;
}

auto kaidan2(T)(int n)
{
  auto a = new T[][](n);
  foreach (i; 0..n) a[i] = new T[](i+2);
  return a;
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
