# :::::::::::::::::::: lib/io/procon_io
#
# 競技プログラミング用の読み書きを行います.
#
class ProconIO
  #
  # コンストラクタ
  #
  def initialize(@ins : IO = STDIN, @outs : IO = STDOUT)
    @buf = [] of String
    @index = 0
  end

  #
  # 型を指定して値を読み込みます
  #
  def get(k : T.class = Int32) forall T
    get_v(k)
  end

  #
  # 型を指定して複数の値を読み込みます
  #
  macro define_get
    {% for i in (2..9) %}
      def get(
           {% for j in (1..i) %}
             k{{j}}{% if j < i %},{% end %}
           {% end %}
         )
        {
          {% for j in (1..i) %}
            get(k{{j}}){% if j < i %},{% end %}
          {% end %}
        }
      end
    {% end %}
  end
  define_get

  #
  # 個数と型を指定して複数の値を読み込みます
  #
  macro define_getn
    {% for i in (2..9) %}
      def get{{i}}(k : T.class = Int32) forall T
        get(
          {% for j in (1..i) %}
            k{% if j < i %}, {% end %}
          {% end %}
        )
      end
    {% end %}
  end
  define_getn

  #
  # 型を指定して横に並んだ配列の値を読み込みます
  #
  def get_a(n : Int, k : T.class = Int32) forall T
    Array.new(n) { get_v(k) }
  end

  #
  # 型を指定して縦に並んだ配列の値を読み込みます
  #
  def get_c(n : Int, k : T.class = Int32) forall T
    get_a(n, k)
  end

  #
  # 型を指定して縦に並んだ配列の複数の値を読み込みます
  #
  macro define_get_c
    {% for i in (2..9) %}
      def get_c(
           n : Int,
           {% for j in (1..i) %}
             k{{j}}{% if j < i %},{% end %}
           {% end %}
         )
        a = Array.new(n) do
          get(
            {% for j in (1..i) %}
              k{{j}}{% if j < i %},{% end %}
            {% end %}
          )
        end
        {
          {% for j in (1..i) %}
            a.map { |e| e[{{j-1}}] }{% if j < i %},{% end %}
          {% end %}
        }
      end
    {% end %}
  end
  define_get_c

  #
  # 個数と型を指定して縦に並んだ配列の複数の値を読み込みます
  #
  macro define_getn_c
    {% for i in (2..9) %}
      def get{{i}}_c(n : Int, k : T.class = Int32) forall T
        get_c(
          n,
          {% for j in (1..i) %}
            k{% if j < i %}, {% end %}
          {% end %}
        )
      end
    {% end %}
  end
  define_getn_c

  #
  # 型を指定して行列の値を読み込みます
  #
  def get_m(r : Int, c : Int, k : T.class = Int32) forall T
    Array.new(r) { get_a(c, k) }
  end

  #
  # 複数の値を空白区切りで出力します
  #
  def put(*vs)
    vs.each.with_index do |v, i|
      put_v(v)
      @outs.print i < vs.size - 1 ? " " : "\n"
    end
  end

  #
  # 複数の値を空白区切りで出力してプログラムを終了します
  #
  def put_e(*vs)
    put(*vs)
    exit
  end

  # ---------- private methods

  private def get_v(k : Int32.class); get_token.to_i32; end
  private def get_v(k : Int64.class); get_token.to_i64; end
  private def get_v(k : UInt32.class); get_token.to_u32; end
  private def get_v(k : UInt64.class); get_token.to_u64; end
  private def get_v(k : Float64.class); get_token.to_f64; end
  private def get_v(k : String.class); get_token; end

  private def get_token
    if @buf.size == @index
      str = @ins.read_line
      @buf = str.split
      @index = 0
    end
    v = @buf[@index]
    @index += 1
    v
  end

  private def put_v(vs : Enumerable)
    vs.each_with_index do |v, i|
      @outs.print v
      @outs.print " " if i < vs.size - 1
    end
  end

  private def put_v(v)
    @outs.print v
  end
end
# ::::::::::::::::::::
