// URL: https://beta.atcoder.jp/contests/abc084/tasks/abc084_c

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

void main()
{
  int n; readV(n);
  int[] c, s, f; readM(n-1, c, s, f);

  foreach (i; 0..n-1) {
    auto t = 0;
    foreach (ci, si, fi; lockstep(c[i..$], s[i..$], f[i..$])) {
      if (t < si) t = si;
      else        t = (t+fi-1)/fi*fi;
      t += ci;
    }

    writeln(t);
  }

  writeln(0);
}
