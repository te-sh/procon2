---
title: "ARC #057 A"
problem: https://atcoder.jp/contests/arc057/tasks/arc057_a
---
$$ i $$ 日後の所持金を $$ a_i $$ とすると,

$$
\begin{align}
a_{i+1} &= 1+(K+1)a_i \\
a_0 &= A
\end{align}
$$

となる.

$$ K \geq 1 $$ のときは最低でも2の累乗のオーダーで増えていくので愚直に数えても間に合う.

$$ K = 0 $$ のときは $$ 1 $$ ずつ増えていくので $$ 2^{12}-A $$ が答えになる.
