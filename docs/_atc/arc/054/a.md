---
title: "ARC #054 A"
problem: https://beta.atcoder.jp/contests/arc054/tasks/arc054_a
---
時計回りに移動したときの出口までの距離は, $$ S \leq D $$ ならば $$ D-S $$ であり, そうでなければ $$ D-S+L $$ である. またこのときの移動速度は $$ Y+X $$ である.

反時計周りに移動したときの出口までの距離は, $$ D \leq S $$ ならば $$ S-D $$ であり, そうでなければ $$ S-D+L $$ である. またこのときの移動速度は $$ Y-X $$ である.

両者の時間を計算して小さい方を出力する. なお, $$ Y-X \leq 0 $$ のときは時計回りに進んだ方が早いので比較しない.