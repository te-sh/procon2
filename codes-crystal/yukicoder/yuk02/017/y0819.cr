# URL: https://yukicoder.me/problems/no/819

def solve(io)
  h, w = io.get2
  s = io.get_c(h, String)

  w = b = 0
  s.each_with_index do |si, i|
    si.chars.each_with_index do |c, j|
      if c == 'o'
        if (j + (h-i-1)).even?
          w += 1
        else
          b += 1
        end
      end
    end
  end

  io.put (w+b*2)%3 == 0 ? "YES" : "NO"
end

require "lib/procon"

solve(ProconIO.new)
