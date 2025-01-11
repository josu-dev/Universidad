"""
[vjudge.net/problem/UVA-10310](https://vjudge.net/problem/UVA-10310)
https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&category=0&problem=1251

A large field has a gopher and a dog. The dog wants to eat the gopher, while the
gopher wants to run to safety through one of several gopher holes dug in the
surface of the field.

Neither the dog nor the gopher is a math major; however, neither is entirely
stupid. The gopher decides on a particular gopher hole and heads for that hole
in a straight line at a fixed speed. The dog, which is very good at reading body
language, anticipates which hole the gopher has chosen, and heads at double the
speed of the gopher to the hole, where it intends to gobble up the gopher. If
the dog reaches the hole first, the gopher gets gobbled; otherwise, the gopher
escapes.

You have to select a hole for the gopher through which it can escape, if such a
hole exists.

Input
The input file contains several sets of input. The first line of each set
contains one integer and four floating point numbers. The integer n denotes how
many holes are in the set and the four floating point numbers denote the (x, y)
coordinates of the gopher followed by the (x, y) coordinates of the dog.
Subsequent n lines of input each contain two floating point numbers: the (x, y)
coordinates of a gopher hole. All distances are in meters; to the nearest mm.
Input is terminated by end of file. There is a blank line between two
consecutive sets.

Output
Your should output a single line for each set of input. For each set, if the
gopher can escape the output line should read 'The gopher can escape through the
hole at (x, y).' identifying the appropriate hole to the nearest mm. Otherwise
the output line should read 'The gopher cannot escape.' If the gopher may escape
through more than one hole, report the one that appears first in the input.
There are not more than 1000 gopher holes in a set of input and all coordinates
are between -10000 and +10000.

Sample Input
1 1.000 1.000 2.000 2.000
1.500 1.500

2 2.000 2.000 1.000 1.000
1.500 1.500
2.500 2.500

Sample Output
The gopher cannot escape.
The gopher can escape through the hole at (2.500,2.500).
**ENDS IN NEW LINE**
"""

import math
import sys


lines = sys.stdin.read().splitlines()
size = len(lines)
line_i = 0
r = ""
while line_i < size:
    n, *coords = lines[line_i].split()
    gx, gy, dx, dy = (float(coord) for coord in coords)
    line_i += 1
    escape_hole = None

    while line_i < size:
        line = lines[line_i]
        if line == "":
            break
        line_i += 1

        x, y = (float(coord) for coord in line.split())
        g_dist = math.sqrt((x - gx) ** 2 + (y - gy) ** 2)
        d_dist = math.sqrt((x - dx) ** 2 + (y - dy) ** 2) / 2
        if g_dist <= d_dist and escape_hole is None:
            escape_hole = (x, y)

    if escape_hole is None:
        r += "The gopher cannot escape.\n"
    else:
        r += "The gopher can escape through the hole at (%.3f,%.3f).\n" % escape_hole

    line_i += 1

sys.stdout.write(r)
