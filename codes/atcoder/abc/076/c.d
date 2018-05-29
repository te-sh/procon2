// URL: https://beta.atcoder.jp/contests/abc076/tasks/abc076_c

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
  string s; readV(s);
  string t; readV(t);

  auto ns = s.length.to!int, nt = t.length.to!int;
 loop: foreach_reverse (i; 0..ns-nt+1) {
    auto u = s.dup;
    foreach (j; 0..nt) {
      if (u[i+j] == '?') {
        u[i+j] = t[j];
      } else {
        if (u[i+j] != t[j]) continue loop;
      }
    }

    foreach (ref ui; u)
      if (ui == '?') ui = 'a';
    writeln(u);
    return;
  }

  writeln("UNRESTORABLE");
}
