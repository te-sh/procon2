# :::::::::::::::::::: lib/ext/number
#
# Number を拡張します
#
struct Number
  #
  # 1.1.0 以前のバージョン用の polyfill です
  #
  {% if compare_versions(env("CRYSTAL_VERSION") || "0.0.0", "1.1.0") < 0 %}
    def zero?
      self == 0
    end

    def positive?
      self > 0
    end

    def negative?
      self < 0
    end
  {% end %}

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
# ::::::::::::::::::::
