// URL: https://yukicoder.me/problems/no/151

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
  int n, q; readV(n, q);

  auto n2 = n*2, ft = new FenwickTree!long(n2);
  foreach (t; 0..q) {
    string x; int y, z; readV(x, y, z);
    switch (x) {
    case "L":
      ft[(y+t)%n2] += z;
      break;
    case "R":
      ft[(n2-1-y+t)%n2] += z;
      break;
    case "C":
      auto r = 0L;
      auto u1 = (y+t)%n2, v1 = (z-1+t)%n2+1;
      r += u1 < v1 ? ft[u1..v1] : ft[0..v1]+ft[u1..n2];
      auto u2 = (n2-y+t-1)%n2+1, v2 = (n2-z+t)%n2;
      r += v2 < u2 ? ft[v2..u2] : ft[0..u2]+ft[v2..n2];
      writeln(r);
      break;
    default:
      assert(0);
    }
  }
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
