"""
[vjudge.net/problem/UVA-10139](https://vjudge.net/problem/UVA-10139)
https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1080

The factorial function, n! is defined thus for n a non-negative integer:

    0! = 1
    n! = n x (n - 1)! (n > 0)

We say that a divides b if there exists an integer k such that

    k x a = b

Input
The input to your program consists of several lines, each containing two
non-negative integers, n and m, both less than 2^31.

Output
For each input line, output a line stating whether or not m divides n!, in the
format shown below.

Sample Input
6 9
6 27
20 10000
20 100000
1000 1009

Sample Output
9 divides 6!
27 does not divide 6!
10000 divides 20!
100000 does not divide 20!
1009 does not divide 1000!
**ENDS IN NEW LINE**
"""

import sys
import typing as t


def prime_factors(n: int) -> "dict[int,int]":
    factors = t.cast("dict[int,int]", {})
    i = 2
    while i * i <= n:
        if not n % i:
            factors[i] = factors.get(i, 0) + 1
            n //= i
        else:
            i += 1

    factors[n] = factors.get(n, 0) + 1
    return factors


def polignac(num: int, p: int):
    """
    modified from https://code.activestate.com/recipes/578632-de-polignacs-formula/

    mathematic formula https://es.wikipedia.org/wiki/F%C3%B3rmula_de_De_Polignac
    """
    if num > 1 and p == 1:
        raise ValueError("p cant be the identity (1)")

    total = 0
    while num > 1:
        num = num // p
        total += num

    return total


lines = sys.stdin.read().split()
line_i = 0
size = len(lines)
r = t.cast("list[str]", [])

while line_i < size:
    n_fac = int(lines[line_i])
    n_div = int(lines[line_i + 1])
    line_i += 2

    if n_div <= n_fac or n_div < 2:
        r.append("%s divides %s!\n" % (n_div, n_fac))
        continue

    for k, v in prime_factors(n_div).items():
        if v > polignac(n_fac, k):
            r.append("%s does not divide %s!\n" % (n_div, n_fac))
            break
    else:
        r.append("%s divides %s!\n" % (n_div, n_fac))

sys.stdout.writelines(r)
