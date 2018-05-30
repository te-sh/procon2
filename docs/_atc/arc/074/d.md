---
title: "ARC #074 D"
problem: https://beta.atcoder.jp/contests/abc062/tasks/arc074_b
---
前半は $$ \{ a_1, a_2, \dots, a_{N+i} \} $$ から $$ N $$ 個選び, 後半は $$ \{ a_{N+i+1}, a_{N+i+2}, \dots, a_{3N} \} $$ から選ぶとする. このとき, 前半は上位 $$ N $$ 個を, 後半は下位 $$ N $$ 個を選ぶのが最適である.

これを $$ i $$ を変えながら計算する.

上位 $$ N $$ 個の選び方であるが, まず $$ i=0 $$ のときはそのまま総和が答えとなる. この $$ N $$ 要素は優先順位付きキューに入れておき, $$ i=1 $$ のときは $$ a_{N+1} $$ がキューの最小値より小さければなにもせず, そうでなければ最小値を入れ替える. 以下これを繰り返す.

下位 $$ N $$ 個の選び方も同様である.