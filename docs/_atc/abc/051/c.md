---
title: "ABC #051 C"
problem: https://atcoder.jp/contests/abc051/tasks/abc051_c
---
次のようなルートが考えられる.

$$
\begin{align}
(sx, sy) &\rightarrow (sx, ty) \rightarrow (tx, ty) \rightarrow (tx, sy) \rightarrow (sx, sy) \\
         &\rightarrow (sx-1, sy) \rightarrow (sx-1, ty+1) \rightarrow (tx, ty+1) \rightarrow (tx, ty) \\
         &\rightarrow (tx+1, ty) \rightarrow (tx+1, sy-1) \rightarrow (sx, sy-1) \rightarrow (sx, sy)
\end{align}
$$
