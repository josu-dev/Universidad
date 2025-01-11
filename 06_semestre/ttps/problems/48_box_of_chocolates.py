"""
[vjudge.net/problem/UVA-10489](https://vjudge.net/problem/UVA-10489)

Little Pippy has got a lot of chocolates on her 6-th birthday. She is a very
good and charming girl and always shares his belongings with her friends (and
she has lots of friends). Now she wants to share all the chocolate with her
friends. She will try her best to give all her friend equal number of chocolates
but in case she fails, she will give her pet cat Kittu the residue number of
chocolates. The chocolates she has got are in boxes wrapped with beautiful
papers. Sometimes a box do not contain chocolates but have smaller boxes inside
them. Even sometimes the smaller boxes do not contain any chocolates but have
further smaller boxes inside them. Only the smallest boxes always contain some
chocolates.

Input
Input will start with an integer T. Following lines will contain descriptions
for T test cases. First line of each test case will contain two integers N and B
indicating the number of friends Pippy has and the number of box of chocolates
she has got respectively. Each of the next B lines will contain a description of
a single box. These lines will start with an integer K followed by K integers
identified as a1, a2, a3, ..., ak. Here ai indicates the number of boxes the
i-th box contains within it where (0 < i < K). The last number of the line
indicates the number of chocolates contained in each of the smallest box. All
the numbers will be positive and T, B, K will be less than 101 and N, ai will be
less than 10001.

Output
For each test case, print an integer on a single line indicating the number of
extra chocolates Kittu will get after dividing all of them equally among Pippy's
friends.

Sample Input
2
5 2
3 2 3 4
4 5 2 3 1
6 1
4 5 6 7 8

Sample Output
4
0
**ENDS IN NEW LINE**
"""

import sys
import typing as t


words = sys.stdin.read().split()
word_i = 1
cases = int(words[0])

r = t.cast("list[str]", [])
for _ in range(cases):
    n = int(words[word_i])
    b = int(words[word_i + 1])
    word_i += 2

    chocolates = 0
    for i in range(b):
        k = int(words[word_i])

        boxes = 1
        for ki in range(k - 1):
            boxes *= int(words[word_i + 1 + ki])
        chocolates += boxes * int(words[word_i + k])

        word_i += k + 1

    r.append("%d\n" % (chocolates % n))

sys.stdout.writelines(r)
