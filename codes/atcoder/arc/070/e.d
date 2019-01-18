// URL: https://atcoder.jp/contests/arc070/tasks/arc070_c

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
  long[] l, r; readC(n, l, r);

  auto w = new long[](n);
  foreach (i; 0..n) w[i] = r[i]-l[i];

  auto on = 0L, op = 0L, ans = 0L;
  auto hn = heapify!"a<b"(Array!long(l[0]));
  auto hp = heapify!"a>b"(Array!long(l[0]));

  foreach (i; 1..n) {
    on -= w[i];
    op += w[i-1];

    if (l[i] < hn.front+on) {
      ans += (hn.front+on)-l[i];
      hn.insert(l[i]-on);
      hn.insert(l[i]-on);
      hp.insert(hn.front+on-op);
      hn.removeFront();
    } else if (l[i] > hp.front+op) {
      ans += l[i]-(hp.front+op);
      hp.insert(l[i]-op);
      hp.insert(l[i]-op);
      hn.insert(hp.front+op-on);
      hp.removeFront();
    } else {
      hn.insert(l[i]-on);
      hp.insert(l[i]-op);
    }
  }

  writeln(ans);
}
