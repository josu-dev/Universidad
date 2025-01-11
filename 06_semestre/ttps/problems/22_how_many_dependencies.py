"""
[vjudge.net/problem/UVA-10926](https://vjudge.net/problem/UVA-10926)

In this problem you will need to find out which task has the most number of
 dependencies. A task A depends on another task B if B is a direct or indirect
 dependency of A.
For example, if A depends on B and B depends on C, then A has two dependencies,
 one direct and one indirect.
You can assume there will be no cyclic dependencies in the input.

Input
The input consists of a set of scenarios. Each scenario begins with one integer
 N, 0 < N ≤ 100, in a line indicating how many tasks this scenario contains.
 Then there will be N lines, one for each task. Each line will contain an
 integer 0 ≤ T ≤ N - 1, the number of direct dependencies of that task, plus T
 integers, the identifiers of that dependencies. Tasks are numbered from 1 to N.
The input ends with a scenario where N = 0.

Output
For each scenario, print the number of the task with the greatest number of
 dependencies alone in a line. If there are ties, show the task with the lowest
 identifier.

Sample Input
3
1 2
1 3
0
4
2 2 4
0
2 2 4
0
0

Sample Output
1
1
**ENDS NEW LINE**
"""

import sys
import typing as t


def dfs_size(g: t.Sequence[t.Sequence[int]], v: int) -> int:
    stack = [v]
    visited = [False] * len(g)
    visited[v] = True
    count = 0

    while stack:
        current_node = stack.pop()
        count += 1

        for neighbor in g[current_node]:
            if not visited[neighbor]:
                visited[neighbor] = True
                stack.append(neighbor)

    return count


lines = sys.stdin.read().split()
line_i = 1
line = lines[0]
r = ""
while line != "0":
    tasks = int(line)
    g = t.cast(t.List[t.Tuple[int, ...]], [None] * tasks)

    for ti in range(tasks):
        deps = int(lines[line_i])
        line_i += 1
        g[ti] = tuple(int(lines[line_i + d]) - 1 for d in range(deps))
        line_i += deps

    most_deps_i = 0
    most_deps = 0
    for ti in range(tasks):
        tmp = dfs_size(g, ti)
        if tmp > most_deps:
            most_deps = tmp
            most_deps_i = ti

    r += str(most_deps_i + 1) + "\n"
    line = lines[line_i]
    line_i += 1

sys.stdout.write(r)
