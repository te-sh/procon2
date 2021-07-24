# :::::::::::::::::::: lib/ext/int
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
  # i ビット目が 1 かどうかを返します
  #
  def bit?(i : Int)
    bit(i) == 1
  end

  #
  # i ビット目を 1 にした値を返します
  #
  def set_bit(i : Int)
    self | (self.class.new(1) << i)
  end

  #
  # i ビット目を 0 にした値を返します
  #
  def reset_bit(i : Int)
    self & ~(self.class.new(1) << i)
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
# ::::::::::::::::::::
