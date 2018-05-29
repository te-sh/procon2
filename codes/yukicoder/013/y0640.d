// URL: https://yukicoder.me/problems/no/640

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n, T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

const r = r"^\.+$";

version(unittest) {} else
void main()
{
  int n; readV(n);
  string[] s; readC(n, s);

  auto t = s.dup.transposed.map!(array).array;
  auto r1 = max(calc11(n, s), calc12(n, s), calc21(n, s), calc22(n, s), calc3(n, s));
  auto r2 = max(calc11(n, t), calc12(n, t), calc21(n, t), calc22(n, t), calc3(n, t));
  auto r3 = calc4(n, s, t);

  writeln(max(r1, r2, r3));
}

auto canPut(R)(R s)
{
  return s.all!(c => c == '.');
}

auto calc11(R)(int n, R s)
{
  if (!s[0].take(n-1).canPut) return 0;
  auto t = 1;
  foreach (i; 0..n-1)
    if (s.transversal(i).drop(1).canPut) ++t;
  if (s.transversal(n-1).take(n-1).canPut || s.transversal(n-1).drop(1).canPut) ++t;
  return t;
}

auto calc12(R)(int n, R s)
{
  if (!s[0].drop(1).canPut) return 0;
  auto t = 1;
  foreach (i; 1..n)
    if (s.transversal(i).drop(1).canPut) ++t;
  if (s.transversal(0).take(n-1).canPut || s.transversal(0).drop(1).canPut) ++t;
  return t;
}

auto calc21(R)(int n, R s)
{
  if (!s[$-1].take(n-1).canPut) return 0;
  auto t = 1;
  foreach (i; 0..n-1)
    if (s.transversal(i).take(n-1).canPut) ++t;
  if (s.transversal(n-1).take(n-1).canPut || s.transversal(n-1).drop(1).canPut) ++t;
  return t;
}

auto calc22(R)(int n, R s)
{
  if (!s[$-1].drop(1).canPut) return 0;
  auto t = 1;
  foreach (i; 1..n)
    if (s.transversal(i).take(n-1).canPut) ++t;
  if (s.transversal(0).take(n-1).canPut || s.transversal(0).drop(1).canPut) ++t;
  return t;
}

auto calc3(R)(int n, R s)
{
  auto t = 0;
  foreach (i; 0..n)
    if (s.transversal(i).take(n-1).canPut || s.transversal(i).drop(1).canPut) ++t;
  return t;
}

auto calc4(R1, R2)(int n, R1 s, R2 t)
{
  return s[0].canPut && s[$-1].canPut && t[0].canPut && t[$-1].canPut ? 4 : 0;
}
