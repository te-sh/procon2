module lib.math.integrate;
import std;

// :::::::::::::::::::: lib.math.integrate
/**
 ** 関数 f の lo から hi までの積分値を返します.
 ** 計算には Gauss-Robatto 求積法を使用します.
 **/
T integrate(T)(T delegate(T) f, T lo, T hi, T eps = 1e-8)
{
  const auto th = eps / 1e-14;

  T rec(T x0, T x6, T y0, T y6, int d)
  {
    const auto a = sqrt(2.0/3.0), b = 1.0 / sqrt(5.0);
    auto x3 = (x0+x6)/2, y3 = f(x3), h = (x6-x0)/2;
    auto x1 = x3-a*h, x2 = x3-b*h, x4 = x3+b*h, x5 = x3+a*h;
    auto y1 = f(x1), y2 = f(x2), y4 = f(x4), y5 = f(x5);
    auto i1 = (y0 + y6 + (y2 + y4) * 5) * (h/6);
    auto i2 = ((y0 + y6) * 77 + (y1 + y5) * 432 + (y2 + y4) * 625 + y3 * 672) * (h/1470);
    if (x3 + h == x3 || d > 50) return 0.0;
    if (d > 4 && th + (i1 - i2) == th) return i2;
    return rec(x0, x1, y0, y1, d+1) + rec(x1, x2, y1, y2, d+1) +
           rec(x2, x3, y2, y3, d+1) + rec(x3, x4, y3, y4, d+1) +
           rec(x4, x5, y4, y5, d+1) + rec(x5, x6, y5, y6, d+1);
  }

  return rec(lo, hi, f(lo), f(hi), 0);
}

/**
 ** 関数 f の lo から hi までの積分値を返します.
 ** 計算には二重指数関数型数値積分公式を使用します.
 **/
T integrateDE(T)(T delegate(T) f, T a, T b, T eps = 1e-8)
{
  const auto c = asin(1.0), tm = 10.0;

  T delegate(T) x, g;
  if (!a.isInfinity && !b.isInfinity) {
    x = (T t) => (b+a)/2 + (b-a)/2*tanh(c*sinh(t));
    g = (T t) => c*(b-a)/2*cosh(t)/cosh(c*sinh(t))^^2;
  } else if (!a.isInfinity) {
    x = (T t) => a + exp(c*sinh(t));
    g = (T t) => c*cosh(t)*exp(c*sinh(t));
  } else if (!b.isInfinity) {
    x = (T t) => b - exp(c*sinh(-t));
    g = (T t) => c*cosh(t)*exp(c*sinh(-t));
  } else {
    x = (T t) => sinh(c*sinh(t));
    g = (T t) => c*cosh(t)*cosh(c*sinh(t));
  }

  auto s = 0.0, h = 1.0/c;
  for (;;) {
    auto i = 0.0;
    for (auto t = 0.0; t < tm; t = t > 0 ? -t : -t+h) {
      auto di = f(x(t)) * g(t) * h;
      if (!di.isNaN) i += di;
    }
    if (abs(i-s) < abs(i)*eps) return i;
    s = i;
    h /= 2;
  }
}
// ::::::::::::::::::::

unittest
{
  assert(approxEqual(integrate!double((x) => 2*x^^3 - x^^2 + 4, -2, 2), 32.0/3.0, 1e-11));
  assert(approxEqual(integrate!double((x) => (1 - x^^2).sqrt, -1, 1), PI/2, 1e-11));
  assert(approxEqual(integrateDE!double((x) => 2*x^^3 - x^^2 + 4, -2, 2), 32.0/3.0, 1e-11));
  assert(approxEqual(integrateDE!double((x) => (1 - x^^2).sqrt, -1, 1), PI/2, 1e-11));
}
