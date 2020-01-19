// URL: https://yukicoder.me/problems/no/708

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
  string s; readV(s);

  auto st = SList!Token();

  auto calc()
  {
    auto t1 = st.front; st.removeFront();
    if (st.empty) {
      st.insertFront(t1);
      return;
    }
    auto t2 = st.front; st.removeFront();
    auto t3 = st.front; st.removeFront();
    st.insertFront(Token(Typ.Num, t2.t == Typ.Plus ? t3.v+t1.v : t3.v-t1.v));
  }

  auto i = 0;
  while (i < s.length) {
    auto c = s[i++];
    if (c == '+') {
      st.insertFront(Token(Typ.Plus, 0));
    } else if (c == '-') {
      st.insertFront(Token(Typ.Minus, 0));
    } else if (c == '(') {
      st.insertFront(Token(Typ.Num, cast(int)(s[i++]-'0')));
    } else if (c == ')') {
      calc();
    } else {
      st.insertFront(Token(Typ.Num, cast(int)(c-'0')));
      calc();
    }
  }

  writeln(st.front.v);
}

enum Typ { Num, Plus, Minus }

struct Token
{
  Typ t;
  int v;
}
