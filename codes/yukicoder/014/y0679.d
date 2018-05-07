// URL: https://yukicoder.me/problems/no/679

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

version(unittest) {} else
void main()
{
  int n, m; readV(n, m);

  auto h = new BitArray[](n);
  foreach (i; 0..n) {
    h[i] = BitArray();
    h[i].length = n;
  }

  foreach (_; 0..m) {
    int g, r; readV(g, r);
    int[] k; readA(r, k);
    foreach (ki; k) h[g-1][ki-1] = true;
  }

  auto c = BitArray();
  c.length = n;

 loop: for (;;) {
    foreach (i; 0..n) {
      if (c[i]) continue;
      if ((h[i] & c) == h[i]) {
        c[i] = true;
        continue loop;
      }
    }
    break;
  }

  auto ans = 0;
  foreach (i; 0..n) ans += c[i];
  writeln(ans);
}
