import std.stdio;
struct IO(alias IN = stdin, alias OUT = stdout, string delimiter = " ", string floatFormat = "%.10f")
{
  import std.algorithm, std.conv, std.format, std.meta, std.range, std.traits;
  alias assignable = hasAssignableElements;

  dchar[] buf;
  auto sp = (new dchar[](0)).splitter;
  void nextLine() { IN.readln(buf); sp = buf.splitter; }

  auto get(T)(ref T v) { if (sp.empty) nextLine(); v = sp.front.to!T; sp.popFront(); }
  auto getV(T...)(ref T v) { foreach (ref w; v) get(w); }
  auto getA(T)(size_t n, ref T v) if (assignable!T) { v = new T(n); foreach (ref w; v) get(w); }
  auto getC(T...)(size_t n, ref T v) if (allSatisfy!(assignable, T))
  {
    foreach (ref w; v) w = new typeof(w)(n);
    foreach (i; 0..n) foreach (ref w; v) get(w[i]);
  }
  auto getM(T)(size_t r, size_t c, ref T v) if (assignable!T && assignable!(ElementType!T))
  {
    v = new T(r); foreach (ref w; v) getA(c, w);
  }

  auto putR(T)(T v)
  {
    auto w = v;
    while (!w.empty) { putA(w.front); w.popFront(); if (!w.empty) OUT.write(delimiter); }
  }
  auto putA(T)(T v)
  {
    static if (isInputRange!T && !isSomeString!T) putR(v);
    else if (isFloatingPoint!T) OUT.write(format(floatFormat, v));
    else OUT.write(v);
  }
  auto put(T...)(T v)
  {
    foreach (i, w; v) { putA(w); if (i < v.length-1) OUT.write(delimiter); }
    OUT.writeln;
  }

  auto putB(S, T)(bool c, S t, T f) { if (c) put(t); else put(f); }
  auto putRaw(T...)(T v) { OUT.write(v); OUT.writeln; }
}

unittest
{
  import std.algorithm, std.conv, std.math, std.string;

  class DummyIn
  {
    string buf;

    auto readln(ref dchar[] r)
    {
      auto i = buf.indexOf('\n');
      r.length = i;
      r[] = buf[0..i].to!(dchar[])[];
      buf = buf[i+1..$];
    }
  }
  auto dummyIn = new DummyIn();

  class DummyOut
  {
    string buf;

    auto write(T)(T v) { buf ~= v.to!string; }
    auto writeln() { buf ~= "\n"; }
    auto clear() { buf = ""; }
  }
  auto dummyOut = new DummyOut();

  auto io = IO!(dummyIn, dummyOut)();

  dummyIn.buf ~= "45\n123456789012\n3.5\ntest\n";
  int a; io.getV(a);
  assert(a == 45);
  long b; io.getV(b);
  assert(b == 123456789012L);
  double c; io.getV(c);
  assert(approxEqual(c, 3.5));
  string d; io.getV(d);
  assert(d == "test");

  dummyIn.buf ~= "12 23\na 1 5.5\n";
  int e1, e2; io.getV(e1, e2);
  assert(e1 == 12 && e2 == 23);
  string f1; int f2; real f3; io.getV(f1, f2, f3);
  assert(f1 == "a" && f2 == 1 && approxEqual(f3, 5.5));

  dummyIn.buf ~= "2 5 6\n123456789012 9876543210\n";
  int[] g; io.getA(3, g);
  assert(equal(g, [2, 5, 6]));
  long[] h; io.getA(2, h);
  assert(equal(h, [123456789012L, 9876543210L]));

  dummyIn.buf ~= "1.5\n2.7\n3.3\na 12 50\nb 11 2\n";
  double[] i; io.getC(3, i);
  assert(approxEqual(i, [1.5, 2.7, 3.3]));
  string[] j1; int[] j2, j3; io.getC(2, j1, j2, j3);
  assert(equal(j1, ["a", "b"]));
  assert(equal(j2, [12, 11]));
  assert(equal(j3, [50, 2]));

  dummyIn.buf ~= "2 3\n3 4\n4 5\n";
  int[][] l; io.getM(3, 2, l);
  assert(equal(l, [[2, 3], [3, 4], [4, 5]]));

  io.put(a);
  io.put(b);
  io.put(c);
  io.put(d);
  assert(dummyOut.buf == "45\n123456789012\n3.5000000000\ntest\n");
  dummyOut.clear();

  io.put(e1, e2, f1, f2, f3);
  assert(dummyOut.buf == "12 23 a 1 5.5000000000\n");
  dummyOut.clear();

  io.put(a, g);
  assert(dummyOut.buf == "45 2 5 6\n");
  dummyOut.clear();

  io.putB(true, a, b);
  io.putB(false, c, d);
  assert(dummyOut.buf == "45\ntest\n");
}
