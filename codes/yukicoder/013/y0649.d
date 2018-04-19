// URL: https://yukicoder.me/problems/no/649

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

version(unittest) {} else
void main()
{
  int q, k; readV(q, k);

  auto rb1 = redBlackTree!("a>b", true, long)(), rb2 = redBlackTree!("a<b", true, long)();
  foreach (_; 0..q) {
    auto rd = readln.splitter;
    switch (rd.front) {
    case "1":
      rd.popFront;
      auto v = rd.front.to!long;
      if (rb1.length < k) {
        rb1.insert(v);
      } else if (rb1.front < v) {
        rb2.insert(v);
      } else {
        auto u = rb1.front; rb1.removeFront;
        rb1.insert(v);
        rb2.insert(u);
      }
      break;
    case "2":
      if (rb1.length < k) {
        writeln(-1);
      } else {
        writeln(rb1.front);
        rb1.removeFront;
        if (!rb2.empty) {
          auto u = rb2.front; rb2.removeFront;
          rb1.insert(u);
        }
      }
      break;
    default:
      assert(0);
    }
  }
}
