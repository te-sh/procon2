// URL: https://yukicoder.me/problems/no/797

import std.algorithm, std.container, std.math, std.range, std.typecons, std.string;

const mod = 10^^9+7;
alias mint = ModInt!mod;

version(unittest) {} else
void main()
{
  int n; io.getV(n);
  int[] a; io.getA(n, a);

  auto fact = Fact!mint(n), r = mint(0);
  foreach (i, ai; a) r += fact.combi(n-1, i) * ai;
  io.put(r);
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

  auto perm(size_t a, size_t b)
  in { assert(!noInv && n >= a && a >= b); }
  body {
    return table[a]*invTable[a-b];
  }

  auto combi(size_t a, size_t b)
  in { assert(!noInv && n >= a && a >= b); }
  body {
    return table[a]*invTable[b]*invTable[a-b];
  }

  auto homo(size_t a, size_t b)
  in { assert(!noInv && n >= a+b-1); }
  body {
    return combi(a+b-1, b);
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

auto io = IO();

struct IO
{
  import std.algorithm, std.conv, std.format, std.meta, std.range, std.stdio, std.traits;

  dchar[] buf;
  auto sp = (new dchar[](0)).splitter;
  int precision = 10;
  string delimiter = " ";

  void nextLine()
  {
    stdin.readln(buf);
    sp = buf.splitter;
  }

  auto get(T)(ref T v)
  {
    if (sp.empty) nextLine();
    v = sp.front.to!T;
    sp.popFront();
  }

  auto getV(T...)(ref T v)
  {
    foreach (ref w; v) get(w);
  }

  auto getA(T)(size_t n, ref T v)
  if (hasAssignableElements!T)
  {
    v = new T(n);
    foreach (ref w; v) get(w);
  }

  auto getC(T...)(size_t n, ref T v)
  if (allSatisfy!(hasAssignableElements, T))
  {
    foreach (ref w; v)
      w = new typeof(w)(n);
    foreach (i; 0..n)
      foreach (ref w; v) get(w[i]);
  }

  auto getM(T)(size_t r, size_t c, ref T v)
  if (hasAssignableElements!T && hasAssignableElements!(ElementType!T))
  {
    v = new T(r);
    foreach (ref w; v) getA(c, w);
  }

  auto rangePop(R)(ref R r)
  {
    r.popFront();
    if (!r.empty) write(delimiter);
  }

  auto putA(T)(T v)
  {
    static if (isInputRange!T && !isSomeString!T)
      for (auto w = v; !w.empty; rangePop(w)) putA(w.front);
    else if (isFloatingPoint!T)
      writef(format("%%.%df", precision), v);
    else
      write(v);
  }

  auto put(T...)(T v)
  {
    foreach (i, w; v) {
      putA(w);
      if (i < v.length-1) write(delimiter);
    }
    writeln;
  }

  auto putB(S, T)(bool c, S t, T f)
  {
    if (c)
      put(t);
    else
      put(f);
  }

  auto dbg(T...)(T v)
  {
    stderr.writeln(v);
  }
}
