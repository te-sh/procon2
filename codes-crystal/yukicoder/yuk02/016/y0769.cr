# URL: https://yukicoder.me/problems/no/769

def solve(io)
  n, m = io.get2
  l = io.get_c(m, String)
  ci = 0

  h = Array.new(n, 0)
  yi = 0
  d = +1
  draw2 = 0
  draw4 = 0

  while ci < m
    if draw2 > 0 && l[ci] != "drawtwo"
      h[yi] -= draw2 * 2
      draw2 = 0
    elsif draw4 > 0 && l[ci] != "drawfour"
      h[yi] -= draw4 * 4
      draw4 = 0
    else
      card = l[ci]
      h[yi] += 1
      ci += 1

      io.put_e yi + 1, h[yi] if ci == m

      case card
      when "number"
        nil
      when "drawtwo"
        draw2 += 1
      when "drawfour"
        draw4 += 1
      when "skip"
        yi += d
      when "reverse"
        d = -d
      end
    end

    yi = (yi + d) % n
  end
end

require "lib/procon"

solve(ProconIO.new)
