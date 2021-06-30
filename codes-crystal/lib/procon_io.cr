# :::::::::::::::::::: lib/procon_io
#
# 競技プログラミング用の読み書きを行います.
#
class ProconIO
  def initialize
    @buf = [] of String
    @index = 0
  end

  #
  # 型を指定して値を読み込みます
  #
  def get_v(k); get(k); end

  #
  # 型を指定して値を複数読み込みます
  #
  def get_v(*ks); ks.map { |k| get(k) }; end

  #
  # 型を指定して横に並んだ配列の値を読み込みます
  #
  def get_a(n : Int, k); Array.new(n) { get(k) }; end

  #
  # 型を指定して縦に並んだ配列の値を読み込みます
  #
  def get_c(n : Int, k); get_a(n, k); end

  #
  # 複数の値を空白区切りで出力します
  #
  def put(*vs)
    vs.each.with_index do |v, i|
      print v
      print i < vs.size - 1 ? " " : "\n"
    end
  end

  private def get(k : Int32.class); get_token.to_i32; end

  private def get(k : String.class); get_token; end

  private def get_token
    if @buf.size == @index
      @buf = read_line.split
      @index = 0
    end
    v = @buf[@index]
    @index += 1
    v
  end
end
# ::::::::::::::::::::
