// URL: https://atcoder.jp/contests/arc043/tasks/arc043_c

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

version(unittest) {} else
void main()
{
  int n; readV(n);
  int[] a; readA(n, a); --a[];
  int[] b; readA(n, b); --b[];

  auto cv = new int[](n);
  foreach (int i, ai; a) cv[ai] = i;

  foreach (ref bi; b) bi = cv[bi];

  auto ft = new FenwickTree!int(n);
  foreach (i; 0..n) ++ft[i];

  auto ib = 0L;
  foreach_reverse (bi; b) {
    ib += ft[bi+1..$];
    --ft[bi];
  }

  if (ib%2 == 1) {
    writeln(-1);
    return;
  }
  auto ic = ib/2;

  foreach (i; 0..n) ++ft[i];
  auto p = new int[](n);
  foreach (int i, bi; b) p[bi] = i;

  int[] c;
  foreach (i; 0..n) {
    if (ft[0..p[i]] <= ic) {
      c ~= i;
      ic -= ft[0..p[i]];
      --ft[p[i]];
    } else {
      break;
    }
  }

  auto e = c.length.to!int;
  b = b.filter!(bi => bi >= e).array;
  auto j = b.countUntil(e);
  foreach (i; 0..ic) swap(b[j-i], b[j-i-1]);

  c ~= b;
  foreach (ref ci; c) ci = a[ci];

  ++c[];
  writeA(n, c);
}

class FenwickTree(T)
{
  const size_t n;
  T[] buf;

  this(size_t n)
  {
    this.n = n;
    this.buf = new T[](n+1);
  }

  void opIndexOpAssign(string op)(T val, size_t i) if (op == "+" || op == "-")
  {
    ++i;
    for (; i <= n; i += i & -i) mixin("buf[i] " ~ op ~ "= val;");
  }

  void opIndexUnary(string op)(size_t i) if (op == "++" || op == "--")
  {
    ++i;
    for (; i <= n; i += i & -i) mixin("buf[i]" ~ op ~ ";");
  }

  pure T opSlice(size_t r, size_t l) { return get(l) - get(r); }
  pure T opIndex(size_t i) { return opSlice(i, i+1); }
  pure size_t opDollar() { return n; }

private:

  pure T get(size_t i)
  {
    auto s = T(0);
    for (; i > 0; i -= i & -i) s += buf[i];
    return s;
  }
}
