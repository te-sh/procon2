---
title: "ABC #141 D"
problem: https://atcoder.jp/contests/abc141/tasks/abc141_d
---
$$ 1 $$ 枚の割引券を $$ X $$ 円の商品に使うと, 必要金額は $$ \ceil{X/2} $$ 減る. よって, 割引券を $$ 1 $$ 枚ずつそのときの金額が最も大きい商品に使うのが最適である.

優先度付きキューで管理すれば金額が最も大きい商品を高速に得られる.
