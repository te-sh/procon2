# URL: https://yukicoder.me/problems/no/774

require "big"

def solve(io)
  n = io.get
  a = io.get_a(n, String)

  c = a.each_permutation.map { |b| b.join.to_i64 }.to_a.sort.uniq
  c.reverse_each do |ci|
    io.put_e ci if ci.to_big_i.probab_prime?
  end

  io.put -1
end

require "lib/procon"

require "lib/ext/big_int"

solve(ProconIO.new)
