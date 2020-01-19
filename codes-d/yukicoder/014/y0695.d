// URL: https://yukicoder.me/problems/no/695

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;
import std.bigint;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n,T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

const mod1 = 168647939L, mod2 = 592951213L, mod = mod1*mod2;

version(unittest) {} else
void main()
{
  int n, m; readV(n, m);
  int[] x; readA(m, x);

  auto n2 = (n+1)/2, c = new uint[](n2);
  auto calc(int mod)
  {
    c[] = 0; c[0] = 1;
    foreach (i; 1..n2)
      foreach (j; 0..m)
        if (i >= x[j]) (c[i] += c[i-x[j]]) %= mod;

    auto r = 0uL;
    foreach (j; 0..m)
      foreach (i; max(0, n2-x[j])..min(n-x[j], n2))
        (r += c[i].to!ulong*c[n-1-(i+x[j])].to!ulong) %= mod;

    return r.to!long;
  }

  auto r1 = BigInt(calc(mod1)), r2 = BigInt(calc(mod2));
  long a, b; exEuclid(mod1, mod2, a, b);
  writeln(((r1*b*mod2+r2*a*mod1)%mod+mod)%mod);
}

pure T exEuclid(T)(T a, T b, ref T x, ref T y)
{
  auto g = a;
  x = 1;
  y = 0;
  if (b) {
    g = exEuclid(b, a%b, y, x);
    y -= a/b*x;
  }
  return g;
}
