// URL: https://yukicoder.me/problems/no/631

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
  int[] t; readA(n-1, t);

  auto s = new SegmentTreeLazy!long(n);
  foreach (i; 0..n-1) s[i..i+1] = t[i]-i*3;

  int m; readV(m);
  foreach (_; 0..m) {
    int l, r, d; readV(l, r, d); --l;
    s[l..r] += d;
    writeln(s[0..$] + (n-1)*3);
  }
}

class SegmentTreeLazy(T, alias pred = max)
{
  import core.bitop, std.conv, std.functional, std.range;
  alias predFun = binaryFun!pred;
  enum Op { none, fill, add };

  const size_t n, an;
  T[] buf, laz;
  Op[] op;
  T unit;

  this(size_t n, T unit = T.init)
  {
    this.n = n;
    this.unit = unit;
    an = (1 << ((n-1).bsr + 1));
    buf = new T[](an * 2);
    laz = new T[](an * 2);
    op = new Op[](an * 2);
    if (T.init != unit) buf[] = unit;
  }

  void propagate(size_t k, size_t nl, size_t nr)
  {
    if (op[k] == Op.none) return;

    size_t nm = (nl+nr)/2;
    setLazy(op[k], laz[k], k*2,   nl, nm);
    setLazy(op[k], laz[k], k*2+1, nm, nr);

    op[k] = Op.none;
  }

  void setLazy(Op nop, T val, size_t k, size_t nl, size_t nr)
  {
    switch (nop) {
    case Op.fill:
      buf[k] = val;
      laz[k] = val;
      op[k] = nop;
      break;
    case Op.add:
      buf[k] += val;
      laz[k] = op[k] == Op.none ? val : laz[k] + val;
      op[k] = op[k] == Op.fill ? Op.fill : Op.add;
      break;
    default:
      assert(0);
    }
  }

  void addOpe(Op op, T val, size_t l, size_t r, size_t k, size_t nl, size_t nr)
  {
    if (nr <= l || r <= nl) return;

    if (l <= nl && nr <= r) {
      setLazy(op, val, k, nl, nr);
      return;
    }

    propagate(k, nl, nr);

    auto nm = (nl+nr)/2;
    addOpe(op, val, l, r, k*2,   nl, nm);
    addOpe(op, val, l, r, k*2+1, nm, nr);

    buf[k] = predFun(buf[k*2], buf[k*2+1]);
  }

  void opSliceAssign(T val, size_t l, size_t r)
  {
    addOpe(Op.fill, val, l, r, 1, 0, an);
  }

  void opSliceOpAssign(string op: "+")(T val, size_t l, size_t r)
  {
    addOpe(Op.add, val, l, r, 1, 0, an);
  }

  T summary(size_t l, size_t r, size_t k, size_t nl, size_t nr)
  {
    if (nr <= l || r <= nl) return unit;

    if (l <= nl && nr <= r) return buf[k];

    propagate(k, nl, nr);

    auto nm = (nl+nr)/2;
    auto vl = summary(l, r, k*2,   nl, nm);
    auto vr = summary(l, r, k*2+1, nm, nr);

    return predFun(vl, vr);
  }

  T opSlice(size_t l, size_t r)
  {
    return summary(l, r, 1, 0, an);
  }

  pure size_t opDollar() const { return n; }
}
