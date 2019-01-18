---
title: "ARC #085 E"
problem: https://atcoder.jp/contests/arc085/tasks/arc085_c
---
燃やす埋める問題である.

宝石 $$ i $$ と $$ s, t $$ を頂点とするグラフを考える. $$ s \rightarrow i $$ は残す, $$ i \rightarrow t $$ は叩き潰す辺に対応させる.

$$ a_i \gt 0 $$ のときは, 叩き潰したときに本来もらえる $$ a_i $$ がもらえなくなるので, $$ i \rightarrow t $$ に $$ a_i $$ の容量を設定する.

$$ a_i \leq 0 $$ のときは, 残したときに $$ -a_i $$ の損になるので, $$ s \rightarrow i $$ に $$ -a_i $$ の容量を設定する.

宝石 $$ i $$ を叩き潰したときに $$ j $$ ($$ i $$ の倍数) が残っていてはいけないので, $$ i \rightarrow j $$ に容量無限大の辺を張る.

あとは最小カット=最大フローの定理を使って解く. 容量が大きいので Ford-Fulkerson では間に合わない. Dinic を使う.

これで出た答えを本来もらえるはずの $$ a_i \gt 0 $$ となる $$ a_i $$ の合計から引いたものが答えとなる.
