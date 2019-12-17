---
title: "ABC #132 D"
problem: https://atcoder.jp/contests/abc132/tasks/abc132_d
---
青のボールが連続した部分を $$ i $$ 個用意する組み合わせの数を数える.

そのためには, 青のボールの間 $$ K-1 $$ のうち, $$ i-1 $$ 個を選び出し, そこに1つ以上の赤いボールを入れることになる. よって, $$ i-1 \gt N-K $$ の場合はそのような組み合わせの数は $$ 0 $$ となる.

そうでない場合, $$ i-1 $$ 個の間を選び出す組み合わせは $$ {}_{K-1}C_{i-1} $$ である.

まずはこの $$ i-1 $$ 個に $$ 1 $$ ずつ赤いボールを入れてしまう. 残りの $$ N-K-(i-1) $$ 個の赤いボールを先程選んだ $$ i-1 $$ 個の間と両端に分配する. これは重複組み合わせの数なので, $$ {}_{i+1}H_{N-K-(i-1)} $$ である.

よって, $$ {}_{K-1}C_{i-1} \cdot {}_{i+1}H_{N-K-(i-1)} $$ が答えとなる.

階乗と逆元はあらかじめ計算しておく.