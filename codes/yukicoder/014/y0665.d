// URL: https://yukicoder.me/problems/no/665

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

const mod = 10^^9+7;
alias mint = FactorRing!mod;

version(unittest) {} else
void main()
{
  long n; int k; readV(n, k);

  auto fact = new mint[](k+2);
  fact[0] = 1;
  foreach (i; 1..k+2) fact[i] = fact[i-1]*i;
  auto invFact = new mint[](k+2);
  invFact[k+1] = fact[k+1].inv;
  foreach_reverse (i; 1..k+2) invFact[i-1] = invFact[i]*i;

  auto b = new mint[](k+1);
  b[0] = 1;
  foreach (i; 1..k+1) {
    if (i >= 3 && i%2 == 1) continue;
    foreach (j; 0..i)
      if (i == 1 || i%2 == 0)
        b[i] -= fact[i+1]*invFact[i+1-j]*invFact[j]*b[j];
    b[i] *= mint(i+1).inv;
  }

  auto s = mint(0), nb = mint(n+1);
  foreach_reverse (i; 0..k+1) {
    if (i == 1 || i%2 == 0)
      s += fact[k+1]*invFact[k+1-i]*invFact[i]*b[i]*nb;
    nb *= mint(n+1);
  }
  s *= mint(k+1).inv;

  writeln(s);
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
