// URL: https://yukicoder.me/problems/no/197

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  string Sb; io.getV(Sb); auto sb = Sb.map!"a=='o'".array;
  int N; io.getV(N);
  string Sa; io.getV(Sa); auto sa = Sa.map!"a=='o'".array;

  if (sb.count!"a" != sa.count!"a") io.put!"{exit: true}"("SUCCESS");

  if (sb.count!"a" >= 2) {
    sb[] = sb.map!"!a".array;
    sa[] = sa.map!"!a".array;
  }

  if (sb.count!"a" == 0) io.put!"{exit: true}"("FAILURE");

  if (N == 0) {
    io.putB(sb.countUntil!"a" != sa.countUntil!"a", "SUCCESS", "FAILURE");
  } else if (N == 1) {
    if (sb[0]) io.putB(sa[2], "SUCCESS", "FAILURE");
    else if (sb[1]) io.putB(sa[1], "SUCCESS", "FAILURE");
    else if (sb[2]) io.putB(sa[0], "SUCCESS", "FAILURE");
  } else {
    io.put("FAILURE");
  }
}

auto io = IO!()();
import lib.io;
