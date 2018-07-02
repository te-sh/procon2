---
title: "ARC #100 D"
problem: https://beta.atcoder.jp/contests/abc102/tasks/arc100_b
---
$$ BC $$ と $$ DE $$ の切れ目で全探索する.

$$ BC $$ の切れ目は $$ P, Q $$ がなるべく均等になるようにするのが最適である. これは累積和を計算しておいて二分探索で探すことができる.

$$ DE $$ も同様に後ろからの累積和を計算しておけばいい.
