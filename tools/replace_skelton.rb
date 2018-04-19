SKELTON = <<EOF
auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
EOF

DIRS = %w[codeforces]

DIRS.each do |dir|
  Dir.glob("../codes/#{dir}/**/*.d") do |file|
    chunks = IO.readlines(file).chunk { |line| /\A\s*\z/ !~ line || nil }.map(&:last).to_a
    chunks[2] = [SKELTON]
    File.open(file, 'w') do |f|
      chunks.each_with_index do |chunk, i|
        f.puts chunk
        f.puts if i < chunks.size - 1
      end
    end
  end
end
