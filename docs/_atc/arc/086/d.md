---
title: "ARC #086 D"
problem: https://beta.atcoder.jp/contests/abc081/tasks/arc086_b
---
$$ \vert a_i \vert $$ が最大である $$ a_i $$ を求める. これを $$ A $$ とする.

$$ A \gt 0 $$ のときは, $$ a_2 + 2A \gt A $$ となるので, $$ a_2 \gt a_1 $$ を達成できる. $$ a_2 $$ を新たな $$ A $$ として $$ a_3 $$ 以降も同様に行えば目標の数列を作ることができる.

$$ A \lt 0 $$ のときは, $$ a_{N-1} $$ から順に処理していく.

$$ A = 0 $$ のときは何もしなくていい.
