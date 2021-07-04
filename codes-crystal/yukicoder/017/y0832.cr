# URL: https://yukicoder.me/problems/no/832

def main(io)
  atama = (1..9).map { |i| [i, i] }
  ko = (1..9).map { |i| [i, i, i] }
  shun = (1..7).map { |i| [i, i+1, i+2] }
  men = ko + shun

  mens = men.repeated_combinations(4)
         .map { |m| m.flatten }

  pai = atama.product(mens).map { |a, m| (a + m).sort }.reject { |m| (1..9).any? { |i| m.count(i) > 4 } } +
        atama.combinations(7).map(&.flatten)

  pai.uniq!.sort!

  s = io.get(String)
  b = s.chars.map(&.to_i)

  (1..9).each do |i|
    io.put i if pai.includes?((b + [i]).sort)
  end
end

require "lib/procon_io"

main(ProconIO.new)
