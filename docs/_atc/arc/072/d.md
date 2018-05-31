---
title: "ARC #072 D"
problem: https://beta.atcoder.jp/contests/abc059/tasks/arc072_c
---
$$ \vert X-Y \vert \leq 1 $$ ならば手番の人の負けである.

$$ (X-2i)-(Y+i) = X-Y-3i, (X+i)-(Y-2i) = X-Y+3i $$ なので, $$ \vert X-Y \vert \leq 1 $$ の状態からは必ず $$ \vert X-Y \vert \gt 1 $$ の状態にしか遷移できない.

逆に $$ \vert X-Y \vert \gt 1 $$ の場合は, $$ i $$ をうまく選ぶことで $$ \vert X-Y \vert \leq 1 $$ の状態にもっていける.

よって, $$ (X, Y) = (0, 1), (1, 0), (1, 1) $$ はいずれも負けなので, $$ \vert X-Y \vert \leq 1 $$ ならば手番の人の負けである.
