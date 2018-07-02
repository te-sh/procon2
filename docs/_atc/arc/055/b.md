---
title: "ARC #055 B"
problem: https://beta.atcoder.jp/contests/arc055/tasks/arc055_b
---
$$ i $$ 番目のせんべいに対しての戦略は, 今までで最大のせんべいでない場合は食べず, 最大ならば迷うことである.

そこで, 残りのせんべいの枚数が $$ i $$ 枚で $$ j $$ 枚食べていて, 最大のせんべいを食べたかどうかを $$ k $$ としたときの確率を $$ P(i, j, k) $$ とする. 当然ながら $$ P(0, *, true) = 1, P(0, *, false) = 0 $$ である.

$$ i $$ 番目に最大のせんべいがくる確率は $$ 1/i $$ なので, DP の遷移は以下のようになる.

$$
P(i, j, k) = (1-1/i)P(i-1, j, k) + (1/i)\max(P(i-1, j+1, true), P(i-1, j, false))
$$

あとはこれをDPで計算する.