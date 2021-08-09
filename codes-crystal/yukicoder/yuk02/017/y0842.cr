# URL: https://yukicoder.me/problems/no/842

def solve(io)
  a, b, c, d, e, f, g = io.get7
  (0..a).each do |na|
    (0..b).each do |nb|
      (0..c).each do |nc|
        (0..d).each do |nd|
          (0..e).each do |ne|
            (0..f).each do |nf|
              io.put_e "YES" if na*500 + nb*100 + nc*50 + nd*10 + ne*5 + nf*1 == g
            end
          end
        end
      end
    end
  end
  io.put "NO"
end

require "lib/procon"

solve(ProconIO.new)
