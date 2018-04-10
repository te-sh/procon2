// URL: https://beta.atcoder.jp/contests/abc092/tasks/arc093_b

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

void main()
{
  int a, b; readV(a, b);

  auto c = new bool[][](100, 100);
  foreach (i; 50..100) c[i][] = true;

  foreach (i; 0..a-1) {
    auto y = i/50*2, x = i%50*2;
    c[y][x] = true;
  }

  foreach (i; 0..b-1) {
    auto y = i/50*2+51, x = i%50*2;
    c[y][x] = false;
  }

  writeln("100 100");
  foreach (i; 0..100) {
    foreach (j; 0..100)
      write(c[i][j] ? "." : "#");
    writeln;
  }
}
