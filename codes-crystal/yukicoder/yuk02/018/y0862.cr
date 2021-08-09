# URL: https://yukicoder.me/problems/no/862

def solve(io)
  n, x = io.get2

  r = [] of Int32
  if x == 1
    m = (n - 1) % 4 + 1
    case m
    when 1
      r.concat([1])
    when 2
      r.concat([2, 3])
    when 3
      r.concat([2, 4, 7])
    when 4
      r.concat([1, 3, 4, 7])
    end

    n -= m
    a = 2
    until n == 0
      r.concat((a*4..a*4+3).to_a)
      n -= 4
      a += 1
    end
  else
    a = (x - 2) // 4
    m = (n - 1) % 4 + 1
    case (x - 2) % 4
    when 0
      case m
      when 1
        r.concat([a*4+2])
      when 2
        r.concat([1, a*4+3])
      when 3
        r.concat([a*4+3, a*4+4, a*4+5])
      when 4
        r.concat([1, a*4+2, a*4+4, a*4+5])
      end
    when 1
      case m
      when 1
        r.concat([a*4+3])
      when 2
        r.concat([1, a*4+2])
      when 3
        r.concat([a*4+2, a*4+4, a*4+5])
      when 4
        r.concat([1, a*4+3, a*4+4, a*4+5])
      end
    when 2
      case m
      when 1
        r.concat([a*4+4])
      when 2
        r.concat([1, a*4+5])
      when 3
        r.concat([a*4+2, a*4+3, a*4+5])
      when 4
        r.concat([1, a*4+2, a*4+3, a*4+4])
      end
    when 3
      case m
      when 1
        r.concat([a*4+5])
      when 2
        r.concat([1, a*4+4])
      when 3
        r.concat([a*4+2, a*4+3, a*4+4])
      when 4
        r.concat([1, a*4+2, a*4+3, a*4+5])
      end
    end

    n -= m
    b = 0
    until n == 0
      if b != a
        r.concat((b*4+2..b*4+5).to_a)
        n -= 4
      end
      b += 1
    end
  end

  r.each do |ri|
    io.put ri
  end
end

require "lib/procon"

solve(ProconIO.new)
