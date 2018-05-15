// URL: http://codeforces.com/contest/965/problem/B

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
  int n, k; readV(n, k);
  string[] s; readC(n, s);

  auto a = new int[][](n, n);

  auto checkH(int r, int c)
  {
    foreach (i; 0..k)
      if (s[r][c+i] == '#') return false;
    return true;
  }

  auto addH(int r, int c)
  {
    foreach (i; 0..k) a[r][c+i] += 1;
  }

  auto checkV(int r, int c)
  {
    foreach (i; 0..k)
      if (s[r+i][c] == '#') return false;
    return true;
  }

  auto addV(int r, int c)
  {
    foreach (i; 0..k) a[r+i][c] += 1;
  }

  foreach (r; 0..n)
    foreach (c; 0..n) {
      if (c <= n-k && checkH(r, c)) addH(r, c);
      if (r <= n-k && checkV(r, c)) addV(r, c);
    }

  auto m = a.map!(ai => ai.maxElement).maxElement;
  foreach (r; 0..n)
    foreach (c; 0..n)
      if (a[r][c] == m) {
        writeln(r+1, " ", c+1);
        return;
      }
}
