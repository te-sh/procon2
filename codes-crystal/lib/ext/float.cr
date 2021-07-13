# :::::::::::::::::::: lib/ext/float
#
# Float64 を拡張します
#
struct Float64
  def near_zero?
    self.abs < EPSILON
  end
end
# ::::::::::::::::::::
