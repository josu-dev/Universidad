"""
[vjudge.net/problem/UVA-10048](https://vjudge.net/problem/UVA-10048)

Consider yourself lucky! Consider yourself lucky to be still breathing and
having fun participating in this contest. But we apprehend that many of your
descendants may not have this luxury. For, as you know, we are the dwellers of
one of the most polluted cities on earth. Pollution is everywhere, both in the
environment and in society and our lack of consciousness is simply aggravating
the situation.

However, for the time being, we will consider only one type of pollution - the
sound pollution. The loudness or intensity level of sound is usually measured in
decibels and sound having intensity level 130 decibels or higher is considered
painful. The intensity level of normal conversation is 6065 decibels and that of
heavy traffic is 7080 decibels.

Consider the following city map where the edges refer to streets and the nodes
refer to crossings. The integer on each edge is the average intensity level of
sound (in decibels) in the corresponding street.

To get from crossing A to crossing G you may follow the following path: A-C-F-G.
In that case you must be capable of tolerating sound intensity as high as 140
decibels. For the paths A-B-E-G, A-B-D-G and A-C-F-D-G you must tolerate
respectively 90, 120 and 80 decibels of sound intensity. There are other paths,
too. However, it is clear that A-C-F-D-G is the most comfortable path since it
does not demand you to tolerate more than 80 decibels.

In this problem, given a city map you are required to determine the minimum
sound intensity level you must be able to tolerate in order to get from a given
crossing to another.

Input
The input may contain multiple test cases.

The first line of each test case contains three integers C(≤ 100), S(≤ 1000) and
Q(≤ 10000) where C indicates the number of crossings (crossings are numbered
using distinct integers ranging from 1 to C), S represents the number of streets
and Q is the number of queries.

Each of the next S lines contains three integers: c1, c2 and d indicating that
the average sound intensity level on the street connecting the crossings c1 and
c2 (c1 ̸= c2) is d decibels.

Each of the next Q lines contains two integers c1 and c2 (c1 ̸= c2) asking for
the minimum sound intensity level you must be able to tolerate in order to get
from crossing c1 to crossing c2.

The input will terminate with three zeros form C, S and Q.

Output
For each test case in the input first output the test case number (starting from
1) as shown in the sample output. Then for each query in the input print a line
giving the minimum sound intensity level (in decibels) you must be able to
tolerate in order to get from the first to the second crossing in the query. If
there exists no path between them just print the line “no path”.

Print a blank line between two consecutive test cases.

Sample Input
7 9 3
1 2 50
1 3 60
2 4 120
2 5 90
3 6 50
4 6 80
4 7 70
5 7 40
6 7 140
1 7
2 6
6 2
7 6 3
1 2 50
1 3 60
2 4 120
3 6 50
4 6 80
5 7 40
7 5
1 7
2 4
0 0 0

Sample Output
Case #1
80
60
60

Case #2
40
no path
80
**ENDS IN NEW LINE**
"""

import sys
import typing as t


class UFDS:
    def __init__(self, size: int = 0):
        self.p = [i for i in range(size)]
        self.rank = [0] * size

    def find_set(self, i: int) -> int:
        if self.p[i] != i:
            self.p[i] = self.find_set(self.p[i])

        return self.p[i]

    def union_set(self, root_x: int, root_y: int) -> None:
        if self.rank[root_x] > self.rank[root_y]:
            self.p[root_y] = root_x
            return

        if self.rank[root_x] < self.rank[root_y]:
            self.p[root_x] = root_y
            return

        self.p[root_y] = root_x
        self.rank[root_x] += 1

    def reset(self, size: int) -> None:
        self.p = [i for i in range(size)]
        self.rank = [0] * size


def max_edge_in_path(
    adj: t.List[t.List[t.Tuple[int, int]]], start: int, end: int
) -> t.Union[int, None]:
    def dfs(
        node: int, target: int, visited: t.List[bool], max_edge: int
    ) -> t.Union[int, None]:
        if node == target:
            return max_edge

        visited[node] = True
        for neighbor, weight in adj[node]:
            if not visited[neighbor]:
                result = dfs(neighbor, target, visited, max(max_edge, weight))
                if result is not None:
                    return result
        return None

    visited = [False] * len(adj)
    return dfs(start, end, visited, -1)


lines = sys.stdin.read().splitlines()
case = 0
line_i = 0
ufds = UFDS()
r = ""
while True:
    c, s, q = map(int, lines[line_i].split())
    if c == 0 and s == 0 and q == 0:
        break

    case += 1
    line_i += 1

    edges = t.cast(t.List[t.Tuple[int, int, int]], [])
    for i in range(s):
        c1, c2, d = map(int, lines[i + line_i].split())
        edges.append((d, c1 - 1, c2 - 1))

    line_i += s
    edges.sort()
    ufds.reset(c)
    adj = t.cast(t.List[t.List[t.Tuple[int, int]]], [[] for _ in range(c)])
    for weight, u, v in edges:
        root_v = ufds.find_set(v)
        root_u = ufds.find_set(u)
        if root_u == root_v:
            continue

        ufds.union_set(root_v, root_u)
        adj[u].append((v, weight))
        adj[v].append((u, weight))

    r += "Case #" + str(case) + "\n"

    for i in range(q):
        parts = lines[line_i + i].split()
        max_weight = max_edge_in_path(adj, int(parts[0]) - 1, int(parts[1]) - 1)
        if max_weight == -1 or max_weight is None:
            r += "no path\n"
        else:
            r += str(max_weight) + "\n"

    line_i += q
    r += "\n"

sys.stdout.write(r[:-1])
