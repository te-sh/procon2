// URL: https://yukicoder.me/problems/no/155

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
  int n, l; readV(n, l);
  string[] st; readA(n, st);

  l *= 60;
  auto s = st.map!(sti => sti[0..2].to!int*60+sti[3..5].to!int).array;

  if (s.sum < l) {
    writeln(n);
    return;
  }

  auto dp1 = new long[][][](n+1, n+1, l); dp1[0][0][0] = 1;
  foreach (i; 0..n)
    foreach (j; 0..n+1)
      foreach (k; 0..l) {
        dp1[i+1][j][k] = dp1[i][j][k];
        if (j >= 1 && k >= s[i])
          dp1[i+1][j][k] += dp1[i][j-1][k-s[i]];
      }

  auto fact = new real[](n+1); fact[0] = 1;
  foreach (i; 1..n+1) fact[i] = fact[i-1]*i;

  auto r = 0.0L, dp2 = new long[][](n+1, l);
  foreach (i; 0..n) {
    foreach (j; 0..n+1)
      foreach (k; 0..l) {
        dp2[j][k] = dp1[n][j][k];
        if (j >= 1 && k >= s[i])
          dp2[j][k] -= dp2[j-1][k-s[i]];
      }

    foreach (j; 0..n)
      foreach (k; max(0, l-s[i])..l)
        r += dp2[j][k]*fact[j+1]*fact[n-1-j];
  }

  writefln("%.10f", r/fact[n]);
}
