# :::::::::::::::::::: lib/ext/number
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
# ::::::::::::::::::::
