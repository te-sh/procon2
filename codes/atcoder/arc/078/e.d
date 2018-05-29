// URL: https://beta.atcoder.jp/contests/arc078/tasks/arc078_c

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
  auto r = -1;
  foreach (i; 1..11) {
    if (!ask(10L^^i)) {
      r = i;
      break;
    }
  }

  if (r == -1) {
    foreach (i; 1..11) {
      if (ask(10L^^i-1)) {
        writeln("! ", 10L^^(i-1));
        return;
      }
    }
  }

  auto mi = 10L^^(r-1), ma = 10L^^r-1;
  while (ma-mi > 1) {
    auto c = (ma+mi)/2;
    if (ask(c*10)) ma = c;
    else           mi = c;
  }

  writeln("! ", ask(mi*10) ? mi : ma);
}

auto ask(long n)
{
  writeln("? ", n);
  stdout.flush();
  string s; readV(s);
  return s == "Y";
}
