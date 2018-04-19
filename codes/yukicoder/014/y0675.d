// URL: https://yukicoder.me/problems/no/675

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

version(unittest) {} else
void main()
{
  int n, px, py; readV(n, px, py);
  auto c = new Matrix!int[](n);
  foreach (i; 0..n) {
    auto rd = readln.splitter, ct = rd.front.to!int; rd.popFront;
    switch (ct) {
    case 1:
      c[i] = Matrix!int([[1, 0, rd.front.to!int], [0, 1, 0], [0, 0, 1]]);
      break;
    case 2:
      c[i] = Matrix!int([[1, 0, 0], [0, 1, rd.front.to!int], [0, 0, 1]]);
      break;
    case 3:
      c[i] = Matrix!int([[0, 1, 0], [-1, 0, 0], [0, 0, 1]]);
      break;
    default:
      assert(0);
    }
  }

  auto m = Matrix!int.unit(3), x = new int[](n), y = new int[](n);
  foreach_reverse (i; 0..n) {
    m = m * c[i];
    x[i] = m[0][0]*px + m[0][1]*py + m[0][2];
    y[i] = m[1][0]*px + m[1][1]*py + m[1][2];
  }

  foreach (xi, yi; lockstep(x, y))
    writeln(xi, " ", yi);
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

  this(T[][] b)
  {
    r = b.length;
    c = b[0].length;
    a = b;
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
