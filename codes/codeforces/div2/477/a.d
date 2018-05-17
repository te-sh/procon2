// URL: http://codeforces.com/contest/967/problem/A

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
  int n, s; readV(n, s);

  auto t = new int[](n);
  foreach (i; 0..n) {
    int h, m; readV(h, m);
    t[i] = h*60+m;
  }

  auto put(int ans)
  {
    writeln(ans/60, " ", ans%60);
  }

  if (t[0] >= s+1) {
    put(0);
    return;
  }

  foreach (i; 0..n-1) {
    if (t[i+1]-t[i] >= s*2+2) {
      put(t[i]+s+1);
      return;
    }
  }

  put(t[$-1]+s+1);
}
