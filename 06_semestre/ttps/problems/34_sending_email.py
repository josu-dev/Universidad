"""
[vjudge.net/problem/UVA-10986](https://vjudge.net/problem/UVA-10986)

“A new internet watchdog is creating a stir in
Springfield. Mr. X, if that is his real name, has
come up with a sensational scoop.”
Kent Brockman

There are n SMTP servers connected by network cables. Each of the m cables
connects two computers and has a certain latency measured in milliseconds
required to send an email message. What is the shortest time required to send a
message from server S to server T along a sequence of cables? Assume that there
is no delay incurred at any of the servers.

Input
The first line of input gives the number of cases, N. N test cases follow. Each
one starts with a line containing n (2 ≤ n ≤ 20000), m (0 ≤ m ≤ 50000), S (0 ≤ S
< n) and T (0 ≤ T < n). S ̸= T. The next m lines will each contain 3 integers: 2
different servers (in the range [0, n - 1]) that are connected by a
bidirectional cable and the latency, w, along this cable (0 ≤ w ≤ 10000).

Output
For each test case, output the line 'Case #x:' followed by the number of
milliseconds required to send a message from S to T. Print 'unreachable' if
there is no route from S to T.

Sample Input
3
2 1 0 1
0 1 100
3 3 2 0
0 1 100
0 2 200
1 2 50
2 0 0 1

Sample Output
Case #1: 100
Case #2: 150
Case #3: unreachable
**ENDS IN NEW LINE**
"""

import heapq
import sys


INF = float("inf")


def dijkstra(
    graph: "dict[int, dict[int, int]]", start: int
) -> "tuple[dict[int, int | float], dict[int, int | None]]":
    distances = {node: INF for node in graph}
    distances[start] = 0
    previous = {
        node: None for node in graph
    }  # type: dict[int, int | None] # type: ignore

    pq = [(0, start)]
    visited = set()  # type: set[int] # type: ignore

    while pq:
        curr_distance, curr_node = heapq.heappop(pq)

        if curr_node in visited:
            continue

        visited.add(curr_node)

        for neighbor, weight in graph[curr_node].items():
            distance = curr_distance + weight
            if distance >= distances[neighbor]:
                continue

            distances[neighbor] = distance
            previous[neighbor] = curr_node
            heapq.heappush(pq, (distance, neighbor))

    return distances, previous


lines = sys.stdin.read().split()
line_i = 1
cases = int(lines[0])
r = []  # type: list[str] # type: ignore
for case_i in range(cases):
    n = int(lines[line_i])
    m = int(lines[line_i + 1])
    s = int(lines[line_i + 2])
    t = int(lines[line_i + 3])
    line_i += 4

    g = {i: {} for i in range(n)}  # type: dict[int, dict[int, int]] # type: ignore
    for i in range(line_i, line_i + m * 3, 3):
        s1 = int(lines[i])
        s2 = int(lines[i + 1])
        w = int(lines[i + 2])

        g[s1][s2] = g[s2][s1] = w

    line_i += m * 3
    latencies, _ = dijkstra(g, s)

    latency_s_t = latencies[t]
    if latency_s_t is INF:
        r.append("Case #%d: unreachable\n" % (case_i + 1))
    else:
        r.append("Case #%d: %d\n" % (case_i + 1, latency_s_t))

sys.stdout.writelines(r)
