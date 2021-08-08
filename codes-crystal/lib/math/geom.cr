# :::::::::::::::::::: lib/math/geom
require "lib/ext/float"

#
# 平面幾何に関するライブラリです
#
module Geom
  extend self

  #
  # 点を表します
  #
  record Point, x : Float64, y : Float64

  #
  # 直線を表します
  #
  record Line, a : Float64, b : Float64, c : Float64

  #
  # 円を表します
  #
  record Circle, x : Float64, y : Float64, r : Float64 do
    def initialize(p : Point, @r : Float64)
      @x = p.x
      @y = p.y
    end
  end

  #
  # 点 p1, p2 を通る直線を返します.
  #
  def line(p1 : Point, p2 : Point)
    x = p2.x - p1.x
    y = p2.y - p1.x
    Line.new(y, -x, p2.y * x - p2.x * y)
  end

  #
  # 点 p1, p2 の距離を返します
  #
  def dist(p1 : Point, p2 : Point)
    Math.sqrt((p1.x - p2.x) ** 2 + (p1.y - p2.y) ** 2)
  end

  #
  # 点 p と直線 l の距離を返します
  #
  def dist(p : Point, l : Line)
    (l.a * p.x + l.b * p.y + l.c).abs / Math.sqrt(l.a ** 2 + l.b ** 2)
  end

  #
  # 直線 l1 と 直線 l2 の交点を返します
  # l1 と l2 が平行の場合は nil を返します
  #
  def intersect(l1 : Line, l2 : Line)
    det = l1.a * l2.b - l1.b * l2.a
    return nil if det.near?(0)
    x = (l1.b * l2.c - l2.b * l1.c) / det
    y = (l2.a * l1.c - l1.a * l2.c) / det
    Point.new(x, y)
  end

  #
  # 円 c と直線 l の交点を 2 つ返します
  # c と l が接している場合は同じ点を 2 つ返します
  # c と l が交点を持たない場合は nil を返します
  #
  def intersect(c : Circle, l : Line)
    d = l.a * c.x + l.b * c.y + l.c
    e = l.a ** 2 + l.b ** 2
    f = e * c.r ** 2 - d ** 2
    return nil if f < 0
    fr = Math.sqrt(f)
    x1 = (-l.a * d + l.b * fr) / e + c.x
    y1 = (-l.b * d - l.a * fr) / e + c.y
    x2 = (-l.a * d - l.b * fr) / e + c.x
    y2 = (-l.b * d + l.a * fr) / e + c.y
    {Point.new(x1, y1), Point.new(x2, y2)}
  end

  #
  # 円 c1 と円 c2 の交点を 2 つ返します
  # c1 と c2 が接している場合は同じ点を 2 つ返します
  # c1 と c2 が交点を持たない場合は nil を返します
  #
  def intersect(c1 : Circle, c2 : Circle)
    d = dist(Point.new(c1.x, c1.y), Point.new(c2.x, c2.y))
    a = c1.x * 2 - c2.x * 2
    b = c1.y * 2 - c2.y * 2
    c = c2.x ** 2 + c2.y ** 2 - c2.r ** 2 - c1.x ** 2 - c1.y ** 2 + c1.r ** 2
    intersect(c1, Line.new(a, b, c))
  end

  #
  # 点 p1, p2 の垂直二等分線を返します
  # p1, p2 が同一点の場合は nil を返します
  #
  def bisector(p1 : Point, p2 : Point)
    return nil if p1.x.near?(p2.x) && p1.y.near?(p2.y)
    a = p2.x - p1.x
    b = p2.y - p1.y
    c = (p1.x ** 2 - p2.x ** 2 + p1.y ** 2 - p2.y ** 2) / 2
    Line.new(a, b, c)
  end
end
# ::::::::::::::::::::
