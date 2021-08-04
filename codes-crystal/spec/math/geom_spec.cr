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

  it "#intersect" do
    l1 = Line.new(1, -1, 3)
    l2 = Line.new(2, 1, -6)
    p = Geom.intersect(l1, l2).not_nil!
    p.x.near?(1).should eq true
    p.y.near?(4).should eq true

    Geom.intersect(l1, l1).should eq nil
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
