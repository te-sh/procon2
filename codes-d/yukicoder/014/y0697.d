// URL: https://yukicoder.me/problems/no/697

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;
import std.bitmanip;

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
  int h, w; readV(h, w);
  auto n = (h+2)*(w+2);

  auto b = BitArray();
  b.length = n;

  foreach (r; 0..h) {
    int[] a; readA(w, a);
    foreach (c; 0..w)
      if (a[c]) b[(r+1)*(w+2)+c+1] = true;
  }

  auto v = BitArray();
  v.length = n;

  auto p = 0;
  foreach (i; 0..n) {
    if (b[i] && !v[i]) {
      ++p;
      auto q = DList!int(i);
      v[i] = true;
      while (!q.empty) {
        auto d = q.front; q.removeFront();
        foreach (e; [d-1, d+1, d-(w+2), d+(w+2)]) {
          if (b[e] && !v[e]) {
            v[e] = true;
            q.insertBack(e);
          }
        }
      }
    }
  }

  writeln(p);
}
