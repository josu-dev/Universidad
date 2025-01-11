"""
Write a program that will remove all duplicates from a sequence of integers and
 print the list of unique integers occuring in the input sequence, along with
 the number of occurences of each.

Input
The input file will contain a sequence of integers (positive, negative, and/or
 zero). The input file may be arbitrarily long.

Output
The output for this program will be a sequence of ordered pairs, separated by
 newlines. The first element of the pair must be an integer from the input file.
 The second element must be the number of times that that particular integer
 appeared in the input file. The elements in each pair are to be separated by
 space characters. The integers are to appear in the order in which they were
 contained in the input file.

Sample Input
3 1 2 2 1 3 5 3 3 2

Sample Output
3 4
1 2
2 3
5 1
"""

import sys


cache = dict()  # type: dict[str, int] # type: ignore

for integer in sys.stdin.read().split():
    cache[integer] = cache.get(integer, 0) + 1

sys.stdout.write("\n".join("{} {}".format(k, v) for k, v in cache.items()) + "\n")
sys.stdout.flush()
