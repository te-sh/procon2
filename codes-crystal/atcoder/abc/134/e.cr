# URL: https://atcoder.jp/contests/abc134/tasks/abc134_e

def solve(io)
  n = io.get
  a = io.get_c(n)

  rbt = RedBlackTree(Int32).new
  a.reverse_each do |ai|
    r = rbt.search { |x| x > ai }
    rbt.remove(rbt.first) unless r.nil?
    rbt.add(ai)
  end

  io.put rbt.size
end

require "lib/procon"

require "lib/data_structure/red_black_tree"

solve(ProconIO.new)
