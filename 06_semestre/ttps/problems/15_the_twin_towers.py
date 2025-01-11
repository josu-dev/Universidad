"""
[vjudge.net/problem/UVA-10066](https://vjudge.net/problem/UVA-10066)

Once upon a time, in an ancient Empire, there were two towers of dissimilar
 shapes in two different cities. The towers were built by putting circular tiles
 one upon another. Each of the tiles was of the same height and had integral
 radius. It is no wonder that though the two towers were of dissimilar shape,
 they had many tiles in common.
However, more than thousand years after they were built, the Emperor ordered his
 architects to remove some of the tiles from the two towers so that they have
 exactly the same shape and size, and at the same time remain as high as
 possible. The order of the tiles in the new towers must remain the same as they
 were in the original towers. The Emperor thought that, in this way the two
 towers might be able to stand as the symbol of harmony and equality between the
 two cities. He decided to name them the Twin Towers.
Now, about two thousand years later, you are challenged with an even simpler
 problem: given the descriptions of two dissimilar towers you are asked only to
 find out the number of tiles in the highest twin towers that can be built from
 them.

Input
The input file consists of several data blocks. Each data block describes a pair
 of towers. The first line of a data block contains two integers N1 and N2 (1 ≤
 N1, N2 ≤ 100) indicating the number of tiles respectively in the two towers.
 The next line contains N1 positive integers giving the radii of the tiles (from
 top to bottom) in the first tower. Then follows another line containing N2
 integers giving the radii of the tiles (from top to bottom) in the second
 tower. The input file terminates with two zeros for N1 and N2.

Output
For each pair of towers in the input first output the twin tower number followed
 by the number of tiles (in one tower) in the highest possible twin towers that
 can be built from them. Print a blank line after the output of each data set.

Sample Input
7 6
20 15 10 15 25 20 15
15 25 10 20 15 20
8 9
10 20 20 10 20 10 20 10
20 10 20 10 10 20 10 10 20
0 0

Sample Output
Twin Towers #1
Number of Tiles : 4

Twin Towers #2
Number of Tiles : 6

**ENDS IN 2 NEW LINE**
"""

import sys
import typing as t


def lcs_length(seq1: t.Sequence[t.Any], seq2: t.Sequence[t.Any]) -> int:
    m = len(seq1)
    n = len(seq2)
    cache = list(0 for _ in range((m + 1) * (n + 1)))
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if seq1[i - 1] == seq2[j - 1]:
                cache[i * (n + 1) + j] = cache[(i - 1) * (n + 1) + (j - 1)] + 1
            else:
                cache[i * (n + 1) + j] = max(
                    cache[i * (n + 1) + (j - 1)], cache[(i - 1) * (n + 1) + j]
                )

    return cache[m * (n + 1) + n]


lines = sys.stdin.read().split(sep="\n")
i = 0
sentinel = lines[i]
r = ""
while sentinel != "0 0":
    seq1 = tuple(int(r) for r in lines[i + 1].split())
    seq2 = tuple(int(r) for r in lines[i + 2].split())
    k = lcs_length(seq1, seq2)
    r += "Twin Towers #" + str(i // 3 + 1) + "\nNumber of Tiles : " + str(k) + "\n\n"
    i += 3
    sentinel = lines[i]

sys.stdout.write(r)
