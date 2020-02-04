// URL: https://yukicoder.me/problems/no/188

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.datetime, core.time;

version(unittest) {} else
void main()
{
  auto r = 0;
  for (auto d = Date(2015, 1, 1); d <= Date(2015, 12, 31); d += days(1))
    if (d.month == sumDigits(d.day)) ++r;
  io.put(r);
}

auto sumDigits(int n)
{
  auto r = 0;
  for (; n > 0; n /= 10) r += n%10;
  return r;
}

auto io = IO!()();
import lib.io;
