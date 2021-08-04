# :::::::::::::::::::: lib/ext/float
#
# Float64 を拡張します
#
struct Float64
  def near?(x)
    (self - x).abs <= (self.abs < x.abs ? x.abs : self.abs) * EPSILON
  end
end
# ::::::::::::::::::::
