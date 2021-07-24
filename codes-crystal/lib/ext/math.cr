# :::::::::::::::::::: lib/ext/math
#
# Math を拡張します
#
module Math
  #
  # 1.2.0 以前のバージョン用の polyfill です
  #
  {% if compare_versions(env("CRYSTAL_VERSION") || "0.0.0", "1.2.0") < 0 %}
    def isqrt(value : Int::Primitive)
      raise ArgumentError.new "Input must be non-negative integer" if value < 0
      return value if value < 2
      res = value.class.zero
      bit = res.succ << (res.leading_zeros_count - 2)
      bit >>= value.leading_zeros_count & ~0x3
      while (bit != 0)
        if value >= res + bit
          value -= res + bit
          res = (res >> 1) + bit
        else
          res >>= 1
        end
        bit >>= 2
      end
      res
    end
  {% end %}
end
# ::::::::::::::::::::
