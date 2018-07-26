---
title: "ARC #039 B"
problem: https://beta.atcoder.jp/contests/arc039/tasks/arc039_b
---
$$ N \leq K $$ のときは, 積を最大にするにはなるべく均等に配るのが良い. このとき, $$ m = K \bmod N $$ とすると, 分配方法は $$ {}_N C_m $$ 通りである.

$$ N \gt K $$ のときは幸福度は $$ 0 $$ になるので, どのように配ってもいい. これは $$ {}_N H_K $$ 通りである.
