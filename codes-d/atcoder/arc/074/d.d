// URL: https://atcoder.jp/contests/abc062/tasks/arc074_b

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
  long[] a; readA(n*3, a);

  auto t1 = new long[](n+1);
  t1[0] = a[0..n].sum;
  auto rb1 = heapify!"a>b"(a[0..n]);
  foreach (i; 1..n+1) {
    auto ai = a[n+i-1];
    if (rb1.front >= ai) {
      t1[i] = t1[i-1];
    } else {
      t1[i] = t1[i-1] - rb1.front + ai;
      rb1.replaceFront(ai);
    }
  }

  auto t2 = new long[](n+1);
  t2[n] = a[n*2..n*3].sum;
  auto rb2 = heapify!"a<b"(a[n*2..n*3]);
  foreach_reverse (i; 0..n) {
    auto ai = a[n+i];
    if (rb2.front <= ai) {
      t2[i] = t2[i+1];
    } else {
      t2[i] = t2[i+1] - rb2.front + ai;
      rb2.replaceFront(ai);
    }
  }

  t1[] -= t2[];
  writeln(t1.reduce!max);
}
