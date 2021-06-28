---
title: "ABC #144 D"
problem: https://atcoder.jp/contests/abc144/tasks/abc144_d
---
水筒を横から見て左に傾けることを考える. こうすることで面積 $$ y = x/a $$ を作るようにするための傾きを求める問題となる.

水面が水筒の縁と水筒の底面と側面の交点に来る位置より傾けられるか傾けられないかで場合分けする. $$ y \leq ab/2 $$ ならば傾けられて, そうでなければ傾けられない.

傾けられる場合, 水が底面に触れている部分の長さを $$ c $$ とすると,

$$
\begin{align}
y &= \frac{1}{2} bc \\
y &= \frac{1}{2} \sqrt{b^2 + c^2} \cdot b \cos \theta
\end{align}
$$

となるので, これを解いて,

$$
\cos \theta = \frac{2y}{b\sqrt{b^2 + \left(\frac{2y}{b}\right)^2}}
$$

となる. 傾けられない場合は水筒の水がない部分の面積を考える. これを $$ z = ab-y $$, 水が側面に触れていない部分の長さを $$ d $$ とすると,

$$
\begin{align}
z &= \frac{1}{2} ad \\
z &= \frac{1}{2} \sqrt{a^2 + d^2} \cdot a \sin \theta
\end{align}
$$

となるので, これを解いて,

$$
\sin \theta = \frac{2z}{a\sqrt{a^2 + \left(\frac{2z}{a}\right)^2}}
$$

となる.
