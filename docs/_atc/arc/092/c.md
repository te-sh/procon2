---
title: "ARC #092 C"
problem: https://atcoder.jp/contests/arc092/tasks/arc092_a
---
二部グラフのマッチング問題に帰着できる.

まず $$ s \rightarrow i, j \rightarrow t $$ に辺を張り, さらに $$ a_i \lt c_j \land b_i \lt d_j $$ であれば $$ i \rightarrow j $$ に辺を張る. いずれも辺の容量は1である.

あとは FordFulkerson なりで最大フローを求める.
