// URL: https://yukicoder.me/problems/no/714

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

  int[string] h;
  auto neta(string s)
  {
    if (s !in h) h[s] = h.length.to!int;
    return h[s];
  }

  auto ns = 20, nn = 53;
  auto l = new int[][](ns, nn);

  auto find(string s)
  {
    auto u = neta(s);
    foreach (i; 0..ns)
      if (l[i][u]) {
        --l[i][u];
        return i;
      }
    return -2;
  }

  foreach (_; 0..n) {
    auto rd = rdsp;
    int t; pick(rd, t);

    switch (t) {
    case 0:
      int ni, mi; pickV(rd, ni, mi); --ni;
      foreach (_2; 0..mi) {
        string a; pickV(rd, a);
        ++l[ni][neta(a)];
      }
      break;
    case 1:
      string b; pickV(rd, b);
      writeln(find(b)+1);
      break;
    case 2:
      int c; pickV(rd, c); --c;
      l[c][] = 0;
      break;
    default:
      assert(0);
    }
  }
}
