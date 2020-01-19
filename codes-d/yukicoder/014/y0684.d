// URL: https://yukicoder.me/problems/no/684

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
  long n; readV(n);
  string s; readV(s);

  auto a = new long[](n);
  foreach (i; 0..n) a[i] = s[i] == '(' ? 1 : -1;
  foreach (i; 1..n) a[i] = a[i-1] + a[i];

  struct AM { long a, m; }
  auto am = new AM[](n), m = 0L;
  foreach (i; 0..n) {
    m = min(m, a[i]);
    am[i] = AM(a[i], m);
  }

  am.sort!((a, b) => min(a.m, a.a+b.m) > min(b.m, b.a+a.m));
  auto ami = am[0];
  foreach (i; 1..n) {
    ami.m = min(ami.m, ami.a + am[i].m);
    ami.a += am[i].a;
  }

  writeln(n*(n+1)/2 - ami.a + ami.m*2);
}
