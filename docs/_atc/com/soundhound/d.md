---
title: "SoundHound D"
problem: https://atcoder.jp/contests/soundhound2018-summer-qual/tasks/soundhound2018_summer_qual_d
---
都市 $$ c $$ で両替をするとすると, 使うお金は $$ s \rightarrow c $$ の円建てのお金と $$ c \rightarrow $$ のスヌーク建てのお金の合計である. これは円建てで $$ s $$ から各都市への最小コストとスヌーク建てで $$ t $$ から各都市への最小コストをそれぞれ Dijkstra 法で求めておけばいい.

都市ごとにその都市で両替をしたときの最小コストをすべて求め, 後ろから最小値の累積を計算していく.
