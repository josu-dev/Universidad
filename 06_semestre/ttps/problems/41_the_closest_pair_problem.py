"""
[judge.beecrowd.com/en/problems/view/1295](
    https://judge.beecrowd.com/en/problems/view/1295
)

Given a set of points in a two dimensional space, you will have to find the
distance between the closest two points.

Input
The input file contains several sets of input. Each set of input starts with an
integer N (0 ≤ N ≤ 10000), which denotes the number of points in this set. The
next N lines contain the coordinates of N two-dimensional points. The first of
the two numbers denotes the X-coordinate and the latter denotes the
Y-coordinate. The input is terminated by a set whose N = 0. This set should not
be processed. The value of the coordinates will be less than 40000 and
non-negative.

Output
For each set of input produce a single line of output containing a floating
point number (with four digits after the decimal point) which denotes the
distance between the closest two points. If there is no such two points in the
input whose distance is less than 10000, print the line INFINITY.

Sample Input
3
0 0
10000 10000
20000 20000
5
0 2
6 67
43 71
39 107
189 140
0

Sample Output
INFINITY
36.2215
**ENDS IN NEW LINE**
"""

import math
import sys
import typing as t


def closest_pair_distance(
    Px: t.Sequence[t.Tuple[float, float]], Py: t.Sequence[t.Tuple[float, float]]
) -> float:
    """
    By ChatGPT based on https://www.cs.cmu.edu/~ckingsf/bioinfo-lectures/closepoints.pdf
    """
    px_len = len(Px)
    if px_len < 3:
        if px_len < 2:
            return DISTANCE_TRESHOLD**2
        (ax, ay), (bx, by) = Px
        return (ax - bx) ** 2 + (ay - by) ** 2

    # Divide: split points into two halves
    mid = px_len // 2
    Lx, Rx = Px[:mid], Px[mid:]
    Ly = t.cast("list[tuple[float,float]]", [])
    Ry = t.cast("list[tuple[float,float]]", [])

    # Divide points in Py based on the split in Px
    midpoint = Px[mid][0]
    for point in Py:
        if point[0] < midpoint:
            Ly.append(point)
        else:
            Ry.append(point)

    # Recursive calls for both halves
    d1 = closest_pair_distance(Lx, Ly)
    d2 = closest_pair_distance(Rx, Ry)
    d = d1 if d1 < d2 else d2

    # Merge step: check points near the midpoint for closer pairs
    Sy = [p for p in Py if abs(p[0] - midpoint) < d]

    # Check points within Sy within distance `d`
    Sy_len = len(Sy)
    for i in range(Sy_len):
        x, y = Sy[i]
        for j in range(i + 1, min(i + 16, Sy_len)):
            cx, cy = Sy[j]
            temp = (x - cx) ** 2 + (y - cy) ** 2
            d = d if d < temp else temp

    return d


DISTANCE_TRESHOLD = 10000
lines = sys.stdin.read().split()
line_i = 0
size = len(lines)
r = ""
while line_i < size:
    cases2 = int(lines[line_i]) * 2
    if cases2 == 0:
        break

    points_by_x = sorted(
        (
            (float(lines[i]), float(lines[i + 1]))
            for i in range(line_i + 1, line_i + 1 + cases2, 2)
        ),
        key=lambda x: x[0],
    )
    points_by_y = sorted(points_by_x, key=lambda x: x[1])

    line_i += 1 + cases2

    distance = math.sqrt(closest_pair_distance(points_by_x, points_by_y))
    if distance >= DISTANCE_TRESHOLD:
        r += "INFINITY\n"
    else:
        r += "%.4f\n" % distance

sys.stdout.write(r)


# def closest_distance(points: t.Sequence[t.Tuple[float, float]]) -> float:
#     """
#     Brute force, too slow, can't be more optimized
#     """
#     n = len(points)
#     min_dist = DISTANCE_TRESHOLD**2
#     for i in range(n):
#         x, y = points[i]
#         for j in range(i + 1, n):
#             cx, cy = points[j]
#             dx = x - cx
#             dy = y - cy
#             d = dx * dx + dy * dy
#             if d < min_dist:
#                 min_dist = d

#     return math.sqrt(min_dist)

#     points = [
#         (float(lines[i]), float(lines[i + 1]))
#         for i in range(line_i + 1, line_i + 1 + cases2, 2)
#     ]
#     line_i += 1 + cases2
#     distance = closest_distance(points)
