# URL: https://atcoder.jp/contests/abs/tasks/practice_1

def main(io)
  a = io.get_v(Int32)
  b, c = io.get_v(Int32, Int32)
  s = io.get_v(String)

  io.put(a+b+c, s)
end

class ProconIO
  def initialize
    @buf = [] of String
    @index = 0
  end

  def get_v(k); get(k); end

  def get_v(*ks); ks.map { |k| get(k) }; end

  def get(k : Int32.class); get_token.to_i32; end

  def get(k : String.class); get_token; end

  def get_token
    if @buf.size == @index
      @buf = read_line.split
      @index = 0
    end
    v = @buf[@index]
    @index += 1
    v
  end

  def put(*vs)
    vs.each.with_index do |v, i|
      print v
      print i < vs.size - 1 ? " " : "\n"
    end
  end
end

main(ProconIO.new)
