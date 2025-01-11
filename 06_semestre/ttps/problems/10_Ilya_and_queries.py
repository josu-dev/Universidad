"""
[vjudge.net/problem/CodeForces-313B](https://vjudge.net/problem/CodeForces-313B)

Ilya the Lion wants to help all his friends with passing exams. They need to
 solve the following problem to pass the IT exam.

You've got string s = s1s2... sn (n is the length of the string), consisting
 only of characters "." and "#" and m queries. Each query is described by a pair
 of integers li, ri (1 ≤ li < ri ≤ n). The answer to the query li, ri is the
 number of such integers i (li ≤ i < ri), that si = si + 1.

Ilya the Lion wants to help his friends but is there anyone to help him? Help
 Ilya, solve the problem.

Input
The first line contains string s of length n (2 ≤ n ≤ 10^5). It is guaranteed
 that the given string only consists of characters "." and "#".

The next line contains integer m (1 ≤ m ≤ 10^5) — the number of queries. Each of
 the next m lines contains the description of the corresponding query. The i-th
 line contains integers li, ri (1 ≤ li < ri ≤ n).

Output
Print m integers — the answers to the queries in the order in which they are
 given in the input.

Examples
Input	Output
......
4
3 4     1
2 3     1
1 6     5
2 6     4

Input	Output
#..###
5
1 3     1
5 6     1
1 5     2
3 6     2
3 4     0
"""

import sys

pattern = sys.stdin.readline()
size = len(pattern) - 1
account = [0] * size
acc = 0
for i in range(size - 1, 0, -1):
    if pattern[i] == pattern[i - 1]:
        acc += 1

    account[i - 1] = acc

numbers = sys.stdin.read().split()
size = len(numbers) - 1
i = 1
res = ""
while i < size:
    li = int(numbers[i])
    ri = int(numbers[i + 1])
    r = account[li - 1] - account[ri - 1]
    res += f"{r}\n"
    i += 2

sys.stdout.write(res[:-1])
