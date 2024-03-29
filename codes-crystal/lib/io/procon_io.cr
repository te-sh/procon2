# :::::::::::::::::::: lib/io/procon_io
#
# 競技プログラミング用の読み書きを行います.
#
class ProconIO
  #
  # コンストラクタ
  #
  def initialize(@ins : IO = STDIN, @outs : IO = STDOUT)
    @buf = IO::Memory.new("")
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
      def get({{ *(1..i).map { |j| "k#{j}".id } }})
        { {{ *(1..i).map { |j| "get(k#{j})".id } }} }
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
        get({{ *(1..i).map { "k".id } }})
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
      def get_c(n : Int, {{ *(1..i).map { |j| "k#{j}".id } }})
        a = Array.new(n) { get({{ *(1..i).map { |j| "k#{j}".id } }}) }
        { {{ *(1..i).map { |j| "a.map { |e| e[#{j-1}] }".id } }} }
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
        get_c(n, {{ *(1..i).map { "k".id } }})
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
  macro define_put
    {% for i in (1..9) %}
      def put({{ *(1..i).map { |j| "v#{j}".id } }}, *, delimiter = " ")
        {% for j in (1..i) %}
          print_v(v{{j}}, delimiter)
          {% if j < i %}@outs << delimiter{% end %}
        {% end %}
        @outs.puts
      end
    {% end %}
  end
  define_put

  #
  # 複数の値を空白区切りで出力してプログラムを終了します
  #
  def put_e(*vs)
    put(*vs)
    exit
  end

  #
  # 複数の値を空白区切りで出力して最後に flush します
  #
  def put_f(*vs)
    put(*vs)
    @outs.flush
  end

  # ---------- private methods

  private def get_v(k : Int32.class); get_token.to_i32; end
  private def get_v(k : UInt32.class); get_token.to_u32; end
  private def get_v(k : Int64.class); get_token.to_i64; end
  private def get_v(k : UInt64.class); get_token.to_u64; end
  private def get_v(k : Float64.class); get_token.to_f64; end
  private def get_v(k : String.class); get_token; end

  private def get_token
    loop do
      token = @buf.gets(' ', chomp: true)
      break token unless token.nil?
      @buf = IO::Memory.new(@ins.read_line)
    end
  end

  private def print_v(v, dlimiter)
    @outs << v
  end

  private def print_v(v : Enumerable, delimiter)
    v.each_with_index do |e, i|
      @outs << e
      @outs << delimiter if i < v.size - 1
    end
  end
end
# ::::::::::::::::::::
