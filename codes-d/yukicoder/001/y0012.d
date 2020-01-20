// URL: https://yukicoder.me/problems/no/12

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

const m = 5_000_000;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  auto t = A.map!(Ai => 1<<Ai).reduce!"a|b";
  auto p = [0] ~ Prime(m).array ~ [m+1];
  auto n = p.length, d = p.map!(pi => pi.digits).array;
  auto b = d.map!(di => (~t&di) == 0).array; b[0] = b[$-1] = false;

  auto i = 1, ml = 0;
  for (;;) {
    while (i < n && !b[i]) ++i;
    if (i == n) break;

    auto j = i, s = 0;
    while (j < n && b[j]) s |= d[j++];

    if (s == t) ml = max(ml, p[j]-p[i-1]-2);
    i = j+1;
  }

  io.putB(ml > 0, ml, -1);
}

auto digits(int x)
{
  auto r = 0;
  for (; x > 0; x /= 10) r = r.bitSet(x%10);
  return r;
}

pragma(inline)
{
  pure bool bitTest(T)(T n, size_t i) { return (n & (T(1) << i)) != 0; }
  pure T bitSet(T)(T n, size_t i) { return n | (T(1) << i); }
  pure T bitReset(T)(T n, size_t i) { return n & ~(T(1) << i); }
  pure T bitComp(T)(T n, size_t i) { return n ^ (T(1) << i); }

  import core.bitop;
  pure int bsf(T)(T n) { return core.bitop.bsf(ulong(n)); }
  pure int bsr(T)(T n) { return core.bitop.bsr(ulong(n)); }
  pure int popcnt(T)(T n) { return core.bitop.popcnt(ulong(n)); }
}

pure T isqrt(T)(T n)
{
  static if (is(T == int)) auto max = 46340;
  else static if (is(T == long)) auto max = 3037000499L;
  auto bs = iota(T(0), max).map!(x => tuple(x, x^^2)).assumeSorted!"a[1]<=b[1]";
  return bs.lowerBound(tuple(0, n)).back[0];
}

pure T icbrt(T)(T n)
{
  static if (is(T == int)) auto max = 1290;
  else static if (is(T == long)) auto max = 2097151L;
  auto bs = iota(T(0), max).map!(x => tuple(x, x^^3)).assumeSorted!"a[1]<=b[1]";
  return bs.lowerBound(tuple(0, n)).back[0];
}

pure T powr(alias pred = "a*b", T, U)(T a, U n, T one)
{
  import std.functional;
  alias predFun = binaryFun!pred;
  if (n == 0) return one;
  auto r = one;
  for (; n > 0; n >>= 1) { if (n&1) r = predFun(r, a); a = predFun(a, a); }
  return r;
}
pure T powr(alias pred = "a*b", T, U)(T a, U n) { return powr!(pred, T, U)(a, n, T(1)); }

pure T extGcd(T)(T a, T b, out T x, out T y)
{
  auto g = a; x = 1; y = 0;
  if (b) { g = extGcd(b, a%b, y, x); y -= a/b*x; }
  return g;
}

struct Prime
{
  import std.bitmanip;
  alias Factor = Tuple!(int, int);

  int n;
  int[] primes;
  @property array() { return primes; }
  alias array this;

  this(int n)
  {
    this.n = n;

    auto sieve = BitArray();
    sieve.length((n+1)/2);
    sieve = ~sieve;

    foreach (p; 1..(n.isqrt-1)/2+1)
      if (sieve[p])
        for (auto q = p*3+1; q < (n+1)/2; q += p*2+1)
          sieve[q] = false;

    primes = sieve.bitsSet.map!(p => cast(int)p*2+1).array;
    primes[0] = 2;
  }

  pure Factor[] div(int x) in { assert(x > 0 && x.isqrt <= n); } do
  {
    Factor[] factors;
    auto t = isqrt(x);
    foreach (p; primes) {
      if (p > t) break;
      auto c = 0;
      for (; x%p == 0; x /= p) ++c;
      if (c > 0) factors ~= Factor(p, c);
      if (x == 1) break;
    }
    if (x > 1) factors ~= [Factor(x, 1)];
    return factors;
  }

  pure int[] divisors(int x) in { assert(x > 0 && x.isqrt <= n); } do
  {
    auto factors = div(x);
    auto r = divisorsProc(factors, 0, 1);
    r.sort();
    return r;
  }

private:

  pure int[] divisorsProc(Factor[] factors, int i, int c)
  {
    if (i == factors.length) return [c];
    int[] r;
    foreach (j; 0..factors[i][1]+1)
      r ~= divisorsProc(factors, i+1, c*factors[i][0]^^j);
    return r;
  }
}

auto io = IO!()();

import std.stdio;
struct IO(alias IN = stdin, alias OUT = stdout, string delimiter = " ", string floatFormat = "%.10f")
{
  import std.conv, std.format, std.meta, std.traits;
  alias assignable = hasAssignableElements;

  dchar[] buf;
  auto sp = (new dchar[](0)).splitter;
  void nextLine() { IN.readln(buf); sp = buf.splitter; }

  auto get(T)(ref T v) { if (sp.empty) nextLine(); v = sp.front.to!T; sp.popFront(); }
  auto getV(T...)(ref T v) { foreach (ref w; v) get(w); }
  auto getA(T)(size_t n, ref T v) if (assignable!T) { v = new T(n); foreach (ref w; v) get(w); }
  auto getC(T...)(size_t n, ref T v) if (allSatisfy!(assignable, T))
  {
    foreach (ref w; v) w = new typeof(w)(n);
    foreach (i; 0..n) foreach (ref w; v) get(w[i]);
  }
  auto getM(T)(size_t r, size_t c, ref T v) if (assignable!T && assignable!(ElementType!T))
  {
    v = new T(r); foreach (ref w; v) getA(c, w);
  }

  auto putR(T)(T v)
  {
    auto w = v;
    while (!w.empty) { putA(w.front); w.popFront(); if (!w.empty) OUT.write(delimiter); }
  }
  auto putA(T)(T v)
  {
    static if (isInputRange!T && !isSomeString!T) putR(v);
    else if (isFloatingPoint!T) OUT.write(format(floatFormat, v));
    else OUT.write(v);
  }
  auto put(bool flush = false, T...)(T v)
  {
    foreach (i, w; v) { putA(w); if (i < v.length-1) OUT.write(delimiter); }
    OUT.writeln;
    static if (flush) OUT.flush();
  }

  auto putB(S, T)(bool c, S t, T f) { if (c) put(t); else put(f); }
  auto putRaw(T...)(T v) { OUT.write(v); OUT.writeln; }
}
