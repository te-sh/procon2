---
title: "ABC #136 C"
problem: https://atcoder.jp/contests/abc136/tasks/abc136_c
---
右から順にマスの操作を考える.

$$ H_i \gt H_{i+1}+1 $$ ならば単調非減少にはできない.

$$ H_i = H_{i+1}+1 $$ ならば $$ H_i $$ を $$ 1 $$ 減らす.

$$ H_i \leq H_{i+1} $$ ならば何もしない.

最後まで操作できれば単調非減少にできる.
