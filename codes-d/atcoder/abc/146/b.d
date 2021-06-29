// URL: https://atcoder.jp/contests/abc146/tasks/abc146_b

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  string S; io.getV(S);

  dchar[] T = new dchar[](S.length);
  foreach (i, Si; S)
    T[i] = (Si-'A'+N)%26+'A';
  io.put(T);  
}

auto io = IO!()();
import lib.io;
