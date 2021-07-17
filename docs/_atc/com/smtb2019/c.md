---
title: "SMTB2010 C"
problem: https://atcoder.jp/contests/sumitrust2019/tasks/sumitb2019_c
---
商品を合計で $$ n $$ 個買うとすると, $$ X - 100n $$ 円で $$ 0, 1, \dots, 5 $$ 円の商品を $$ n $$ 個買えるかどうかという問題となる. これは $$ X - 100n \leq 5n $$ であれば可能である.

$$ n $$ は最大でも $$ \floor{X / 100} $$ なので総当りする.
