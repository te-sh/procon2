// URL: https://yukicoder.me/problems/no/755

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
  int n, m; readV(n, m);
  long[][] a; readM(m, m, a);

  auto ac = a.map!(ai => ai.cumulativeSum).array;

  foreach (_; 0..n) {
    int x, y; readV(x, y); --x; --y;
    auto ans = 0;

    foreach (l; 0..y+1)
      foreach (r; y..m) {
        auto b = ac.map!(aci => aci[l..r+1]).array;

        auto s = [0L: 1], sd = 0L;
        foreach (d; x+1..m) {
          sd += b[d];
          ++s[-sd];
        }

        auto su = 0L;
        foreach_reverse (u; 0..x+1) {
          su += b[u];
          if (su in s) ans += s[su];
        }
      }

    writeln(ans);
  }
}

class CumulativeSum(T)
{
  size_t n;
  T[] s;

  this(T[] a)
  {
    n = a.length;
    s = new T[](n+1);
    s[0] = T(0);
    foreach (i; 0..n) s[i+1] = s[i] + a[i];
  }

  T opSlice(size_t l, size_t r) { return s[r]-s[l]; }
  size_t opDollar() { return n; }
}
auto cumulativeSum(T)(T[] a) { return new CumulativeSum!T(a); }
