require "spec"
require "lib/ext/float"
require "lib/math/geom"

module GeomSpec
  include Geom

  it "#dist" do
    p1 = Point.new(0, 0)
    p2 = Point.new(3, 4)
    Geom.dist(p1, p2).near?(5).should eq true
  end

  it "#dist" do
    p = Point.new(0, 0)
    l = Line.new(3, -4, -2)
    Geom.dist(p, l).near?(0.4).should eq true
  end

  it "#intersect line and line" do
    l1 = Line.new(1, -1, 3)
    l2 = Line.new(2, 1, -6)
    p = Geom.intersect(l1, l2).not_nil!
    p.x.near?(1).should eq true
    p.y.near?(4).should eq true

    l3 = Line.new(2, -2, 5)
    Geom.intersect(l1, l3).should eq nil
  end

  it "#intersect circle and line" do
    c = Circle.new(2, 3, 2)
    l1 = Line.new(1, -1, 3)
    p1, p2 = Geom.intersect(c, l1).not_nil!
    p1.x.near?(0).should eq true
    p1.y.near?(3).should eq true
    p2.x.near?(2).should eq true
    p2.y.near?(5).should eq true

    l2 = Line.new(1, -1, 5)
    Geom.intersect(c, l2).should eq nil
  end

  it "#intersect circle and circle" do
    c1 = Circle.new(0, 1, 5)
    c2 = Circle.new(4, 3, Math.sqrt(5))
    p1, p2 = Geom.intersect(c1, c2).not_nil!
    p1.x.near?(3).should eq true
    p1.y.near?(5).should eq true
    p2.x.near?(5).should eq true
    p2.y.near?(1).should eq true

    c3 = Circle.new(10, 3, Math.sqrt(5))
    Geom.intersect(c1, c3).should eq nil
  end

  it "#bisector" do
    p1 = Point.new(1, 3)
    p2 = Point.new(5, 1)
    l = Geom.bisector(p1, p2).not_nil!
    (l.c / l.a).near?(-2).should eq true
    (l.c / l.b).near?(4).should eq true

    Geom.bisector(p1, p1).should eq nil
  end
end
