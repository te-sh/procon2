// URL: https://yukicoder.me/problems/no/738

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
  int n, k; readV(n, k);
  int[] a; readA(n, a);

  int[int] z;
  auto zn = 0, b = a.dup.sort().uniq.array;
  foreach (bi; b) z[bi] = zn++;
  auto c = a.map!(ai => z[ai]).array;

  auto fc = new FenwickTree!int(zn), fs = new FenwickTree!long(zn);
  foreach (i; 0..k) {
    fc[c[i]] += 1;
    fs[c[i]] += b[c[i]];
  }

  auto ans = 10L^^18;
  foreach (i; 0..n-k+1) {
    auto s = iota(0, zn).map!(j => fc[0..j]).assumeSorted;
    if (k%2 == 0) {
      auto j1 = s.lowerBound(k/2).length-1, j2 = s.lowerBound(k/2+1).length-1;
      ans = min(ans, (fs[j2..$]-b[j2].to!long*(fc[j2..$]-k/2))-(fs[0..j1+1]-b[j1].to!long*(fc[0..j1+1]-k/2)));
    } else {
      auto j = s.lowerBound(k/2+1).length-1;
      ans = min(ans, (fs[j..$]-b[j].to!long*(fc[j..$]-k/2))-(fs[0..j+1]-b[j].to!long*(fc[0..j+1]-k/2)));
    }

    if (i < n-k) {
      fc[c[i]] -= 1;
      fs[c[i]] -= b[c[i]];
      fc[c[i+k]] += 1;
      fs[c[i+k]] += b[c[i+k]];
    }
  }

  writeln(ans);
}

class FenwickTree(T)
{
  const size_t n;
  T[] buf;

  this(size_t n)
  {
    this.n = n;
    this.buf = new T[](n+1);
  }

  void opIndexOpAssign(string op)(T val, size_t i) if (op == "+" || op == "-")
  {
    ++i;
    for (; i <= n; i += i & -i) mixin("buf[i] " ~ op ~ "= val;");
  }

  void opIndexUnary(string op)(size_t i) if (op == "++" || op == "--")
  {
    ++i;
    for (; i <= n; i += i & -i) mixin("buf[i]" ~ op ~ ";");
  }

  pure T opSlice(size_t r, size_t l) { return get(l) - get(r); }
  pure T opIndex(size_t i) { return opSlice(i, i+1); }
  pure size_t opDollar() { return n; }

private:

  pure T get(size_t i)
  {
    auto s = T(0);
    for (; i > 0; i -= i & -i) s += buf[i];
    return s;
  }
}
