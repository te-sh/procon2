# :::::::::::::::::::: lib/procon_io
#
# 競技プログラミング用の読み書きを行います.
#
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
# ::::::::::::::::::::
