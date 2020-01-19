// URL: http://codeforces.com/contest/980/problem/D

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
  int[] a; readA(n, a);

  auto b = new int[](n);
  foreach (i; 0..n)
    b[i] = div(a[i]);

  int[int] z;
  foreach (i, bi; (b ~ [0]).dup.sort.uniq.enumerate) z[bi] = i.to!int;
  auto nz = z.length.to!int, zz = z[0];

  foreach (ref bi; b) bi = z[bi];

  auto r = new int[](n+1), c = new bool[](nz);
  foreach (i; 0..n) {
    c[] = false; c[b[i]] = true;
    auto e = 1;
    r[e]++;
    foreach (j; i+1..n) {
      if (c[zz]) {
        c[zz] = false;
        --e;
      }

      if (e == 0 || b[j] != zz && !c[b[j]]) {
        c[b[j]] = true;
        ++e;
      }
        
      r[e]++;
    }
  }

  writeA(n, r[1..$]);
}

auto div(int a)
{
  int[] r;
  if (a == 0) return 0;

  if (a < 0) {
    r ~= [-1];
    a = -a;
  }

  foreach (pi; 2..a.nsqrt+1) {
    if (a == 1) break;
    auto c = 0;
    while (a%pi == 0) {
      ++c;
      a /= pi;
    }
    if (c%2 == 1) r ~= pi;
  }

  if (a != 1) r ~= a;

  return r.fold!"a*b"(1);
}

pure T nsqrt(T)(T n)
{
  import std.algorithm, std.conv, std.range, core.bitop;
  if (n <= 1) return n;
  T m = T(1) << (n.bsr/2+1);
  return iota(1, m).map!"a*a".assumeSorted!"a <= b".lowerBound(n).length.to!T;
}
