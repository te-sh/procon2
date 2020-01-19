// URL: https://atcoder.jp/contests/abc045/tasks/arc061_b

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
  int h, w, n; readV(h, w, n);
  int[] a, b; readC(n, a, b);
  a[] -= 1; b[] -= 1;

  auto key(int a, int b)
  {
    return (a.to!long<<32)|b;
  }

  bool[long] p, q;
  foreach (i; 0..n) p[key(a[i], b[i])] = true;

  auto ans = new int[](10);

  foreach (i; 0..n)
    foreach (r; a[i]-2..a[i]+1)
      foreach (c; b[i]-2..b[i]+1) {
        if (r < 0 || r > h-3 || c < 0 || c > w-3 || key(r, c) in q) continue;
        q[key(r, c)] = true;

        auto ci = 0;
        foreach (cr; r..r+3)
          foreach (cc; c..c+3)
            if (key(cr, cc) in p) ++ci;
        ++ans[ci];
      }

  auto ans0 = (h-2).to!long*(w-2)-ans.sum;
  writeln(ans0);
  foreach (i; 1..10) writeln(ans[i]);
}
