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
  # l1 と l2 の交点を返します
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
