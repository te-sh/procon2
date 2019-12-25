// URL: https://yukicoder.me/problems/no/789

import std.algorithm, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int n; io.getV(n);
  int[] t, a, b; io.getC(n, t, a, b);

  import std.stdio;
  
  int[] c;
  foreach (ti, ai, bi; lockstep(t, a, b)) {
    c ~= ai;
    if (ti == 1) c ~= bi;
  }
  c = c.sort().uniq.array;

  int[int] z;
  foreach (i, ci; c) z[ci] = cast(int)i;
  foreach (ti, ref ai, ref bi; lockstep(t, a, b)) {
    ai = z[ai];
    if (ti == 1) bi = z[bi];
  }

  auto s = new SegmentTree!(int, "a+b")(c.length);

  auto ans = 0L;
  foreach (ti, ai, bi; lockstep(t, a, b)) {
    if (ti == 0)
      s[ai] += bi;
    else
      ans += s[ai..bi+1];
  }

  io.put(ans);
}

class SegmentTree(T, alias pred = "a+b")
{
  import std.functional, std.math;
  alias predFun = binaryFun!pred;

  size_t n, an;
  T[] buf;
  T unit;

  @property auto data() { return buf[an..an+n]; }

  this(size_t n, T unit = T.init)
  {
    prepare(n, unit);
    if (T.init != unit) {
      buf[an..an+n][] = unit;
      propagateAll();
    }
  }

  this(T[] init, T unit = T.init)
  {
    prepare(init.length, unit);
    buf[an..an+n][] = init[];
    propagateAll();
  }

  auto prepare(size_t n, T unit)
  {
    this.n = n;
    this.unit = unit;
    an = (n-1).nextPow2;
    buf = new T[](an*2);
  }

  auto opIndexAssign(T val, size_t i)
  {
    buf[i += an] = val;
    propagate(i);
  }

  auto opIndexOpAssign(string op)(T val, size_t i)
  {
    mixin("buf[i += an]"~op~"=val;");
    propagate(i);
  }

  auto opIndexUnary(string op)(size_t i) if (op == "++" || op == "--")
  {
    mixin(op~"buf[i += an];");
    propagate(i);
  }

  pure auto opSlice(size_t l, size_t r)
  {
    l += an; r += an;
    T r1 = unit, r2 = unit;
    while (l != r) {
      if (l % 2) r1 = predFun(r1, buf[l++]);
      if (r % 2) r2 = predFun(buf[--r], r2);
      l /= 2; r /= 2;
    }
    return predFun(r1, r2);
  }

  pure auto opIndex(size_t i) { return buf[i+an]; }
  pure auto opDollar() { return n; }

private:

  auto propagateAll() { foreach_reverse (i; 1..an) buf[i] = predFun(buf[i*2], buf[i*2+1]); }
  auto propagate(size_t i) { while (i /= 2) buf[i] = predFun(buf[i*2], buf[i*2+1]); }
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
