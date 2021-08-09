// URL: https://yukicoder.me/problems/no/702

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

const n = 10000001;

version(unittest) {} else
void main()
{
  uint seed; io.getV(seed);

  init(seed);
  auto a = new int[](1<<16);
  foreach (_; 0..n) {
    auto r = generate();
    ++a[r>>16];
  }

  auto i = 0u, s = 0;
  for (; i < (1<<16); ++i) {
    if (s+a[i] >= (n+1)/2) break;
    s += a[i];
  }

  init(seed);
  a[] = 0;
  foreach (_; 0..n) {
    auto r = generate();
    if ((r>>16) == i)
      ++a[r&((1<<16)-1)];
  }

  foreach (j; 0..1u<<16) {
    s += a[j];
    if (s >= (n+1)/2) { io.put((i<<16)|j); return; }
  }
}

uint x, y, z, w;

void init(uint seed)
{
  x = seed;
  y = 1;
  z = 2;
  w = 3;
}
uint generate() {
  uint t = (x^(x<<11));
  x = y;
  y = z;
  z = w;
  w = (w^(w>>19))^(t^(t>>8)); 
  return w;
}

auto io = IO!()();
import lib.io;
