"""
[vjudge.net/problem/UVA-526](https://vjudge.net/problem/UVA-526)

String Distance is a non-negative integer that measures the distance between two
 strings. Here we give the definition. A transform list is a list of strings,
 where each string, except for the last one, can be changed to the string
 followed by adding a character, deleting a character or replacing a character.
 The length of a transform list is the count of strings minus 1 (that is the
 count of operations to transform these two strings). The distance between two
 strings is the length of a transform list from one string to the other with the
 minimal length. You are to write a program to calculate the distance between
 two strings and give the corresponding transform list.

Input
Input consists a sequence of string pairs, each string pair consists two lines,
 each string occupies one line. The length of each string will be no more than
 80.

Output
For each string pair, you should give an integer to indicate the length between
 them at the first line, and give a sequence of command to transform string1 to
 string2. Each command is a line lead by command count, then the command. A
 command must be

 Insert pos,value
 Delete pos
 Replace pos,value

 where pos is the position of the string and pos should be between 1 and the
 current length of the string (in 'Insert' command, pos can be 1 greater than
 the length), and value is a character. Actually many command lists can satisfy
 the request, but only one of them is required.
Print a blank line between consecutive datasets.

Sample Input
abcac
bcd
aaa
aabaaaa

Sample Output
3
1 Delete 1
2 Replace 3,d
3 Delete 4

4
1 Insert 1,a
2 Insert 2,a
3 Insert 3,b
4 Insert 7,a
**ENDS IN NEW LINE**
**EDGE CASE: EMPTY LINES ARE VALID**
"""

import sys


def word_edit_distance(seq1: str, seq2: str, out: "list[str]") -> None:
    rows = len(seq1) + 1
    cols = len(seq2) + 1
    distance = [[0] * cols for _ in range(rows)]

    for col in range(1, cols):
        distance[0][col] = col

    for row in range(1, rows):
        distance[row][0] = row
        for col in range(1, cols):
            if seq1[row - 1] == seq2[col - 1]:
                distance[row][col] = distance[row - 1][col - 1]
            else:
                distance[row][col] = 1 + min(
                    distance[row - 1][col - 1],
                    distance[row - 1][col],
                    distance[row][col - 1],
                )

    offset = 0
    steps = 0

    def backtrace(i: int, j: int):
        nonlocal offset, steps
        if i == 0 and j == 0:
            return
        if i > 0 and j > 0 and seq1[i - 1] == seq2[j - 1]:
            backtrace(i - 1, j - 1)
        elif j > 0 and distance[i][j] == (distance[i][j - 1] + 1):
            backtrace(i, j - 1)
            offset += 1
            steps += 1
            out.append("%d Insert %d,%s\n" % (steps, i + offset, seq2[j - 1]))
        elif i > 0 and distance[i][j] == distance[i - 1][j] + 1:
            backtrace(i - 1, j)
            steps += 1
            out.append("%d Delete %d\n" % (steps, i + offset))
            offset -= 1
        elif distance[i][j] == (distance[i - 1][j - 1] + 1):
            backtrace(i - 1, j - 1)
            steps += 1
            out.append("%d Replace %d,%s\n" % (steps, i + offset, seq2[j - 1]))

    out.append("%d\n" % distance[rows - 1][cols - 1])
    backtrace(rows - 1, cols - 1)


lines = sys.stdin.read().splitlines()
r = []  # type: list[str] # type: ignore
for i in range(0, len(lines), 2):
    seq1 = lines[i]
    seq2 = lines[i + 1]

    if i > 0:
        r.append("\n")

    word_edit_distance(seq1, seq2, r)

sys.stdout.writelines(r)
