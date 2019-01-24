---
title: "Educational DP Contest K"
problem: https://atcoder.jp/contests/dp/tasks/dp_k
---
残りの石の数が $$ i $$ 個のときに手番の人が勝てるかどうかを $$ C(i) $$ とすると, $$ C(i-a_j) $$ のうちひとつでも負けであれば $$ C(i) $$ は勝ちである. そうでなければ負けである.
