---
title: "ARC #068 D"
problem: https://atcoder.jp/contests/abc053/tasks/arc068_b
---
まずは同じカードが3枚以上ある数値については, その同じカードを3枚選ぶことでそのうち2枚を食べることができる. この結果, 同じカードが偶数枚あれば2枚, 奇数枚あれば1枚残るようになる.

同じカードが2枚ある数値が2組ある場合は, どちらか2枚ともう片方1枚を選ぶことで, 2組の数値を1枚ずつ残すことができる.

同じカードが2枚ある数値が残った場合は, このカード2枚と別の1枚残っているカードを選ぶことで, 2枚あるカードの方の数値を残すことができる.
