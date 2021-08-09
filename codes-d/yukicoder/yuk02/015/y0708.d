// URL: https://yukicoder.me/problems/no/708

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  string S; io.getV(S);

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
  while (i < S.length) {
    auto c = S[i++];
    if (c == '+') {
      st.insertFront(Token(Typ.Plus, 0));
    } else if (c == '-') {
      st.insertFront(Token(Typ.Minus, 0));
    } else if (c == '(') {
      st.insertFront(Token(Typ.Num, cast(int)(S[i++]-'0')));
    } else if (c == ')') {
      calc();
    } else {
      st.insertFront(Token(Typ.Num, cast(int)(c-'0')));
      calc();
    }
  }

  io.put(st.front.v);
}

enum Typ { Num, Plus, Minus }
struct Token { Typ t; int v; }

auto io = IO!()();
import lib.io;
