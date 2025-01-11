"""
[vjudge.net/problem/UVA-270](https://vjudge.net/problem/UVA-270)
https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&category=4&page=show_problem&problem=206

“How am I ever going to solve this problem?” said the pilot.

Indeed, the pilot was not facing an easy task. She had to drop packages at
specific points scattered in a dangerous area. Furthermore, the pilot could only
fly over the area once in a straight line, and she had to fly over as many
points as possible. All points were given by means of integer coordinates in a
two-dimensional space. The pilot wanted to know the largest number of points
from the given set that all lie on one line. Can you write a program that
calculates this number?

Your program has to be efficient!

Input
The input begins with a single positive integer on a line by itself indicating
the number of the cases following, each of them as described below. This line is
followed by a blank line, and there is also a blank line between two consecutive
inputs.

The input consists of N pairs of integers, where 1 < N < 700. Each pair of
integers is separated by one blank and ended by a new-line character. The list
of pairs is ended with an end-of-file character. No pair will occur twice.

Output
For each test case, the output must follow the description below. The outputs of
two consecutive cases will be separated by a blank line.

The output consists of one integer representing the largest number of points
that all lie on one line.

Sample Input
1

1 1
2 2
3 3
9 10
10 11

Sample Output
3
**ENDS IN NEW LINE**
"""

import sys
import typing as t


def max_points_in_a_line(points: t.Sequence[t.Tuple[float, ...]]) -> int:
    """
    https://www.youtube.com/watch?v=Bb9lOXUOnFw
    """
    n = len(points)
    if n < 3:
        return n

    count = 1
    slopes = t.cast("dict[float,int]", {})
    i = 0
    while (count + 2) < (n - i):
        slopes.clear()
        ax, ay = points[i]
        for j in range(i + 1, n):
            bx, by = points[j]
            slope = 1e100 if ax == bx else (by - ay) / (bx - ax)
            slopes[slope] = crr = slopes.get(slope, 0) + 1
            count = count if count >= (crr + 1) else crr + 1

        i += 1

    return count


lines = sys.stdin.read().splitlines()
line_i = 1
size = len(lines)
cases = int(lines[0])

r = ""
for _ in range(cases):
    points = t.cast("list[tuple[float,...]]", [])
    line_i += 1
    while line_i < size:
        line = lines[line_i]
        if line:
            points.append((*(int(coord) for coord in line.split()),))
            line_i += 1
            continue

        break

    count = max_points_in_a_line(points)
    r += "%d\n\n" % count

sys.stdout.write(r[:-1])


# def no_funciona_max_points_in_a_line(points: t.List[t.Tuple[float, ...]]) -> int:
#     n = len(points)
#     if n < 3:
#         return n

#     count = 0
#     m = [1e100] * (n)
#     for i in range(n):
#         if (count + 2) > (n - i):
#             break

#         cx, cy = points[i]
#         for j in range(i + 1, n):
#             if cx != points[j][0]:
#                 m[j] = (cy - points[j][1]) / (cx - points[j][0])
#             else:
#                 m[j] = 1e100

#         m.sort()
#         ta = 0
#         for j in range(i + 1, n):
#             diff = m[j] - m[j - 1]
#             if (-diff if diff < 0 else diff) == 0.0:
#                 ta += 1
#             else:
#                 if ta > count:
#                     count = ta
#                 ta = 0

#         if ta > count:
#             count = ta

#     return count + 2
