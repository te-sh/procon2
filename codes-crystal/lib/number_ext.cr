# :::::::::::::::::::: lib/number_ext
#
# Number を拡張します
#
struct Number
  #
  # 0.36.0 以前のバージョン用の polyfill です
  #
  {% if compare_versions(env("CRYSTAL_VERSION") || "0.0.0", "0.36.0") < 0 %}
    def self.additive_identity
      zero
    end

    def self.multiplicative_identity
      new(1)
    end
  {% end %}
end

#
# Int を拡張します
#
struct Int
  #
  # self/b を小数点以下切り上げで求めます
  #
  def cdiv(b : Int)
    (self + b - 1) // b
  end

  #
  # 0.34.0 以前のバージョン用の polyfill です
  #
  {% if compare_versions(env("CRYSTAL_VERSION") || "0.0.0", "0.34.0") < 0 %}
    def bit_length : Int32
      x = self < 0 ? ~self : self

      if x.is_a?(Int::Primitive)
        Int32.new(sizeof(self) * 8 - x.leading_zeros_count)
      else
        to_s(2).size
      end
    end
  {% end %}
end

#
# Int32 を拡張します
#
struct Int32
  SQRT_MAX = 46_340_i32

  #
  # √n を超えない最大の整数を返します
  #
  def isqrt
    m = SQRT_MAX
    r = (1_i32..SQRT_MAX).bsearch { |i| i**2 > self }
    r.nil? ? SQRT_MAX : r - 1
  end
end

#
# Int64 を拡張します
#
struct Int64
  SQRT_MAX = 3_037_000_499_i64

  #
  # √n を超えない最大の整数を返します
  #
  def isqrt
    r = (1_i64..SQRT_MAX).bsearch { |i| i**2 > self }
    r.nil? ? SQRT_MAX : r - 1
  end
end
# ::::::::::::::::::::
