---
title: "ABC #151 B"
problem: https://atcoder.jp/contests/abc151/tasks/abc151_b
---
平均点を $$ M $$ 点以上にするということは, 合計得点を $$ MN $$ 点以上にするということである.

よって, $$ r = MN - \sum A_i $$ を計算して, $$ r \leq K $$ なら $$ \max \{ r, 0 \} $$ を, そうでなければ $$ -1 $$ を出力する.
