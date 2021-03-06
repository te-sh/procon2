---
title: "ABC #125 D"
problem: https://atcoder.jp/contests/abc125/tasks/abc125_d
---
同じ場所で2回以上操作することは無意味である. 左から順に操作を行う/行わないを決めていく.

まずは1番目を正にすることを考える. 1番目がもともと正ならば操作は行わなくてよく, 負ならば操作を行えばいい.

次に2番目を正にすることを考える. 1番目に操作を行ったかどうかによって, 2番目の操作を行うかどうかは決められる.

これを繰り返すことで $$ N-1 $$ 番目までの操作が確定する.

このとき, $$ N $$ 番目も正になるならこれが最適である.

$$ N $$ 番目が負になるとき, $$ i $$ 番目だけが負になるように操作を行ってみる. そうすると, 以降の操作を行うかどうかはすべて逆になるので, $$ N $$ 番目は正にできる.

よって, $$ \vert A_i \vert $$ が最も小さいものを負にして, 残りは正になるようにすれば, これが最適である.
