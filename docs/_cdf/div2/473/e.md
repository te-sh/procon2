---
title: "Div.2 #473 E"
problem: http://codeforces.com/contest/959/problem/E
---
最小全域木は以下方法で構成できる.

> すべての辺をコストが少ない順に並べ, 順に追加していく. 追加するときに辺の両端がすでに連結であれば追加しない.

$$ n $$ が大きいので直接計算させることはできないので, これを机上でシミュレートしてみる.

まずは, $$ (0,1), (2,3), (4,5), \dots $$ の辺がコスト最小の1なのでこれをすべて追加する.

次に $$ (0,2), (4,6), (8,10), \dots $$ の辺がコスト最小の2なのでこれをすべて追加する. なお $$ (1,3) $$ などはすでに連結なので追加しない.

次にコスト最小なのは $$ (0,4), (8,12), \dots $$ のコスト4の辺となるのでこれをすべて追加する.

こうしていくとトーナメント表のようなものができあがる. $$ i $$ 回戦目のコストは $$ 2^{i-1} $$ である.

後はこれをすべて足せばいい.