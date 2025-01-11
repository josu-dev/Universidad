"""
[vjudge.net/problem/UVA-477](https://vjudge.net/problem/UVA-477)
https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&category=6&page=show_problem&problem=418

Given a list of figures (rectangles and circles) and a list of points in the x-y
plane, determine for each point which figures (if any) contain the point.

Input
There will be n(≤ 10) figures descriptions, one per line. The first character
will designate the type of figure (“r”, “c” for rectangle or circle,
respectively). This character will be followed by values which describe that
figure.
• For a rectangle, there will be four real values designating the x-y
coordinates of the upper left and lower right corners.
• For a circle, there will be three real values, designating the x-y coordinates
of the center and the radius.

The end of the list will be signalled by a line containing an asterisk in column
one.

The remaining lines will contain the x-y coordinates, one per line, of the
points to be tested. The end of this list will be indicated by a point with
coordinates 9999.9 9999.9; these values should not be included in the output.

Points coinciding with a figure border are not considered inside.

Output
For each point to be tested, write a message of the form:
    Point i is contained in figure j
for each figure that contains that point. If the point is not contained in any
figure, write a message of the form:
    Point i is not contained in any figure

Points and figures should be numbered in the order in which they appear in the
input.

Note: See the picture on the right for a diagram of these figures and data
points.

Sample Input
r 8.5 17.0 25.5 -8.5
c 20.2 7.3 5.8
r 0.0 10.3 5.5 0.0
c -5.0 -5.0 3.7
r 2.5 12.5 12.5 2.5
c 5.0 15.0 7.2
*
2.0 2.0
4.7 5.3
6.9 11.2
20.0 20.0
17.6 3.2
-5.2 -7.8
9999.9 9999.9

Sample Output
Point 1 is contained in figure 3
Point 2 is contained in figure 3
Point 2 is contained in figure 5
Point 3 is contained in figure 5
Point 3 is contained in figure 6
Point 4 is not contained in any figure
Point 5 is contained in figure 1
Point 5 is contained in figure 2
Point 6 is contained in figure 4
**ENDS IN NEW LINE**
"""

import math
import sys
import typing as t


CIRCLE = 0
RECTANGLE = 1

lines = sys.stdin.read().splitlines()
size = len(lines)
line_i = 0
figures = t.cast(
    "list[tuple[int,t.Literal[0,1,2],*tuple[float,...]]]",
    [],
)
while line_i < size:
    line = lines[line_i]
    if line[0] == "*":
        break
    line_i += 1

    if line[0] == "c":
        figures.append(
            (
                line_i,
                CIRCLE,
                *(float(coord) for coord in line[2:].split()),
            )
        )
    else:
        figures.append(
            (
                line_i,
                RECTANGLE,
                *(float(coord) for coord in line[2:].split()),
            )
        )

line_i += 1
point_i = 0
r = ""
while line_i < size:
    x, y = (float(coord) for coord in lines[line_i].split())
    if x == 9999.9 and y == 9999.9:
        break

    line_i += 1
    point_i += 1

    point_is_contained = False
    for fig in figures:
        if fig[1] == CIRCLE:
            if math.sqrt((x - fig[2]) ** 2 + (y - fig[3]) ** 2) < fig[4]:
                r += "Point %d is contained in figure %d\n" % (point_i, fig[0])
                point_is_contained = True
        else:
            if (
                x > min(fig[2], fig[4])
                and x < max(fig[2], fig[4])
                and y > min(fig[3], fig[5])
                and y < max(fig[3], fig[5])
            ):
                r += "Point %d is contained in figure %d\n" % (point_i, fig[0])
                point_is_contained = True

    if not point_is_contained:
        r += "Point %d is not contained in any figure\n" % point_i

sys.stdout.write(r)
