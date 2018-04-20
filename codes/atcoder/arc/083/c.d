// URL: https://beta.atcoder.jp/contests/abc074/tasks/arc083_a

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
  int a, b, c, d, e, f; readV(a, b, c, d, e, f);

  auto nu = 0, de = a*100;
  foreach (o1; 0..f/100/a+1)
    foreach (o2; 0..(f/100-o1*a)/b+1) {
      auto w = (o1*a+o2*b)*100, s = min(f-w, w/100*e);
      foreach (o3; 0..s/c+1) {
        auto o4 = (s-o3*c)/d;
        auto t = o3*c+o4*d;

        if (nu*(w+t) < de*t) {
          nu = t;
          de = w+t;
        }
      }
    }

  writeln(de, " ", nu);
}