---
title: "Div.3 #479 F"
problem: http://codeforces.com/contest/977/problem/F
---
$$ a_i $$ を最初から見ていき, $$ a_i $$ で終わる最長の部分列の長さを保持する.

最長の部分列の長さの最大値とそのときの $$ a_i $$ が求まれば, 部分列の最初の数値が分かるので, 再び $$ a_i $$ を最初から見ていき, 最初の数値が見つかればそのインデックスを出力して, 次の数値を探していく.