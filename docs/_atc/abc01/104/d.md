---
title: "ABC #104 D"
problem: https://atcoder.jp/contests/abc104/tasks/abc104_d
---
ABC 数と同様に A 数, AB 数を考える.

$$ i $$ 文字目まで見たときの A 数, AB 数, ABC 数をそれぞれ $$ A(i), B(i), C(i) $$ とする.

このとき, 以下のようになる.

$$ i $$ 文字目が `A` のとき:

$$
\begin{align}
A(i) &= A(i-1)+3^q \\
B(i) &= B(i-1) \\
C(i) &= C(i-1)
\end{align}
$$

ここで $$ q $$ は今までに現れた `?` の数である. `?` で枝分かれした木を考えると, すべての葉に `A` を追加することになるので, $$ 3^q $$ を追加することになる.

$$ i $$ 文字目が `B` のとき:

$$
\begin{align}
A(i) &= A(i-1) \\
B(i) &= B(i-1)+A(i-1) \\
C(i) &= C(i-1)
\end{align}
$$

$$ i $$ 文字目が `C` のとき:

$$
\begin{align}
A(i) &= A(i-1) \\
B(i) &= B(i-1) \\
C(i) &= C(i-1)+B(i-1)
\end{align}
$$

$$ i $$ 文字目が `?` のとき:

$$
\begin{align}
A(i) &= 3A(i-1)+3^q \\
B(i) &= 3B(i-1)+A(i-1) \\
C(i) &= 3C(i-1)+B(i-1)
\end{align}
$$

各式の係数 $$ 3 $$ は枝分かれによって増える分を考慮している.

これを DP で計算して $$ C(\vert S \vert) $$ を求める.
