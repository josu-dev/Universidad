"""
[vjudge.net/problem/UVA-460](https://vjudge.net/problem/UVA-460)
https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&category=0&problem=401

When displaying a collection of rectangular windows on a SUN screen, a critical
step is determining whether two windows overlap, and, if so, where on the screen
the overlapping region lies.

Write a program to perform this function. Your program will accept as input the
coordinates of two rectangular windows. If the windows do not overlap, your
program should produce a message to that effect. If they do overlap, you should
compute the coordinates of the overlapping region (which must itself be a
rectangle).

All coordinates are expressed in “pixel numbers”, integer values ranging from 0
to 9999. A rectangle will be described by two pairs of (X, Y) coordinates. The
first pair gives the coordinates of the lower left-hand corner (XLL, YLL). The
second pair gives the coordinates of the upper right-hand coordinates (XUR,
YUR). You are guaranteed that XLL < XUR and YLL < YUR.

Input
Input will contain several test case. It begins with a single positive integer
on a line by itself indicating the number of the cases following, each of them
as described below. This line is followed by a blank line, and there is also a
blank line between two consecutive inputs.

Each test case consists of two lines. The first contains the integer numbers
XLL, YLL, XUR and YUR for the first window. The second contains the same numbers
for the second window.

Output
For each test case, the output must follow the description below. The outputs of
two consecutive cases will be separated by a blank line.

For each set of input if the two windows do not overlap, print the message 'No
Overlap'. If the two windows do overlap, print 4 integer numbers giving the XLL,
YLL, XUR and YUR for the region of overlap.

Note that two windows that share a common edge but have no other points in
common are considered to have 'No Overlap'.

Sample Input
1

0 20 100 1204
80 0 500 60

Sample Output
80 20 100 60
**ENDS IN NEW LINE**
"""

import sys
import typing as t


def rectangles_overlap(
    a_blx: int,
    a_bly: int,
    a_trx: int,
    a_try: int,
    b_blx: int,
    b_bly: int,
    b_trx: int,
    b_try: int,
) -> t.Optional[t.Tuple[int, int, int, int]]:
    if a_trx <= b_blx or a_blx >= b_trx or a_try <= b_bly or a_bly >= b_try:
        return None

    bl_x = max(a_blx, b_blx)
    bl_y = max(a_bly, b_bly)
    tr_x = min(a_trx, b_trx)
    tr_y = min(a_try, b_try)
    return bl_x, bl_y, tr_x, tr_y


lines = sys.stdin.read().split()
line_i = 1
size = len(lines)
cases = int(lines[0])

r = ""
for _ in range(cases):
    r1 = (int(lines[i]) for i in range(line_i, line_i + 4))
    r2 = (int(lines[i]) for i in range(line_i + 4, line_i + 8))
    line_i += 8

    coords = rectangles_overlap(*r1, *r2)
    if coords is None:
        r += "No Overlap\n\n"
    else:
        r += "%d %d %d %d\n\n" % coords

sys.stdout.write(r[:-1])
