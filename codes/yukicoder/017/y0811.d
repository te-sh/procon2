// URL: https://yukicoder.me/problems/no/811

import std.algorithm, std.container, std.math, std.range, std.typecons, std.string;
import std.bitmanip;

version(unittest) {} else
void main()
{
  int n, k; io.getV(n, k);

  auto p = Prime(1000);

  auto nd = p.div(n);
  size_t[int] ndh;
  foreach (ndi; nd) ndh[ndi[0]] = ndi[1];

  auto rd = size_t(0), rn = 0;

  foreach (i; 2..n) {
    auto d = p.div(i);

    auto it = 0;
    foreach (di; d) {
      if (di[0] in ndh) {
        it += min(di[1], ndh[di[0]]);
      }
    }

    if (it < k) continue;

    auto td = d.map!"a[1]+1".reduce!"a*b";
    if (td > rd) {
      rd = td;
      rn = i;
    }
  }

  io.put(rn);
}

struct Prime
{
  import std.algorithm, std.bitmanip, std.math, std.range, std.typecons;
  alias Factor = Tuple!(int, size_t);

  int n;
  int[] primes;
  alias primes this;

  this(int n)
  {
    this.n = n;

    auto sieve = BitArray();
    sieve.length((n+1)/2);
    sieve = ~sieve;

    foreach (p; 1..((nsqrt(n)-1)/2+1))
      if (sieve[p])
        for (auto q = p*3+1; q < (n+1)/2; q += p*2+1)
          sieve[q] = false;

    primes = sieve.bitsSet.map!(p => cast(int)p*2+1).array;
    primes[0] = 2;
  }

  pure auto div(int x)
  in { assert(x > 0 && nsqrt(x) <= n); }
  body {
    Factor[] factors;
    auto t = nsqrt(x);
    foreach (p; primes) {
      if (p > t) {
        factors ~= Factor(x, 1);
        break;
      }
      auto c = size_t(0);
      for (; x%p == 0; x /= p) ++c;
      if (c > 0) factors ~= Factor(p, c);
      if (x == 1) break;
    }
    return factors;
  }

  pure auto divisors(int x)
  in { assert(x > 0 && nsqrt(x) <= n); }
  body {
    auto factors = div(x);
    auto r = divisorsProc(factors, 0, 1);
    r.sort();
    return r;
  }

  pure int[] divisorsProc(Factor[] factors, size_t i, int c)
  {
    if (i == factors.length) return [c];
    int[] r;
    foreach (j; 0..factors[i][1]+1)
      r ~= divisorsProc(factors, i+1, c*factors[i][0]^^cast(int)j);
    return r;
  }

  pure auto nsqrt(int n)
  {
    if (n <= 1) return n;
    auto m = 1<<(n.ilogb/2+1);
    return cast(int)iota(1, m).map!"a*a".assumeSorted!"a <= b".lowerBound(n).length;
  }
}

auto io = IO();

struct IO
{
  import std.algorithm, std.conv, std.format, std.meta, std.range, std.stdio, std.traits;

  dchar[] buf;
  auto sp = (new dchar[](0)).splitter;
  int precision = 10;
  string delimiter = " ";

  void nextLine()
  {
    stdin.readln(buf);
    sp = buf.splitter;
  }

  auto get(T)(ref T v)
  {
    if (sp.empty) nextLine();
    v = sp.front.to!T;
    sp.popFront();
  }

  auto getV(T...)(ref T v)
  {
    foreach (ref w; v) get(w);
  }

  auto getA(T)(size_t n, ref T v)
  if (hasAssignableElements!T)
  {
    v = new T(n);
    foreach (ref w; v) get(w);
  }

  auto getC(T...)(size_t n, ref T v)
  if (allSatisfy!(hasAssignableElements, T))
  {
    foreach (ref w; v)
      w = new typeof(w)(n);
    foreach (i; 0..n)
      foreach (ref w; v) get(w[i]);
  }

  auto getM(T)(size_t r, size_t c, ref T v)
  if (hasAssignableElements!T && hasAssignableElements!(ElementType!T))
  {
    v = new T(r);
    foreach (ref w; v) getA(c, w);
  }

  auto rangePop(R)(ref R r)
  {
    r.popFront();
    if (!r.empty) write(delimiter);
  }

  auto putA(T)(T v)
  {
    static if (isInputRange!T && !isSomeString!T)
      for (auto w = v; !w.empty; rangePop(w)) putA(w.front);
    else if (isFloatingPoint!T)
      writef(format("%%.%df", precision), v);
    else
      write(v);
  }

  auto put(T...)(T v)
  {
    foreach (i, w; v) {
      putA(w);
      if (i < v.length-1) write(delimiter);
    }
    writeln;
  }

  auto putB(S, T)(bool c, S t, T f)
  {
    if (c)
      put(t);
    else
      put(f);
  }

  auto dbg(T...)(T v)
  {
    stderr.writeln(v);
  }
}
