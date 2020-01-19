// URL: https://atcoder.jp/contests/arc050/tasks/arc050_c

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;
import std.numeric;

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
  long a, b; int m; readV(a, b, m);

  auto g = gcd(a, b);

  auto r = calc(g, 1, m);
  (r *= calc(a/g, g, m)) %= m;
  (r *= calc(b/g, g, m)) %= m;

  writeln(r);
}

long calc(long c, long d, int m)
{
  if (c == 1) return 1L;
  if (c%2 == 1)
    return (10L.repeatedSquare!((a, b) => a*b%m)((c-1)*d) + calc(c-1, d, m)) % m;
  return (10L.repeatedSquare!((a, b) => a*b%m)(c/2*d) + 1) * calc(c/2, d, m) % m;
}

pure T repeatedSquare(alias pred = "a * b", T, U)(T a, U n)
{
  return repeatedSquare!(pred, T, U)(a, n, T(1));
}

pure T repeatedSquare(alias pred = "a * b", T, U)(T a, U n, T init)
{
  import std.functional;
  alias predFun = binaryFun!pred;

  if (n == 0) return init;

  auto r = init;
  while (n > 0) {
    if (n&1) r = predFun(r, a);
    a = predFun(a, a);
    n >>= 1;
  }

  return r;
}
