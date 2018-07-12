// URL: https://yukicoder.me/problems/no/157

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
  int w, h; readV(w, h);
  string[] c; readC(h, c);

  auto b = new bool[][](h, w);
  auto findSpace()
  {
    foreach (i; 0..h)
      foreach (j; 0..w)
        if (c[i][j] == '.' && !b[i][j]) {
          auto r = [P(j, i)];
          b[i][j] = true;
          auto q = DList!P(P(j, i));
          while (!q.empty) {
            auto u = q.front; q.removeFront();
            foreach (d; [[-1,0], [1,0], [0,-1], [0,1]]) {
              auto v = P(u.x+d[0], u.y+d[1]);
              if (c[v.y][v.x] == '.' && !b[v.y][v.x]) {
                r ~= v;
                b[v.y][v.x] = true;
                q.insertBack(v);
              }
            }
          }
          return r;
        }
    assert(0);
  }

  auto s1 = findSpace(), s2 = findSpace(), r = 1000;
  foreach (p1; s1)
    foreach (p2; s2)
      r = min(r, dist(p1, p2));

  writeln(r-1);
}

struct P { int x, y; }
auto dist(P p1, P p2) { return (p1.x-p2.x).abs+(p1.y-p2.y).abs; }
