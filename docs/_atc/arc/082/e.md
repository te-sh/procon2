---
title: "ARC #082 E"
problem: https://atcoder.jp/contests/arc082/tasks/arc082_c
---
$$ S $$ の辺または内部にある点の集合を $$ T_s $$ とすると, $$ S $$ のスコアは $$ T_s $$ の部分集合の数となる.

よって, $$ N $$ 個の点から適当な点をピックアップしたとき, この点群の凸包の頂点が $$ S $$ になればスコアを1カウントすればいいことになる.

すべての $$ S $$ について考えると, $$ N $$ 個の点からピックアップした点の凸包が正の面積を持てばスコアを1カウントすればいいことになる.

これは $$ 2^N $$ から以下を引けばいい.

* 0点ピックアップする場合: $$ 1 $$ 通り
* 1点ピックアップする場合: $$ N $$ 通り
* 2点以上ピックアップして同一直線上にある場合: すべての直線を見て, 直線上に2点以上乗っている場合はその点の数を $$ k $$ とすると $$ 2^k-k-1 $$ 通り
