// URL: https://yukicoder.me/problems/no/649

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
  int q, k; readV(q, k);

  auto rb1 = redBlackTree!("a>b", true, long)(), rb2 = redBlackTree!("a<b", true, long)();
  foreach (_; 0..q) {
    auto rd = rdsp;
    string typ; pick(rd, typ);
    switch (typ) {
    case "1":
      long v; pick(rd, v);
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
