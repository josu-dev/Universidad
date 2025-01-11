CHAR_MINE = '*'

def gen_default_matrix(lines:list[str]):
    matrix = []
    for line in lines:
        new_line = []
        for char in line:
            if char == CHAR_MINE:
                new_line.append(-1)
            else:
                new_line.append(0)
        matrix.append(new_line)
    return matrix

def update_neighbour(matrix, y, x):
    size_y = len(matrix) -1
    size_x = len(matrix[0]) -1
    range_y = (max(0,y -1), min(size_y, y +1) +1)
    range_x = (max(0,x -1), min(size_x, x +1) +1)
    for y in range(range_y[0],range_y[1]):
        for x in range(range_x[0],range_x[1]):
            if matrix[y][x] != -1:
                matrix[y][x] += 1

def process_matrix(matrix):
    for y in range(len(matrix)):
        for x in range(len(matrix[0])):
            if matrix[y][x] == -1:
                update_neighbour(matrix, y, x)

def gen_string_matrix(matrix):
    s_matrix = []
    for line in matrix:
        s_line = ''
        for n in line:
            if n == -1:
                s_line += '*'
            else:
                s_line += str(n)
        s_matrix.append(s_line)
    return s_matrix

def transform_matrix(base_matrix):
    number_matrix = gen_default_matrix(base_matrix)
    process_matrix(number_matrix)
    s_matrix = gen_string_matrix(number_matrix)
    return s_matrix


example = [
    '-*-*-',
    '--*--',
    '----*',
    '*----'
]

m = transform_matrix(example)
print(*m, sep='\n')