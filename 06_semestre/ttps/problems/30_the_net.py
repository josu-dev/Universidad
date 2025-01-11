"""
[vjudge.net/problem/UVA-627](https://vjudge.net/problem/UVA-627)

Taking into account the present interest in the Internet, a smart information
routing becomes a must. This job is done by routers situated in the nodes of the
network. Each router has its own list of routers which are visible for him (so
called “routing table”). It is obvious that the information should be directed
in the way which minimizes number of routers it has to pass (so called “hop
count”).

Your task is to find an optimal route (minimal hop count) for the given network
form the source of the information to its destination.

Input
First line contains number of routers in the network (n). Next n lines contain
description of the network. Each line contains router ID, followed by a hyphen
and comma separated list of IDs of visible routers. The list is sorted in
ascending order.

Next line contains a number of routes (m) you should determine. The consecutive
m lines contain starting and ending routers for the route separated by a single
space.

Input data may contain descriptions of many networks.

Output
For each network you should output a line with 5 hyphens and then, for each
route, a list of routers passed by information sent from starting to destination
routers.

In case passing of information is impossible (no connection exists) you should
output a string 'connection impossible'. In case of multiple routes with the
same 'hop count' the one with lower IDs should be outputted (in case of route
form router 1 to 2 as '1 3 2' and '1 4 2' the '1 3 2' should be outputted).

Assumptions: A number of routers is not greater than 300 and there are at least
2 routers in the network. Each routers “sees” no more than 50 routers.

Sample Input
6
1-2,3,4
2-1,3
3-1,2,5,6
4-1,5
5-3,4,6
6-3,5
6
1 6
1 5
2 4
2 5
3 6
2 1
10
1-2
2-
3-4
4-8
5-1
6-2
7-3,9
8-10
9-5,6,7
10-8
3
9 10
5 9
9 2

Sample Output
-----
1 3 6
1 3 5
2 1 4
2 3 5
3 6
2 1
-----
9 7 3 4 8 10
connection impossible
9 6 2
**ENDS IN NEW LINE**
"""

import sys
import typing as t
from collections import deque


def bfs_min_path(
    graph: t.List[t.List[int]],
    v_start: int,
    v_end: int,
) -> t.List[int]:
    if v_end in graph[v_start]:
        return [v_start, v_end]

    queue = deque((v_start,))
    n = len(graph)
    visited = [False] * n
    visited[v_start] = True
    predecessors = t.cast(t.List[t.Union[None, int]], [None] * n)

    while queue:
        v = queue.popleft()

        for w in graph[v]:
            if not visited[w]:
                visited[w] = True
                predecessors[w] = v
                queue.append(w)

                if w == v_end:
                    break

    path = t.cast(t.List[int], [])
    current = v_end
    while current is not None:
        path.append(current)
        current = predecessors[current]

    path.reverse()
    return path if path[0] == v_start else []


lines = sys.stdin.read().splitlines()
size = len(lines)
line_i = 0
r = ""
while line_i < size:
    n = int(lines[line_i])
    line_i += 1

    adjs = t.cast(t.List[t.List[int]], [])
    for i in range(n):
        parts = lines[line_i + i].split("-")
        if len(parts) < 2 or parts[1] == "":
            adjs.append([])
            continue

        adjs.append([int(u) - 1 for u in parts[1].split(",") if u])

    line_i += n
    m = int(lines[line_i])

    r += "-----\n"
    for i in range(line_i + 1, line_i + 1 + m):
        parts = lines[i].split()
        path = bfs_min_path(adjs, int(parts[0]) - 1, int(parts[1]) - 1)
        if path:
            r += " ".join(str(v + 1) for v in path) + "\n"
        else:
            r += "connection impossible\n"

    line_i += m + 1

sys.stdout.write(r)
