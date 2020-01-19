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

unittest
{
  auto ft = new FenwickTree!int(15);

  assert(ft[0..2] == 0);
  assert(ft[0..3] == 0);
  assert(ft[0..6] == 0);
  assert(ft[5..$] == 0);

  ft[1] += 2;

  assert(ft[1] == 2);
  assert(ft[0..2] == 2);
  assert(ft[0..3] == 2);
  assert(ft[0..6] == 2);
  assert(ft[5..$] == 0);

  ft[2] += 3;
  ft[5] += 4;
  ft[10] -= 5;

  assert(ft[0..2] == 2);
  assert(ft[0..3] == 5);
  assert(ft[0..6] == 9);
  assert(ft[5..$] == -1);

  ++ft[10];

  assert(ft[5..$] == 0);
}
