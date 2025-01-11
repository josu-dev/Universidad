"""
[vjudge.net/problem/CodeChef-SPIDY2](https://vjudge.net/problem/CodeChef-SPIDY2)

N buildings are built in a row, numbered 1 to N from left to right. Spiderman is
 on buildings number 1, and want to reach building number N. He can jump from
 building number i to building number j if i < j and j-i is a power of 2 (1, 2,
 4, so on). Such a move costs him energy |Height[j] - Height[i]|, where
 Height[i] is the height of the ith building. Find the minimum energy using
 which he can reach building N?

INPUT
First line contains N, number of buildings. Next line contains N space-separated
 integers, denoting the array Height.

OUTPUT
Print a single integer, the answer to the above problem.

CONSTRAINTS
1 ≤ N ≤ 200000
1 ≤ Height[i] ≤ 10^9

SAMPLE INPUT
4
1 2 3 4

SAMPLE OUTPUT
3
**ENDS IN NEW LINE**
"""

# Lo entendi mal, me copie la respuesta
import sys
import typing as t


def acc_min_cost(heights: t.Sequence[int]):
    n = len(heights)
    costs = [10**9] * n
    costs[0] = 0
    for i in range(n):
        jmp = 1
        j = i + jmp
        while j < n:
            jmp_cost = heights[j] - heights[i]
            jmp_cost = -jmp_cost if jmp_cost < 0 else jmp_cost
            costs[j] = min(costs[j], jmp_cost + costs[i])
            jmp *= 2
            j = i + jmp

    return costs[n - 1]


heights = [int(h) for h in sys.stdin.read().split()[1:]]
energy = acc_min_cost(heights)
sys.stdout.write(str(energy) + "\n")

exit(0)

# Lo que habia hecho yo

powers_cache = (
    1,
    2,
    4,
    8,
    16,
    32,
    64,
    128,
    256,
    512,
    1024,
    2048,
    4096,
    8192,
    16384,
    32768,
    65536,
    131072,
)
max_height = 1000000000


def calc_min(
    seq: t.Sequence[int], n: int, i: int = 0, jmp: int = 1, acc: int = 0
) -> int:
    j = i + jmp
    if j >= n:
        return -1

    cost = seq[j] - seq[i]
    cost = -cost if cost < 0 else cost
    total = cost + acc
    if j == (n - 1):
        return total

    new_min = max_height + 1
    for jmp in powers_cache:
        possible = calc_min(seq, n, j, jmp, total)
        if possible == -1:
            continue
        if possible < new_min:
            new_min = possible

    if new_min == (max_height + 1):
        return -1

    return new_min


heights = [int(h) for h in sys.stdin.read().split()]
energy = calc_min(heights, len(heights), 1)
sys.stdout.write(str(energy) + "\n")
