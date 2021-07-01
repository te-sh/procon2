# URL: https://atcoder.jp/contests/abs/tasks/arc065_a

C = %w[dream dreamer erase eraser].map(&.reverse)

def main(io)
  s = io.get(String)
  t = s.reverse
  until t.empty?
    f = C.find { |c| t.starts_with?(c) }
    io.put_e "NO" unless f
    t = t[f.size..]
  end
  io.put "YES"
end

require "lib/procon_io"

main(ProconIO.new)
