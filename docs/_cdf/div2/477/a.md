---
title: "Div.2 #477 A"
problem: http://codeforces.com/contest/967/problem/A
---
時刻は分に変換しておく.

$$ m_1 \geq s+1 $$ のときは0時0分が一番早い.

$$ m_{i+1} - m_{i} \geq 2s+2 $$ のときは $$ m_i+s+1 $$ に離陸させられる.

それ以外のときは $$ m_N+s+1 $$ に離陸させられる.
