// URL: https://atcoder.jp/contests/abc132/tasks/abc132_f

import std.algorithm, std.container, std.math, std.range, std.typecons, std.string;

const mod = 10^^9+7;
alias mint = ModInt!mod;

version(unittest) {} else
void main()
{
  int n, k; io.getV(n, k);

  auto s = n.nsqrt;
  auto t = iota(1, s+1).map!(i => max(s, n/i)).array;
  t ~= s;
  t.reverse();

  auto dp1 = new mint[][](k, s+1), dp2 = new mint[][](k, s+1);
  foreach (i; 1..s+1) dp1[0][i] = 1;
  foreach (i; 1..s+1) dp2[0][i] = t[i]-t[i-1];

  foreach (i; 0..k-1) {
    auto c1 = dp1[i].cumulativeSum, c2 = dp2[i].cumulativeSum;
    foreach (j; 1..s+1)
      dp1[i+1][j] = c1[0..$] + c2[0..$-j+1];
    foreach (j; 1..s+1)
      dp2[i+1][j] = c1[0..$-j+1] * (t[j]-t[j-1]);
  }

  io.put(dp1[k-1].sum + dp2[k-1].sum);
}

class CumulativeSum(T)
{
  size_t n;
  T[] s;

  this(T[] a)
  {
    n = a.length;
    s = new T[](n+1);
    static if (T.init != 0) s[0] = T(0);
    foreach (i; 0..n) s[i+1] = s[i] + a[i];
  }

  pure auto opSlice(size_t l, size_t r) { return s[r]-s[l]; }
  pure auto opDollar() { return n; }
}
auto cumulativeSum(T)(T[] a) { return new CumulativeSum!T(a); }

pure auto nsqrt(T)(T n)
{
  import std.algorithm, std.conv, std.math, std.range;
  if (n <= 1) return n;
  T m = T(1) << (n.ilogb/2+1);
  return iota(1, m).map!"a*a".assumeSorted!"a <= b".lowerBound(n).length.to!T;
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
  import std.algorithm, std.conv, std.format, std.range, std.stdio, std.traits;

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
  {
    v = new T(n);
    foreach (ref w; v) get(w);
  }

  auto getC(T...)(size_t n, ref T v)
  {
    foreach (ref w; v)
      w = new typeof(w)(n);
    foreach (i; 0..n)
      foreach (ref w; v) get(w[i]);
  }

  auto getM(T)(size_t r, size_t c, T v)
  {
    v = new T(r, c);
    foreach (ref w; v) getA(c, w);
  }

  auto putA(T)(T v)
  {
    static if (isInputRange!T && hasLength!T && !isSomeString!T) {
      foreach (i, w; v) {
        putA(w);
        if (i < v.length - 1) write(delimiter);
      }
    } else if (isFloatingPoint!T) {
      writef(format("%%.%df", precision), v);
    } else {
      write(v);
    }
  }

  auto put(T...)(T v)
  {
    foreach (i, w; v) {
      putA(w);
      if (i < v.length - 1) write(delimiter);
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
