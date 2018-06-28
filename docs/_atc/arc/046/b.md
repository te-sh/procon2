---
title: "ARC #046 B"
problem: https://beta.atcoder.jp/contests/arc046/tasks/arc046_b
---
$$ N \leq A $$ のときは無条件で高橋くんの勝ちである.

$$ A=B $$ のときはいわゆる Nim である. $$ N \equiv 0 \pmod{A+1} $$ ならば青木くんの勝ちであり, そうでなければ高橋くんの勝ちである.

$$ A \gt B $$ のときは高橋くんの勝ちである. 高橋くんに $$ A+1 $$ で回しても高橋くんは $$ B+1 $$ 個残すように取ればいい.

$$ A \lt B $$ のときは同様に青木くんの勝ちである.
