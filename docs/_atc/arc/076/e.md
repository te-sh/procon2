---
title: "ARC #076 E"
problem: https://beta.atcoder.jp/contests/abc065/tasks/arc076_c
---
両端がともに辺の上にある数字しか考えなくてもいい. そうでない数字は必ず避けるルートが存在する.

このとき, 四辺のどこかで切って辺を直線に変形して, 対応する数値の間にある数値がペアになっていればルートは存在する. ペアになっていない数値がひとつでも存在すればルートは存在しない.

これを確認するにはスタックを使えばいい. 辺上の数値を順に見ていき, 今見ている数値がスタックのトップと一致していれば削除し, そうでなければスタックに積む. 最後にスタックが空になっていればOKである.