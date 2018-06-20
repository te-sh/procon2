// URL: https://beta.atcoder.jp/contests/arc054/tasks/arc054_c

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n,T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

alias mint = FactorRing!2;

version(unittest) {} else
void main()
{
  int n; readV(n);
  string[] s; readC(n, s);

  auto m = Matrix!mint(n, n);
  foreach (i; 0..n)
    foreach (j; 0..n)
      m[i][j] = s[i][j] == '0' ? 0 : 1;

  writeln(m.det == 0 ? "Even" : "Odd");
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

  this(U)(U[][] b)
  {
    r = b.length;
    c = b[0].length;
    a = new T[][](r, c);
    foreach (i; 0..r) foreach (j; 0..c) a[i][j] = b[i][j];
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

T det(T)(Matrix!T a) in { assert(a.r == a.c); } body
{
  import std.algorithm, std.math;

  auto n = a.r, b = a.dup, d = T(1);

  foreach (i; 0..n) {
    auto p = i;
    foreach (j; i+1..n)
      if (b[p][i].abs < b[j][i].abs) p = j;
    swap(b[p], b[i]);
    foreach (j; i+1..n)
      foreach (k; i+1..n)
        b[j][k] -= b[i][k]*b[j][i]/b[i][i];
    d *= b[i][i];
    if (p != i) d = -d;
  }

  return d;
}

struct FactorRing(int m, bool pos = false)
{
  version(BigEndian) union { long vl; struct { int vi2; int vi; } } else union { long vl; int vi; }
  alias FR = FactorRing!(m, pos);
  @property static init() { return FR(0); }
  @property int value() { return vi; }
  @property void value(int v) { vi = mod(v); }
  alias value this;

  this(int v) { vi = v; }
  this(int v, bool runMod) { vi = runMod ? mod(v) : v; }
  this(long v) { vi = mod(v); }

  ref auto opAssign(int v) { vi = v; return this; }

  pure auto mod(int v) const { static if (pos) return v%m; else return (v%m+m)%m; }
  pure auto mod(long v) const { static if (pos) return cast(int)(v%m); else return cast(int)((v%m+m)%m); }

  static if (!pos) pure ref auto opUnary(string op: "-")() { return FR(mod(-vi)); }

  static if (m < int.max / 2) {
    pure ref auto opBinary(string op)(int r) if (op == "+" || op == "-") { return FR(mod(mixin("vi"~op~"r"))); }
    ref auto opOpAssign(string op)(int r) if (op == "+" || op == "-") { vi = mod(mixin("vi"~op~"r")); return this; }
  } else {
    pure ref auto opBinary(string op)(int r) if (op == "+" || op == "-") { return FR(mod(mixin("vl"~op~"r"))); }
    ref auto opOpAssign(string op)(int r) if (op == "+" || op == "-") { vi = mod(mixin("vl"~op~"r")); return this; }
  }
  pure ref auto opBinary(string op: "*")(int r) { return FR(mod(vl*r)); }
  ref auto opOpAssign(string op: "*")(int r) { vi = mod(vl*r); return this; }

  pure ref auto opBinary(string op)(ref FR r) if (op == "+" || op == "-" || op == "*") { return opBinary!op(r.vi); }
  ref auto opOpAssign(string op)(ref FR r) if (op == "+" || op == "-" || op == "*") { return opOpAssign!op(r.vi); }

  pure auto opBinary(string op: "/")(FR r) { return FR(mod(vl*r.inv.vi)); }
  pure auto opBinary(string op: "/")(int r) { return opBinary!op(FR(r)); }
  ref auto opOpAssign(string op: "/")(ref FR r) { vi = mod(vl*r.inv.vi); return this; }
  ref auto opOpAssign(string op: "/")(int r) { return opOpAssign!op(FR(r)); }

  pure auto inv()
  {
    int x = vi, a, b;
    exEuclid(x, m, a, b);
    return FR(mod(a));
  }
}

pure T exEuclid(T)(T a, T b, ref T x, ref T y)
{
  auto g = a;
  x = 1;
  y = 0;
  if (b) {
    g = exEuclid(b, a%b, y, x);
    y -= a/b*x;
  }
  return g;
}
