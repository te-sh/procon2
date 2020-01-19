// URL: https://yukicoder.me/problems/no/764

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
  real[] l; readC(n+2, l);

  auto l0 = l[0], lc = l.cumulativeSum;
  auto ll = new real[](n+2), lr = new real[](n+2);
  ll[1] = l[1];
  foreach (i; 2..n+2) ll[i] = max(ll[i-1], l[i]);
  lr[n+1] = l[n+1];
  foreach_reverse (i; 1..n+1) lr[i] = max(lr[i+1], l[i]);

  auto integral(real a, real x)
  {
    if ((a-x).abs < 1e-11) return a^^2*PI/2;
    return x*sqrt(a^^2-x^^2) + a^^2*asin(x/a);
  }

  auto calc(real r1, real r2)
  {
    if (r1+r2 < l0) {
      return 0.0;
    } else if (r1+l0 < r2) {
      return PI*r1^^2;
    } else if (r2+l0 < r1) {
      return PI*r2^^2;
    } else {
      auto x = (l0^^2+r1^^2-r2^^2)/(l0*2);
      return integral(r2, x-l0)-integral(r2, -r2)+integral(r1, r1)-integral(r1, x);
    }
  }

  writeln(0);
  foreach (i; 2..n) {
    auto a = lc[1..i+1], b = max(2*ll[i]-a, 0);
    auto c = lc[i+1..$], d = max(2*lr[i+1]-c, 0);

    auto s = calc(a, c)-calc(a, d)-calc(b, c)+calc(b, d);
    writefln("%.7f", s);
  }
  writeln(0);
}

class CumulativeSum(T)
{
  size_t n;
  T[] s;

  this(T[] a)
  {
    n = a.length;
    s = new T[](n+1);
    s[0] = T(0);
    foreach (i; 0..n) s[i+1] = s[i] + a[i];
  }

  T opSlice(size_t l, size_t r) { return s[r]-s[l]; }
  size_t opDollar() { return n; }
}
auto cumulativeSum(T)(T[] a) { return new CumulativeSum!T(a); }
