# URL: https://yukicoder.me/problems/no/850

def solve(io)
  n = io.get

  a = Array.new(n, &.+ 1)
  b = Array.new(n+1) { [] of Int32 }

  while a.size > 1
    a2 = [] of Int32
    a.each_slice(2) do |g|
      if g.size == 1
        a2 << g[0]
      else
        io.put_f "?", g[0], g[1]
        w = io.get
        if w == g[0]
          b[g[0]] << g[1]
        else
          b[g[1]] << g[0]
        end
        a2 << w
      end
    end
    a = a2
  end

  a = b[a[0]]
  while a.size > 1
    a2 = [] of Int32
    a.each_slice(2) do |g|
      if g.size == 1
        a2 << g[0]
      else
        io.put_f "?", g[0], g[1]
        a2 << io.get
      end
    end
    a = a2
  end

  io.put "!", a[0]
end

require "lib/procon"

solve(ProconIO.new)
