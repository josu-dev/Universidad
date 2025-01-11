"""
[vjudge.net/problem/UVA-10803](https://vjudge.net/problem/UVA-10803)

“I mean, some people got guns, and some
people got flashlights, and some people got
batteries. These guys had all three.”
J. Michael Straczynski, "Jeremiah."

Markus is building an army to fight the evil Valhalla Sector, so he needs to
move some supplies between several of the nearby towns. The woods are full of
robbers and other unfriendly folk, so it's dangerous to travel far. As Thunder
Mountain's head of security, Lee thinks that it is unsafe to carry supplies for
more than 10km without visiting a town. Markus wants to know how far one would
need to travel to get from one town to another in the worst case.

Input
The first line of input gives the number of cases, N. N test cases follow. Each
one starts with a line containing n (the number of towns, 1 < n < 101). The next
n lines will give the xy-locations of each town in km (integers in the range [0,
1023]). Assume that the Earth is flat and the whole 1024 x 1024 grid is covered
by a forest with roads connecting each pair of towns that are no further than
10km away from each other.

Output
For each test case, output the line 'Case #x:', where x is the number of the
test case. On the next line, print the maximum distance one has to travel from
town A to town B (for some A and B). Round the answer to 4 decimal places. Every
answer will obey the formula |ans * 10^4 - ⌊ ans * 10^4 ⌋ - 0.5| > 10^-2

If it is impossible to get from some town to some other town, print 'Send Kurdy'
instead. Put an empty line after each test case.

Sample Input
2
5
0 0
10 0
10 10
13 10
13 14
2
0 0
10 1

Sample Output
Case #1:
25.0000

Case #2:
Send Kurdy
"""

import heapq
import math
import sys


INF = float("inf")


def dijkstra(graph: "list[list[tuple[int, float]]]", start: int) -> "list[float]":
    n = len(graph)
    dist = [INF] * n
    dist[start] = 0
    pq = [(0, start)]  # type: list[tuple[float, int]] # type: ignore
    while pq:
        d, u = heapq.heappop(pq)
        if d > dist[u]:
            continue

        for v, weight in graph[u]:
            if dist[u] + weight < dist[v]:
                dist[v] = dist[u] + weight
                heapq.heappush(pq, (dist[v], v))

    return dist


def max_distance_between_towns(n: int, towns: "list[tuple[int, int]]") -> "float | None":
    adjs = [[] for _ in range(n)]  # type: list[list[tuple[int, float]]] # type: ignore
    for i in range(n):
        fx, fy = towns[i]
        for j in range(i + 1, n):
            tx, ty = towns[j]
            d = math.sqrt((fx - tx) ** 2 + (fy - ty) ** 2)
            if d <= 10:
                adjs[i].append((j, d))
                adjs[j].append((i, d))

    max_dist = 0
    for i in range(n):
        dist = max(dijkstra(adjs, i))
        if dist == INF:
            return None

        if dist > max_dist:
            max_dist = dist

    return max_dist


lines = sys.stdin.read().split()
line_i = 1
cases = int(lines[0])

r = []  # type: list[str] # type: ignore
for case_i in range(cases):
    n = int(lines[line_i])
    line_i += 1

    cities = [
        (int(lines[i]), int(lines[i + 1])) for i in range(line_i, line_i + n * 2, 2)
    ]
    line_i += n * 2

    distance = max_distance_between_towns(n, cities)
    if distance is None:
        r.append("Case #%d:\nSend Kurdy\n\n" % (case_i + 1))
        continue

    r.append("Case #%d:\n%.4f\n\n" % (case_i + 1, distance))

sys.stdout.writelines(r)
