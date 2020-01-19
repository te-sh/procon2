// URL: https://atcoder.jp/contests/abc127/tasks/abc127_e

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
alias mint = ModInt!mod;

version(unittest) {} else
void main()
{
  int n, m, k; readV(n, m, k);

  auto fact = Fact!mint(n*m);
  auto r1 = (mint(n)*(n-1)*(n*2-1)/12+mint(n)*(n-1)/4)*m*m*fact.combi(n*m-2, k-2);
  auto r2 = (mint(m)*(m-1)*(m*2-1)/12+mint(m)*(m-1)/4)*n*n*fact.combi(n*m-2, k-2);
  writeln(r1+r2);
}

struct Fact(T, bool noInv = false)
{
  size_t n;
  T[] table, invTable;

  this(size_t n)
  {
    this.n = n;

    table = new T[](n+1); table[0] = 1;
    foreach (i; 1..cast(int)n+1) table[i] = table[i-1]*i;

    static if (!noInv) {
      invTable = new T[](n+1); invTable[n] = T(1)/table[n];
      foreach_reverse (i; 1..cast(int)n+1) invTable[i-1] = invTable[i]*i;
    }
  }

  auto combi(size_t a, size_t b)
  in { assert(!noInv && n >= a && a >= b); }
  body {
    return table[a]*invTable[b]*invTable[a-b];
  }
}

struct ModInt(int m, bool pos = false)
{
  version(BigEndian) union { long l; struct { int i2; int i; } } else union { long l; int i; }
  alias M = ModInt!(m, pos);
  @property static init() { return M(0); }
  @property int value() { return i; }
  @property void value(int v) { i = mod(v); }
  alias value this;

  this(int v) { i = v; }
  this(int v, bool runMod) { i = runMod ? mod(v) : v; }
  this(long v) { i = mod(v); }

  ref auto opAssign(int v) { i = v; return this; }

  pure auto mod(int v) const { static if (pos) return v%m; else return (v%m+m)%m; }
  pure auto mod(long v) const { static if (pos) return cast(int)(v%m); else return cast(int)((v%m+m)%m); }

  static if (!pos) pure auto opUnary(string op: "-")() { return M(mod(-i)); }

  static if (m < int.max / 2) {
    pure auto opBinary(string op)(int r) if (op == "+" || op == "-") { return M(mod(mixin("i"~op~"r"))); }
    ref auto opOpAssign(string op)(int r) if (op == "+" || op == "-") { i = mod(mixin("i"~op~"r")); return this; }
  } else {
    pure auto opBinary(string op)(int r) if (op == "+" || op == "-") { return M(mod(mixin("l"~op~"r"))); }
    ref auto opOpAssign(string op)(int r) if (op == "+" || op == "-") { i = mod(mixin("l"~op~"r")); return this; }
  }
  pure auto opBinary(string op: "*")(int r) { return M(mod(l*r)); }
  ref auto opOpAssign(string op: "*")(int r) { i = mod(l*r); return this; }

  pure auto opBinary(string op)(M r) if (op == "+" || op == "-" || op == "*") { return opBinary!op(r.i); }
  ref auto opOpAssign(string op)(M r) if (op == "+" || op == "-" || op == "*") { return opOpAssign!op(r.i); }

  pure auto opBinary(string op: "/")(M r) { return M(mod(l*r.inv.i)); }
  ref auto opOpAssign(string op: "/")(M r) { i = mod(l*r.inv.i); return this; }

  pure auto opBinary(string op: "/")(int r) { return opBinary!op(M(r)); }
  ref auto opOpAssign(string op: "/")(int r) { return opOpAssign!op(M(r)); }

  pure auto opBinary(string op: "^^", U)(U n)
  {
    auto x = M(1);
    if (n == 0) return x;

    auto b = M(i);
    for (; n > 0; n >>= 1) {
      if (n&1) x *= b;
      b *= b;
    }

    return x;
  }

  pure auto inv()
  {
    int x = i, a, b;
    exEuclid(x, m, a, b);
    return M(mod(a));
  }

  pure int exEuclid(int a, int b, ref int x, ref int y)
  {
    auto g = a;
    x = 1; y = 0;
    if (b) {
      g = exEuclid(b, a%b, y, x);
      y -= a/b*x;
    }
    return g;
  }
}
