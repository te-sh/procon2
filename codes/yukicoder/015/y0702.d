// URL: https://yukicoder.me/problems/no/702

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

const n = 10000001;

version(unittest) {} else
void main()
{
  uint seed; readV(seed);

  init(seed);
  auto a = new int[](1<<16);
  foreach (_; 0..n) {
    auto r = generate();
    ++a[r>>16];
  }

  auto i = 0u, s = 0;
  for (; i < (1<<16); ++i) {
    if (s+a[i] >= (n+1)/2) break;
    s += a[i];
  }

  init(seed);
  a[] = 0;
  foreach (_; 0..n) {
    auto r = generate();
    if ((r>>16) == i)
      ++a[r&((1<<16)-1)];
  }

  foreach (j; 0..1u<<16) {
    s += a[j];
    if (s >= (n+1)/2) {
      writeln((i<<16)|j);
      return;
    }
  }
}

uint x, y, z, w;

void init(uint seed)
{
  x = seed;
  y = 1;
  z = 2;
  w = 3;
}
uint generate() {
  uint t = (x^(x<<11));
  x = y;
  y = z;
  z = w;
  w = (w^(w>>19))^(t^(t>>8)); 
  return w;
}
