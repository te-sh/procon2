// URL: https://yukicoder.me/problems/no/674

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

version(unittest) {} else
void main()
{
  long d; int q; readV(d, q);

  struct P { long a, b; }
  auto inf = 2*10L^^18, m = 0L, rbt = redBlackTree!"a.a<b.a"([P(-inf, -inf), P(inf, inf)]);

  foreach (_; 0..q) {
    long a, b; readV(a, b); ++b;
    auto p = P(a, b), pr = rbt.lowerBound(p).back;
    P u;
    if (pr.b < a) {
      u = p;
    } else {
      u = P(pr.a, max(pr.b, b));
      rbt.removeKey(pr);
    }
    P[] rm;
    foreach (po; rbt.upperBound(P(a-1, b))) {
      if (po.a > u.b) break;
      rm ~= po;
      u = P(u.a, max(u.b, po.b));
    }
    foreach (rmi; rm) rbt.removeKey(rmi);
    m = max(m, u.b-u.a);
    rbt.insert(u);
    writeln(m);
  }
}