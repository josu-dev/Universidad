"""
[vjudge.net/problem/UVA-378](https://vjudge.net/problem/UVA-378)
https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&category=0&problem=314

We all know that a pair of distinct points on a plane defines a line and that a
pair of lines on a plane will intersect in one of three ways: 1) no intersection
because they are parallel, 2) intersect in a line because they are on top of one
another (i.e. they are the same line), 3) intersect in a point. In this problem
you will use your algebraic knowledge to create a program that determines how
and where two lines intersect.

Your program will repeatedly read in four points that define two lines in the
x-y plane and determine how and where the lines intersect. All numbers required
by this problem will be reasonable, say between -1000 and 1000.

Input
The first line contains an integer N between 1 and 10 describing how many pairs
of lines are represented. The next N lines will each contain eight integers.
These integers represent the coordinates of four points on the plane in the
order x1 y1 x2 y2 x3 y3 x4 y4. Thus each of these input lines represents two
lines on the plane: the line through (x1, y1) and (x2, y2) and the line through
(x3, y3) and (x4, y4). The point (x1, y1) is always distinct from (x2, y2).
Likewise with (x3, y3) and (x4, y4).

Output
There should be N + 2 lines of output. The first line of output should read
'INTERSECTING LINES OUTPUT'. There will then be one line of output for each pair
of planar lines represented by a line of input, describing how the lines
intersect: none, line, or point. If the intersection is a point then your
program should output the x and y coordinates of the point, correct to two
decimal places. The final line of output should read 'END OF OUTPUT'.

Sample Input
5
0 0 4 4 0 4 4 0
5 0 7 6 1 0 2 3
5 0 7 6 3 -6 4 -3
2 0 2 27 1 5 18 5
0 3 4 0 1 2 2 5

Sample Output
INTERSECTING LINES OUTPUT
POINT 2.00 2.00
NONE
LINE
POINT 2.00 5.00
POINT 1.07 2.20
END OF OUTPUT
**ENDS IN NEW LINE**
"""

import sys


INF = float("inf")
lines = sys.stdin.read().split()
line_i = 1
size = len(lines)
cases = int(lines[0])

r = "INTERSECTING LINES OUTPUT\n"
for _ in range(cases):
    (
        a1x,
        a1y,
        a2x,
        a2y,
        b1x,
        b1y,
        b2x,
        b2y,
    ) = (int(lines[i]) for i in range(line_i, line_i + 8))
    line_i += 8

    if a1x == a2x:
        m1 = INF
        b1 = a1x
    else:
        m1 = (a2y - a1y) / (a2x - a1x)
        b1 = a1y - m1 * a1x

    if b1x == b2x:
        m2 = INF
        b2 = b1x
    else:
        m2 = (b2y - b1y) / (b2x - b1x)
        b2 = b1y - m2 * b1x

    if m1 != m2:
        if m1 == INF:
            x = a1x
            y = m2 * x + b2
        elif m2 == INF:
            x = b1x
            y = m1 * x + b1
        else:
            x = (b2 - b1) / (m1 - m2)
            y = m1 * x + b1

        r += "POINT %.2f %.2f\n" % (x, y)
    elif b1 == b2:
        r += "LINE\n"
    else:
        r += "NONE\n"

r += "END OF OUTPUT\n"

sys.stdout.write(r)
