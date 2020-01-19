// URL: https://atcoder.jp/contests/abc127/tasks/abc127_f

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
  int q; readV(q);

  auto a1 = Array!int().heapify!"a<b", s1 = 0L;
  auto a2 = Array!int().heapify!"a>b", s2 = 0L;
  auto bs = 0L, u = 0, c = 0;

  foreach (_; 0..q) {
    auto rd = rdsp;
    int typ; pick(rd, typ);
    switch (typ) {
    case 1:
      int a, b; pickV(rd, a, b);
      bs += b;

      if (u%2 == 0) {
        if (a1.empty || a2.empty) {
          c = a;
        } else if (a1.front > a) {
          a1.insert(a); s1 += a;
          c = a1.front; a1.removeFront(); s1 -= c;
        } else if (a2.front < a) {
          a2.insert(a); s2 += a;
          c = a2.front; a2.removeFront(); s2 -= c;
        } else {
          c = a;
        }
      } else {
        a1.insert(c); s1 += c;
        a1.insert(a); s1 += a;
        auto t = a1.front; a1.removeFront(); s1 -= t;
        a2.insert(t); s2 += t;
      }

      ++u;
      break;
    case 2:
      if (u%2 == 0)
        writeln(a1.front, " ", s2-s1+bs);
      else
        writeln(c, " ", s2-s1+bs);
      break;
    default:
      assert(0);
    }
  }
}
