---
title: "ARC #096 D"
problem: https://atcoder.jp/contests/abc095/tasks/arc096_b
---
スタート地点から時計回りに $$ a $$ 個食べ, スタート地点に戻って反時計周りに $$ b $$ 個食べることを考える. このときの最大差し引きカロリーであるが, これは時計回りに $$ a $$ 個食べてスタート地点に戻ってくるまでの差し引きカロリーの最大値と, スタート地点から反時計回りに $$ b $$ 個食べたときの差し引きカロリーの最大値を足したものとなる.

$$ a $$ が決まれば $$ b $$ は $$ 0 \leq b \leq N-a $$ の範囲となるので, この範囲での差し引きカロリーの最大値を求めることになる. これは累積最大値をあらかじめ求めておけばいい.

スタート地点から反時計回りに食べてスタートに戻り, 時計回りに食べる場合も同様に計算し, 両者のうち大きい方が答えとなる.
