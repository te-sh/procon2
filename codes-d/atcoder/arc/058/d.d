// URL: https://atcoder.jp/contests/abc042/tasks/arc058_b

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

const mod = 10^^9+7;
alias mint = FactorRing!mod;

version(unittest) {} else
void main()
{
  int h, w, a, b; readV(h, w, a, b);

  auto fact = new mint[](h+w+1);
  fact[0] = 1;
  foreach (i; 1..h+w+1) fact[i] = fact[i-1]*i;
  auto invFact = new mint[](h+w+1);
  invFact[h+w] = fact[h+w].inv;
  foreach_reverse (i; 1..h+w+1) invFact[i-1] = invFact[i]*i;

  auto r = mint(0);
  foreach (k; 0..w-b) {
    auto c1 = fact[(h-a-1)+(b+k)]*invFact[h-a-1]*invFact[b+k];
    auto c2 = fact[(a-1)+(w-1-b-k)]*invFact[a-1]*invFact[w-1-b-k];
    r += c1*c2;
  }

  writeln(r);
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
