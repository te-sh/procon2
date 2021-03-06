---
title: "ARC #073 E"
problem: https://atcoder.jp/contests/arc073/tasks/arc073_c
---
$$ x_i \geq y_i $$ としても一般性を失わない.

$$ x_i $$ の最大値は $$ R_{max} $$ か $$ B_{max} $$ のどちらかになるが, どちらでも変わらないので $$ R_{max} $$ に固定する.

続いて $$ y_i $$ の最小値は $$ R_{min} $$ か $$ B_{min} $$ のどちらかになる.

まずは, $$ y_i $$ の最小値を $$ B_{min} $$ にした場合を考える.

この場合は, $$ R_{min} $$ はできるだけ大きく, $$ B_{max} $$ はできるだけ小さくしたいので, 各袋について大きい方を赤に, 小さい方を青に塗ればいい.

次に, $$ y_i $$ の最小値を $$ R_{min} $$ にした場合を考える.

この場合は残りの袋から任意に片方だけ選んで $$ B_{max}-B_{min} $$ を最小化するように選びたい.

とりあえずすべて $$ y_i $$ を青に塗ってみる. あとは $$ y_i $$ が小さいものから取り出し, 入れ替えることで $$ B_{max}-B_{min} $$ が小さくなる間だけ入れ替えればいい. 最大最小はセグメントツリーで管理する.

なお, このときに $$ y_i $$ の最小値が $$ B_{min} $$ になってしまう場合があるが, そのときは1番目のパターンで処理できるので, ここでは何も考えずにすべての袋について処理していい.
