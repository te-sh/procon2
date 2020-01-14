import algorithm, bitops, sequtils, sugar

proc bsearch[T](min, max: T, cmp: proc(x: T): bool): T =
  var
    tmin = min
    tmax = max
  while tmax-tmin > 1:
    var mid = (tmin+tmax) div 2
    if cmp(mid):
      tmin = mid
    else:
      tmax = mid
  if cmp(tmax): tmax elif cmp(tmin): tmin else: tmin-1

proc nsqrt[T](n: T): T =
  if n <= 1: return n
  var m = T(1) shl (n.fastLog2 div 2 + 1)
  bsearch(T(1), m, (x) => x*x <= n)

proc primes(n: int): seq[int] =
  var sieve = newSeqWith((n+1) div 2, true)
  for p in 1..((n.nsqrt-1) div 2):
    if sieve[p]:
      for q in countup(p*3+1, (n+1) div 2, p*2+1):
        sieve[q] = false
  result = newSeq[int](0)
  for p, b in sieve:
    if b: result.add(p*2+1)
  result[0] = 2
