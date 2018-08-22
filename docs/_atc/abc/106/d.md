---
title: "ABC #106 D"
problem: https://beta.atcoder.jp/contests/abc106/tasks/abc106_d
---
$$ p, q $$ 間に完全に含まれる路線の数をあらかじめ数えておく.

路線が $$ L, R $$ 間を結ぶとき, $$ p \leq L \land q \geq R $$ となる $$ p, q $$ において完全に含まれる路線が1つ増える.

そこでこれを二次元表で管理し, 二次元 imos 法を使って完全に含まれる路線数を計算する.
