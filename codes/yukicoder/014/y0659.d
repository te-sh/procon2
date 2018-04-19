// URL: https://yukicoder.me/problems/no/659

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

version(unittest) {} else
void main()
{
  int r, c, t; readV(r, c, t);
  int sx, sy; readV(sx, sy);
  int gx, gy; readV(gx, gy);
  string[] b; readC(r, b);

  auto n = (r-2)*(c-2), a = Matrix!real(n, n);
  auto idx(int i, int j) { return (i-1)*(c-2)+(j-1); }

  foreach (i; 1..r-1)
    foreach (j; 1..c-1) {
      if (b[i][j] == '#') continue;
      auto d = [b[i-1][j], b[i+1][j], b[i][j-1], b[i][j+1]].map!(bij => bij == '.' ? 1 : 0).sum;
      auto id1 = idx(i, j);
      if (d == 0) {
        a[id1][id1] = 1;
      } else {
        if (b[i-1][j] == '.') a[idx(i-1, j)][id1] = 1.0L/d;
        if (b[i+1][j] == '.') a[idx(i+1, j)][id1] = 1.0L/d;
        if (b[i][j-1] == '.') a[idx(i, j-1)][id1] = 1.0L/d;
        if (b[i][j+1] == '.') a[idx(i, j+1)][id1] = 1.0L/d;
      }
    }

  auto v = new real[](n);
  v[] = 0; v[idx(sx, sy)] = 1;

  auto p = repeatedSquare(a, t, Matrix!real.unit(n)) * v;
  writefln("%.7f", p[idx(gx, gy)]);
}

pure T repeatedSquare(alias pred = "a * b", T, U)(T a, U n)
{
  return repeatedSquare!(pred, T, U)(a, n, T(1));
}

pure T repeatedSquare(alias pred = "a * b", T, U)(T a, U n, T init)
{
  import std.functional;
  alias predFun = binaryFun!pred;

  if (n == 0) return init;

  auto r = init;
  while (n > 0) {
    if (n&1) r = predFun(r, a);
    a = predFun(a, a);
    n >>= 1;
  }

  return r;
}

struct Matrix(T)
{
  size_t r, c;
  T[][] a;
  alias a this;

  static ref auto unit(size_t n)
  {
    auto r = Matrix!T(n, n);
    foreach (i; 0..n) r[i][i] = 1;
    return r;
  }

  this(size_t r, size_t c)
  {
    this.r = r; this.c = c;
    a = new T[][](r, c);
    static if (T.init != 0) foreach (i; 0..r) a[i][] = 0;
  }

  this(T[][] b)
  {
    r = b.length;
    c = b[0].length;
    a = b;
  }

  ref auto dup() { auto x = Matrix!T(r, c); foreach (i; 0..r) x[i][] = a[i][]; return x; }

  ref auto opBinary(string op)(Matrix!T b) if (op == "+" || op == "-") in { assert(r == b.r && c == b.c); } body
  {
    auto x = Matrix!T(r, c);
    foreach (i; 0..r) foreach (j; 0..c) x[i][j] = mixin("a[i][j]"~op~"b[i][j]");
    return x;
  }

  ref auto opBinary(string op: "*")(Matrix!T b) in { assert(c == b.r); } body
  {
    auto x = Matrix!T(r, b.c);
    foreach (i; 0..r) foreach (j; 0..b.c) foreach (k; 0..c) x[i][j] += a[i][k]*b[k][j];
    return x;
  }

  ref auto opBinary(string op: "*")(T[] b) in { assert(c == b.length); } body
  {
    auto x = new T[](r);
    static if (T.init != 0) x[] = 0;
    foreach (i; 0..r) foreach (j; 0..c) x[i] += a[i][j]*b[j];
    return x;
  }
}
