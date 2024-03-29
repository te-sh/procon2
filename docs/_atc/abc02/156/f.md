---
title: "ABC #156 F"
problem: https://atcoder.jp/contests/abc156/tasks/abc156_f
---
クエリごとに考える.

$$ a_j $$ は $$ \mod m_i $$ で考えるので, $$ x_i $$ および $$ d_j $$ はすべて $$ \mod m_i $$ しておく.

このとき, 直接

$$
(a_j \mod m_i) \lt (a_{j+1} \mod m_i)
$$

を考えるのではなく, その逆の

$$
(a_j \mod m_i) \geq (a_{j+1} \mod m_i)
$$

を考える. まず

$$
(a_j \mod m_i) \gt (a_{j+1} \mod m_i)
$$

を考える. これは, $$ a_j $$ と $$ a_{j+1} $$ の間で $$ km_i $$ のラインを飛び越えるとき ($$ a_{j+1} = km_i $$ のときも含む) である. $$ d_j $$ は $$ \mod m_i $$ してあるので, $$ a_j, a_{j+1} $$ の間で2本以上の $$ km_i $$ のラインを飛び越えることはなく, また $$ km_i $$ のラインを飛び越えるときはかならず

$$
(a_j \mod m_i) \gt (a_{j+1} \mod m_i)
$$

が成り立つ. よって,

$$
(a_j \mod m_i) \gt (a_{j+1} \mod m_i)
$$

が成り立つ個数は, $$ \floor{ a_{n_i-1} / m_i } $$ である.

$$ a_{n_i-1} $$ を求める問題であるが, $$ [0, n_i-1] $$ の中の $$ d_j $$ のサイクルの個数を $$ c = \floor{n_i}{k} $$ とすると,

$$
a_{n_i-1} = x_i + c\sum_{j=0}^{k-1} d_j + \sum_{j=0}^{(n_i \mod k) - 1} d_j
$$

となる.

次に

$$
(a_j \mod m_i) = (a_{j+1} \mod m_i)
$$

であるが, これは $$ d_j = 0 $$ のときのみである. よって $$ d_i $$ のサイクル中の $$ d_i = 0 $$ の個数 $$ z $$ を数え, あまりの部分を別途計算する.
