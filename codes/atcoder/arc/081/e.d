// URL: https://beta.atcoder.jp/contests/arc081/tasks/arc081_c

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

version(unittest) {} else
void main()
{
  string a; readV(a);

  auto p = new int[][](26);
  foreach (int i, ai; a) p[ai-'a'] ~= i;

  int[] s;
  auto c = 0, b = new bool[](26);
  foreach_reverse (i, ai; a) {
    if (!b[ai-'a']) {
      b[ai-'a'] = true;
      ++c;

      if (c == 26) {
        s ~= i.to!int;
        c = 0;
        b[] = false;
      }
    }
  }
  s.reverse();
  auto k = s.length.to!int;

  char[] r;
  auto j = -1;
  foreach (i; 0..k) {
    foreach (d; 0..26) {
      auto di = p[d].assumeSorted.upperBound(j).front;
      if (di >= s[i]) {
        r ~= cast(char)('a'+d);
        j = di;
        break;
      }
    }
  }

  foreach (d; 0..26) {
    auto di = p[d].assumeSorted.upperBound(j);
    if (di.empty) {
      r ~= cast(char)('a'+d);
      break;
    }
  }

  writeln(r);
}
