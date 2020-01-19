// URL: https://yukicoder.me/problems/no/747

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
  string ns; readV(ns);
  string ks; readV(ks);

  auto n = ns.map!(c => cast(int)(c-'0')).array;
  auto k = ks.map!(c => cast(int)(c-'0')).array;

  auto nm2 = n[$-1]%2, nm3 = n.sum%3, km2 = k[$-1]%2;
  auto nm6 = [[0,4,2],[3,1,5]][nm2][nm3];
  auto nkm6 = [[0,1,4,3,4,1],[0,1,2,3,4,5]][km2][nm6];

  writeln("428571"[nkm6]);
}
