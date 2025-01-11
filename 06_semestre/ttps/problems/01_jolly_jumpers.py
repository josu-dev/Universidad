"""
A sequence of n > 0 integers is called a jolly jumper if the absolute values of the difference between
successive elements take on all the values 1 through n - 1. For instance,
1 4 2 3
is a jolly jumper, because the absolutes differences are 3, 2, and 1 respectively. The definition implies
that any sequence of a single integer is a jolly jumper. You are to write a program to determine whether
or not each of a number of sequences is a jolly jumper.

Input
Each line of input contains an integer n ≤ 3000 followed by n integers representing the sequence.

Output
For each line of input, generate a line of output saying 'Jolly' or 'Not jolly'.

Sample Input
4 1 4 2 3
5 1 4 2 -1 6

Sample Output
Jolly
Not jolly
"""

try:
    while True:
        top, *rest = map(int, input().split())
        cache = list(False for _ in range(top - 1))
        for i in range(top - 1):
            diff = abs(rest[i] - rest[i + 1])
            if diff >= top or diff <= 0 or cache[diff - 1]:
                print("Not jolly")
                break

            cache[diff - 1] = True
        else:
            print("Jolly")
except EOFError:
    pass
