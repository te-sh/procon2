---
title: "ARC #044 C"
problem: https://atcoder.jp/contests/arc044/tasks/arc044_c
---
求めるのはマンハッタン距離なので, 縦横は別々に計算できる.

時刻 $$ t $$ に場所 $$ x $$ にいるときの最小移動距離を $$ D(t, x) $$ としてこれを DP で計算する. 愚直に計算すると $$ O(WT) $$ となるが, ビームが来る座標のみ右か左かに避ければいいので, 右に避ける場合と左に避ける場合でそれぞれ計算すればいい.
