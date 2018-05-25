// URL: https://beta.atcoder.jp/contests/abc069/tasks/arc080_b

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
  int h, w; readV(h, w);
  int n; readV(n);
  int[] a; readA(n, a);

  auto b = new int[](h*w), j = 0;
  foreach (int i, ai; a) {
    b[j..j+ai][] = i+1;
    j += ai;
  }

  auto putLine(R)(R r)
  {
    foreach (i, ri; r.enumerate) {
      write(ri);
      if (i < w-1) write(" ");
    }
    writeln;
  }

  foreach (i; 0..h)
    if (i%2 == 0) putLine(b[i*w..(i+1)*w]);
    else          putLine(b[i*w..(i+1)*w].retro);
}
