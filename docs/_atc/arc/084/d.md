---
title: "ARC #084 D"
problem: https://atcoder.jp/contests/abc077/tasks/arc084_b
---
各桁の和を求める操作をグラフの最短路を求める操作に変換する.

頂点に非負整数を割り当て, 以下のように辺を張る.

* 頂点 $$ x $$ から $$ x+1 $$ にコスト1の辺を張る. これは各桁の和に1を加えることを示す.
* 頂点 $$ x $$ から $$ 10x $$ にコスト0の辺を張る. 10倍しても各桁の和は変わらない.

これで $$ 1 $$ から始めてある数 $$ N $$ までの最短コストを求め, その数に1を加えたものが各桁の和になる.

なお, 1つ目の辺を張るときに $$ x $$ の下1桁が9の場合は各桁の和に1を加えることにならないが, その場合の $$ x+1 $$ には2つ目の辺を使った最短路が存在するので, 特別扱いはしなくてもいい.

このままでは頂点数が無限に必要になるが, 実際には $$ N \bmod K $$ が同じ頂点は同一視できる.

後は dijkstra 法で最短距離を求めればいい.
