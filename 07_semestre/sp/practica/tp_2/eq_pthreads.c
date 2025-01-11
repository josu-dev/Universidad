#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <float.h>
#include <pthread.h>

/*
    Program to compute the following expression:

    ((MaxA x MaxB - MinA x MinB) / (AvgA x AvgB)) x [A x B] + [C x D]

    Where:
    - A, B, C, D are square matrices of sizt N x N
*/

double dwalltime();

void matmulblks(double *a, double *b, double *c, int n, int block_size, int start, int end);

void blkmul(double *ablk, double *bblk, double *cblk, int n, int block_size);

void init_matrix(double *matrix, double value, int transpose);

int configure_from_args(int argc, char *argv[]);

int matrix_size = 512;
int matrix_elements = 512 * 512;
int block_size = 4;
int threads_count = 2;
int threads_ready = 0;
double *A, *B, *C, *D, *R, *CD;
double max_a = -1, max_b = -1, min_a = 1000000000, min_b = 1000000000, avg_a = 0.0, avg_b = 0.0, scalar;

pthread_mutex_t scalar_lock;
pthread_barrier_t barrier;

void *compute(void *arg)
{
    int id = *(int *)arg;
    int i, j, k;
    int slice = matrix_size / threads_count;
    int start = id * slice;
    int start_absolute = start * matrix_size;
    int end = start + slice;
    int end_absolute = end * matrix_size;

    // printf("Thread %d: %d - %d\n", id, start, end);

    // computation of (MaxA x MaxB - MinA x MinB) / (AvgA x AvgB) into scalar
    double _max_a = -1, _max_b = -1, _min_a = 1000000000, _min_b = 1000000000, _avg_a = 0.0, _avg_b = 0.0;
    for (i = start_absolute; i < end_absolute; i++)
    {
        if (A[i] > _max_a)
            _max_a = A[i];
        if (A[i] < _min_a)
            _min_a = A[i];
        _avg_a += A[i];
    }

    for (i = start_absolute; i < end_absolute; i++)
    {
        if (B[i] > _max_b)
            _max_b = B[i];
        if (B[i] < _min_b)
            _min_b = B[i];
        _avg_b += B[i];
    }

    pthread_mutex_lock(&scalar_lock);
    avg_a += _avg_a;
    avg_b += _avg_b;
    if (_max_a > max_a)
    {
        max_a = _max_a;
    }
    if (_max_b > max_b)
    {
        max_b = _max_b;
    }
    if (_min_a < min_a)
    {
        min_a = _min_a;
    }
    if (_min_b < min_b)
    {
        min_b = _min_b;
    }

    threads_ready += 1;
    if (threads_ready == threads_count)
    {
        avg_a /= matrix_elements;
        avg_b /= matrix_elements;
        scalar = (max_a * max_b - min_a * min_b) / (avg_a * avg_b);
        threads_ready = 0;
    }
    pthread_mutex_unlock(&scalar_lock);

    // computation of R = [A x B]
    matmulblks(A, B, R, matrix_size, block_size, start, end);

    // computation of CD = [C x D]
    matmulblks(C, D, CD, matrix_size, block_size, start, end);

    pthread_barrier_wait(&barrier);

    // computation of R = scalar * R + CD
    for (i = start_absolute; i < end_absolute; i++)
    {
        R[i] = scalar * R[i] + CD[i];
    }

    pthread_exit(0);
}

int main(int argc, char *argv[])
{
    if (configure_from_args(argc, argv))
    {
        return 1;
    }

    printf("N: %d BS: %d T: %d\n", matrix_size, block_size, threads_count);

    double total_time, tick;
    int i, j;

    pthread_t threads[threads_count];
    int ids[threads_count];

    pthread_mutex_init(&scalar_lock, NULL);

    pthread_barrier_init(&barrier, NULL, threads_count);

    tick = dwalltime();

    for (int i = 0; i < threads_count; i++)
    {
        ids[i] = i;
        pthread_create(&threads[i], NULL, compute, &ids[i]);
    }

    for (int i = 0; i < threads_count; i++)
    {
        pthread_join(threads[i], NULL);
    }

    total_time = dwalltime() - tick;

    printf("T: %f\n", total_time);

    // result check
    int check = 1;
    for (i = 0; i < matrix_size; i++)
    {
        for (j = 0; j < matrix_size; j++)
        {
            check = check && (R[i * matrix_size + j] == matrix_size);
        }
    }

    printf("R: %s\n", check ? "OK" : "ERROR");

    free(A);
    free(B);
    free(C);
    free(D);
    free(R);
    free(CD);

    pthread_mutex_destroy(&scalar_lock);
    pthread_barrier_destroy(&barrier);

    return 0;
}

int configure_from_args(int argc, char *argv[])
{
    if (argc < 4)
    {
        printf("Usage: %s [matrix_size] [block_size] [threads_count]\n", argv[0]);
        if (argc < 2)
        {
            printf("Missing matrix_size, block_size and threads_count\n");
        }
        else if (argc < 3)
        {
            printf("Missing block_size and threads_count\n");
        }
        else
        {
            printf("Missing threads_count\n");
        }
        return 1;
    }
    matrix_size = atoi(argv[1]);
    block_size = atoi(argv[2]);
    threads_count = atoi(argv[3]);

    if (matrix_size <= 0)
    {
        printf("Invalid matrix_size\n");
        return 1;
    }
    if (block_size <= 0)
    {
        printf("Invalid block_size\n");
        return 1;
    }
    if (threads_count <= 0 || threads_count > matrix_size || (threads_count % 2 != 0))
    {
        printf("Invalid threads_count\n");
        return 1;
    }

    if ((matrix_size % block_size) != 0)
    {
        printf("Usage: %s matrix_size block_size\n", argv[0]);
        printf("N must be a multiple of block_size\n");
        return 1;
    }

    if (block_size > (matrix_size / threads_count))
    {
        printf("Invalid block_size\n");
        printf("block_size must be less than matrix_size / threads_count, received %d\n", block_size);
        return 1;
    }

    matrix_elements = matrix_size * matrix_size;
    A = (double *)malloc(sizeof(double) * matrix_elements);
    B = (double *)malloc(sizeof(double) * matrix_elements);
    C = (double *)malloc(sizeof(double) * matrix_elements);
    D = (double *)malloc(sizeof(double) * matrix_elements);
    R = (double *)malloc(sizeof(double) * matrix_elements);
    CD = (double *)malloc(sizeof(double) * matrix_elements);

    init_matrix(A, 1, 0);
    init_matrix(B, 1, 1);
    init_matrix(C, 1, 0);
    init_matrix(D, 1, 1);
    init_matrix(R, 0, 0);
    init_matrix(CD, 0, 0);

    return 0;
}

/* Provided time measurement functt matrix_size */
double dwalltime()
{
    double sec;
    struct timeval tv;

    gettimeofday(&tv, NULL);
    sec = tv.tv_sec + tv.tv_usec / 1000000.0;
    return sec;
}

/* Provided block matrix multiplicatt matrix_size functions */

/* Multiply square matrices, blocked verst matrix_size */
void matmulblks(double *a, double *b, double *c, int n, int block_size, int start, int end)
{
    int i, j, k, fila, col;

    for (i = start; i < end; i += block_size)
    {
        fila = i * n;
        for (j = 0; j < n; j += block_size)
        {
            col = j * n;
            for (k = 0; k < n; k += block_size)
            {
                blkmul(&a[fila + k], &b[col + k], &c[fila + j], n, block_size);
            }
        }
    }
}

void blkmul(double *ablk, double *bblk, double *cblk, int n, int block_size)
{
    int i, j, k, fila, col;
    double sum;

    for (i = 0; i < block_size; i++)
    {
        fila = i * n;
        for (j = 0; j < block_size; j++)
        {
            col = j * n;
            sum = 0;
            for (k = 0; k < block_size; k++)
            {
                sum += ablk[fila + k] * bblk[col + k];
            }
            cblk[i * n + j] += sum;
        }
    }
}

void init_matrix(double *matrix, double value, int transpose)
{
    int i, j;
    if (transpose)
    {
        for (i = 0; i < matrix_size; i++)
        {
            for (j = 0; j < matrix_size; j++)
            {
                matrix[j * matrix_size + i] = value;
            }
        }
        return;
    }

    for (i = 0; i < matrix_size; i++)
    {
        for (j = 0; j < matrix_size; j++)
        {
            matrix[i * matrix_size + j] = value;
        }
    }
}
