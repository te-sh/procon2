// URL: https://yukicoder.me/problems/no/641

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

const mod = 10^^9+9;
alias mint = FactorRing!mod;

version(unittest) {} else
void main()
{
  int n, k; readV(n, k);
  long[] a; readA(n, a);

  auto m = mint(0), s = mint(0);
  foreach (i; 0..k) {
    m += mint(2).repeatedSquare(k+i-1)*n;
    auto c1 = a.count!(ai => ai.bitTest(i)).to!int, c0 = n-c1;
    auto d0 = mint((c0*2-n).abs), d1= mint((c1*2-n).abs);
    if (k == 1)
      s += (d0*d0 + d1*d1)/2;
    else
      s += mint(2).repeatedSquare(k*2+i*2-3) * (d0*d0 + d1*d1);
  }

  writeln(m);
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

pragma(inline) {
  pure bool bitTest(T)(T n, size_t i) { return (n & (T(1) << i)) != 0; }
  pure T bitSet(T)(T n, size_t i) { return n | (T(1) << i); }
  pure T bitReset(T)(T n, size_t i) { return n & ~(T(1) << i); }
  pure T bitComp(T)(T n, size_t i) { return n ^ (T(1) << i); }

  pure T bitSet(T)(T n, size_t s, size_t e) { return n | ((T(1) << e) - 1) & ~((T(1) << s) - 1); }
  pure T bitReset(T)(T n, size_t s, size_t e) { return n & (~((T(1) << e) - 1) | ((T(1) << s) - 1)); }
  pure T bitComp(T)(T n, size_t s, size_t e) { return n ^ ((T(1) << e) - 1) & ~((T(1) << s) - 1); }

  import core.bitop;
  pure int bsf(T)(T n) { return core.bitop.bsf(ulong(n)); }
  pure int bsr(T)(T n) { return core.bitop.bsr(ulong(n)); }
  pure int popcnt(T)(T n) { return core.bitop.popcnt(ulong(n)); }
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
}
