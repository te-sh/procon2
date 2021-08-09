# URL: https://yukicoder.me/problems/no/792

def solve(io)
  n = io.get
  q = io.get_m(1 << n, n + 1)

  io.put_e "A=⊥" if q.map { |qi| qi[n] }.count(0) == 1 << n
  io.put_e "A=⊤" if q.map { |qi| qi[n] }.count(1) == 1 << n

  s = String.build do |s|
    q.each do |qi|
      if qi[n] == 1
        s << "∨" unless s.empty?
        s << "("
        (0...n).each do |i|
          s << "∧" unless i == 0
          s << "¬" if qi[i] == 0
          s << "P_" << i+1
        end
        s << ")"
      end
    end
  end

  io.put "A=#{s}"
end

require "lib/procon"

solve(ProconIO.new)
