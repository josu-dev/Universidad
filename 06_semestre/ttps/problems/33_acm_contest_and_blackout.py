"""
[vjudge.net/problem/UVA-10600](https://vjudge.net/problem/UVA-10600)

In order to prepare the “The First National ACM School Contest” (in 20??) the
major of the city decided to provide all the schools with a reliable source of
power. (The major is really afraid of blackoutsJ). So, in order to do that,
power station “Future” and one school (doesn't matter which one) must be
connected; in addition, some schools must be connected as well.

You may assume that a school has a reliable source of power if it's connected
directly to “Future”, or to any other school that has a reliable source of
power. You are given the cost of connection between some schools. The major has
decided to pick out two the cheapest connection plans - the cost of the
connection is equal to the sum of the connections between the schools. Your task
is to help the major — find the cost of the two cheapest connection plans.

Input
The Input starts with the number of test cases, T (1 < T < 15) on a line. Then T
test cases follow. The first line of every test case contains two numbers, which
are separated by a space, N (3 < N < 100) the number of schools in the city, and
M the number of possible connections among them. Next M lines contain three
numbers Ai, Bi, Ci, where Ci is the cost of the connection (1 < Ci < 300)
between schools Ai and Bi. The schools are numbered with integers in the range 1
to N.

Output
For every test case print only one line of output. This line should contain two
numbers separated by a single space - the cost of two the cheapest connection
plans. Let S1 be the cheapest cost and S2 the next cheapest cost. It's
important, that S1 = S2 if and only if there are two cheapest plans, otherwise
S1 < S2. You can assume that it is always possible to find the costs S1 and S2.

Sample Input
2
5 8
1 3 75
3 4 51
2 4 19
3 2 95
2 5 42
5 4 31
1 2 9
3 5 66
9 14
1 2 4
1 8 8
2 8 11
3 2 8
8 9 7
8 7 1
7 9 6
9 3 2
3 4 7
3 6 4
7 6 2
4 6 14
4 5 9
5 6 10

Sample Output
110 121
37 37
**ENDS IN NEW LINE**
"""

import sys


class UFDS:
    def __init__(self, size: int = 0):
        self.p = [i for i in range(size)]
        self.rank = [0] * size

    def find_set(self, i: int) -> int:
        parent = self.p[i]
        if i == parent:
            return i

        parent = self.p[i] = self.find_set(parent)
        return parent

    def union_set(self, i: int, j: int) -> bool:
        x = self.find_set(i)
        y = self.find_set(j)
        if x == y:
            return False

        if self.rank[x] > self.rank[y]:
            self.p[y] = x
            return True

        self.p[x] = y
        if self.rank[x] == self.rank[y]:
            self.rank[y] = y + 1
        return True

    def reset(self, size: "int | None" = None) -> None:
        size = size if size else len(self.p)
        self.p = [i for i in range(size)]
        self.rank = [0] * size
        self.sizes = [1] * size


def kruskal_wit_cost(
    n: int, edges: "list[tuple[int, int, int]]"
) -> "tuple[list[tuple[int, int, int]], int]":
    uf = UFDS(n)
    mst = []  # type: list[tuple[int, int, int]] # type: ignore
    total_cost = 0

    for u, v, cost in edges:
        if uf.union_set(u, v):
            mst.append((u, v, cost))
            total_cost += cost

    return mst, total_cost


def find_second_mst(
    n: int, edges: "list[tuple[int, int, int]]", mst: "list[tuple[int, int, int]]"
) -> int:
    uf = UFDS()
    min_cost = 2**31

    for skip_edge in mst:
        uf.reset(n)
        second_mst_size = 0
        total_cost = 0
        skip_u, skip_v, _ = skip_edge

        for u, v, cost in edges:
            if (u == skip_u and v == skip_v) or (u == skip_v and v == skip_u):
                continue

            if uf.union_set(u, v):
                second_mst_size += 1
                total_cost += cost

        if second_mst_size == n - 1 and total_cost < min_cost:
            min_cost = total_cost

    return min_cost


lines = sys.stdin.read().split()
line_i = 1
cases = int(lines[0])
r = []  # type: list[str] # type: ignore
for _ in range(cases):
    n = int(lines[line_i])
    m = int(lines[line_i + 1])
    line_i += 2

    edges = [
        (int(lines[i]) - 1, int(lines[i + 1]) - 1, int(lines[i + 2]))
        for i in range(line_i, line_i + m * 3, 3)
    ]
    line_i += m * 3

    edges.sort(key=lambda x: x[2])
    mst, min_cost_1 = kruskal_wit_cost(n, edges)
    min_cost_2 = find_second_mst(n, edges, mst)

    r.append("%d %d\n" % (min_cost_1, min_cost_2))

sys.stdout.writelines(r)
