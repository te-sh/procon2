// URL: https://yukicoder.me/problems/no/689

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
  int k; readV(k);

  int[] a;
  calc1(k, a);
  calc2(k, a);
  calc3(k, a);

  if (a.empty) a ~= 1;

  writeln(a.length);
  writeA(a.length, a);
}

auto calc1(ref int k, ref int[] a)
{
  if (k < 100) return;

  a ~= 2.repeat.take(k/100).array;
  a ~= 3.repeat.take(100).array;

  k %= 100;
}

auto calc2(ref int k, ref int[] a)
{
  if (k < 10) return;

  a ~= 6.repeat.take(k/10).array;
  a ~= 7.repeat.take(10).array;

  k %= 10;
}

auto calc3(ref int k, ref int[] a)
{
  if (k == 0) return;

  a ~= 18;
  a ~= 19.repeat.take(k).array;
}
