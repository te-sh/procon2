// URL: https://beta.atcoder.jp/contests/abc055/tasks/arc069_b

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
  string s; readV(s);

  auto t = s.map!(si => si == 'o').array;

  auto calc(bool[] a)
  {
    foreach (i; 1..n-1) a[i+1] = a[i-1]^a[i]^t[i];
    if (a[0] == (a[$-2]^a[$-1]^t[$-1]) && a[1] == (a[$-1]^a[0]^t[0]))
      return true;
    else
      return false;
  }

  auto a = new bool[](n);
  foreach (i0; 0..2)
    foreach (i1; 0..2) {
      a[0] = i0 == 1;
      a[1] = i1 == 1;
      if (calc(a)) {
        foreach (i; 0..n)
          write(a[i] ? "S" : "W");
        writeln;
        return;
      }
    }

  writeln(-1);
}
