// URL: https://beta.atcoder.jp/contests/abc062/tasks/arc074_a

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
  long h, w; readV(h, w);

  auto m = h*w;

  foreach (i; 1..h) {
    m = min(m, sub3(div2(h-i, w, true), i*w));
    m = min(m, sub3(div2(h-i, w, false), i*w));
  }

  foreach (i; 1..w) {
    m = min(m, sub3(div2(h, w-i, true), i*h));
    m = min(m, sub3(div2(h, w-i, false), i*h));
  }

  writeln(m);
}

auto div2(long h, long w, bool hv)
{
  if (hv)
    return [(h/2)*w, (h-h/2)*w];
  else
    return [h*(w/2), h*(w-w/2)];
}

auto sub3(long[] s1, long s2)
{
  auto t = (s1 ~ s2).sort();
  return t[2] - t[0];
}
