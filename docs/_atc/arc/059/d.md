---
title: "ARC #059 D"
problem: https://atcoder.jp/contests/abc043/tasks/arc059_b
---
長さ $$ k $$ のアンバランスな文字を考える.

$$ k $$ が偶数のときは同じ文字が $$ k/2+1 $$ 個ある. 文字の間は $$ k/2 $$ 個しかなく, 残りの文字は $$ k/2-1 $$ 個なので, 必ず同じ文字が隣り合う部分がある.

$$ k $$ が奇数のときはうまく並べれば同じ文字を1つ置きにできるが, それ以外のパターンでは必ず同じ文字が隣り合う部分がある.

よって, ある文字に着目すると, その1つ先および2つ先の文字が一致すればアンバランスであり, そういう場合がない文字列はアンバランスにならない.
