# :::::::::::::::::::: lib/number_ext
#
# Number を拡張します
#
struct Number
  #
  # 0.36.0 以前のバージョン用の polyfill
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
