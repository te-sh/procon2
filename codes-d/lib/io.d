module lib.io;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.io
import std.stdio;
/**
 ** 競技プログラミング用の読み書きを行います.
 ** floatFormat は浮動小数点出力時のフォーマットです.
 ** delimiter は出力時の区切り文字です.
 ** IN, OUT は入力ソースおよび出力ソースです.
 **/
struct IO(string floatFormat = "%.10f", string delimiter = " ", alias IN = stdin, alias OUT = stdout)
{
  import std.conv, std.format, std.meta, std.traits;

  /**
   ** v に入力からの値をセットします.
   ** v は複数指定できます.
   **/
  auto getV(T...)(ref T v) { foreach (ref w; v) get(w); }
  /**
   ** v を n 要素の配列にして入力からの値をセットします.
   ** 入力値が1行で与えられる場合に使います.
   **/
  auto getA(T)(size_t n, ref T v) if (hasAssignableElements!T)
  { v = new T(n); foreach (ref w; v) get(w); }
  /**
   ** v を n 要素の配列にして入力からの値をセットします.
   ** v は複数指定できます.
   ** 入力値が複数行で与えられる場合に使います.
   **/
  auto getC(T...)(size_t n, ref T v)
  if (allSatisfy!(hasAssignableElements, T))
  {
    foreach (ref w; v) w = new typeof(w)(n);
    foreach (i; 0..n) foreach (ref w; v) get(w[i]);
  }
  /**
   ** v を r 行 c 列の配列にして入力からの値をセットします.
   **/
  auto getM(T)(size_t r, size_t c, ref T v)
  if (hasAssignableElements!T && hasAssignableElements!(ElementType!T))
  {
    v = new T(r); foreach (ref w; v) getA(c, w);
  }
  /**
   ** v を n 要素の配列にして入力からの値をセットします.
   ** E に v のフィールド名を指定します.
   **/
  template getS(E...)
  {
    auto getS(T)(size_t n, ref T v)
    {
      v = new T(n); foreach (ref w; v) foreach (e; E) mixin("get(w."~e~");");
    }
  }

  /**
   ** v の値を delimiter 区切りで1行に出力します. 最後は改行します.
   ** v は複数指定できます.
   ** flush が true ならば出力後に flush します.
   **/
  auto put(bool flush = false, T...)(T v)
  {
    foreach (i, w; v) { putA(w); if (i < v.length-1) OUT.write(delimiter); }
    OUT.writeln;
    static if (flush) OUT.flush();
  }
  /**
   ** c が true ならば t を, そうでなければ f を出力します. 最後は改行します.
   **/
  auto putB(S, T)(bool c, S t, T f) { if (c) put(t); else put(f); }
  /**
   ** v をそのまま OUT.write に渡します. 最後は改行します.
   ** v は複数指定できます.
   **/
  auto putRaw(T...)(T v) { OUT.write(v); OUT.writeln; }

  private
  {
    dchar[] buf;
    auto sp = (new dchar[](0)).splitter;
    void nextLine() { IN.readln(buf); sp = buf.splitter; }
    auto get(T)(ref T v) { if (sp.empty) nextLine(); v = sp.front.to!T; sp.popFront(); }

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
  }
}
// ::::::::::::::::::::

unittest
{
  import std.conv;

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
    auto flush() { buf ~= "F"; }
    auto clear() { buf = ""; }
  }
  auto dummyOut = new DummyOut();

  auto io = IO!("%.10f", " ", dummyIn, dummyOut)();

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

  struct S { string s; int i, j; }
  dummyIn.buf ~= "a 3\nb 4\n";
  S[] m; io.getS!("s", "i")(2, m);
  assert(equal(m, [S("a", 3, 0), S("b", 4, 0)]));

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

  io.put!true(a);
  assert(dummyOut.buf == "45\nF");
  dummyOut.clear();

  io.putB(true, a, b);
  io.putB(false, c, d);
  assert(dummyOut.buf == "45\ntest\n");
}
