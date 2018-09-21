---
title: "ARC #102 D"
problem: https://beta.atcoder.jp/contests/abc108/tasks/arc102_b
---
$$ L \geq 2^r $$ となる最大の $$ r $$ を考える.

頂点1から頂点2へ長さ $$ 0, 1 $$ の多重辺を引き, 頂点2から頂点3へ長さ $$ 0, 2 $$ の多重辺を引く. 以下同様に 頂点 $$ i $$ から頂点 $$ i+1 $$ へ長さ $$ 0, 2^{i-1} $$ の多重辺を引く. これを $$ i = r $$ まで繰り返すと, 頂点数 $$ r+1 $$ 個のグラフができ, これで2進数の計算の要領で $$ 0 $$ から $$ 2^r-1 $$ の数をすべて表すことができる.

残りは $$ 2^r $$ から $$ L-1 $$ までの数を表せばいい. これは $$ L-2^r $$ を $$ L_1 $$ とすると, $$ 0+2^r $$ から $$ L_1-1+2^r $$ の数を表すようにすればいいので, 再度 $$ L_1 \geq 2^r_1 $$ となる最大の $$ r_1 $$ を考え, 頂点 $$ r_1+1 $$ から最後の頂点に長さ $$ 2^r $$ の辺を引くことで, $$ 0+2^r $$ から $$ 2^{r_1+1}+2^r $$ までの数も表すことができる.

以下これを繰り返していけばいい.