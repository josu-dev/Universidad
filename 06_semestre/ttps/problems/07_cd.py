"""
Jack and Jill have decided to sell some of their Compact Discs, while they
 still have some value. They have decided to sell one of each of the CD titles
 that they both own. How many CDs can Jack and Jillsell?
Neither Jack nor Jill owns more than one copy of each CD.

Input
The input consists of a sequence of test cases. The first line of each test
 case contains two non-negative integers N and M, each at most one million,
 specifying the number of CDs owned by Jack and by Jill, respectively. This
 line is followed by N lines listing the catalog numbers of the CDs owned by
 Jack in increasing order, and M more lines listing the catalog numbers of the
 CDs owned by Jill in increasing order. Each catalog number is a positive
 integer no greater than one billion. The input is terminated by a line
 containing two zeros. This last line is not a  test case and should not be
 processed.

Output
For each test case, output a line containing one integer, the number of CDs
 that Jack and Jill both own.

Sample Input
3 3
1
2
3
1
2
4
0 0

Sample Output
2
"""

import sys


lines = sys.stdin.read().split()
index = 0
res = ""
while lines[index] != "0":
    jack = int(lines[index])
    jill = int(lines[index + 1])
    index += 2
    cache = {lines[i] for i in range(index, index + jack)}
    index += jack
    res += str(sum(1 for i in range(index, index + jill) if lines[i] in cache)) + "\n"
    index += jill

sys.stdout.write(res)
sys.stdout.flush()
