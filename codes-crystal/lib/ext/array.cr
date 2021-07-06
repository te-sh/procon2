# :::::::::::::::::::: lib/ext/array
#
# Array を拡張します
#
class Array
  #
  # 多次元配列を作成します
  #
  macro new_md(*args, &block)
    {% if !block %}
      {% for arg, i in args[0...-2] %}
        Array.new({{arg}}) {
      {% end %}
      Array.new({{args[-2]}}, {{args[-1]}})
      {% for arg in args[0...-2] %}
        }
      {% end %}
    {% else %}
      {% for arg, i in args %}
        Array.new({{arg}}) { |_i{{i}}|
      {% end %}
      {% for block_arg, i in block.args %}
        {{block_arg}} = _i{{i}}
      {% end %}
      {{block.body}}
      {% for arg in args %}
        }
      {% end %}
    {% end %}
  end
end
# ::::::::::::::::::::
