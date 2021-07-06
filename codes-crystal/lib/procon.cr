# :::::::::::::::::::: lib/procon
require "lib/ext/array"

require "lib/ext/int"

require "lib/ext/number"

require "lib/io/procon_io"

#
# a = Math.min(a, b) に置き換えます
#
macro min_u(a, b)
  {{a}} = Math.min({{a}}, {{b}})
end

#
# a = Math.max(a, b) に置き換えます
#
macro max_u(a, b)
  {{a}} = Math.max({{a}}, {{b}})
end
# ::::::::::::::::::::
