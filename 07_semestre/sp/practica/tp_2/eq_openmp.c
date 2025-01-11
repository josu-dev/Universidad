#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <float.h>
#include <omp.h>

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
double *A, *B, *C, *D, *R, *CD;
double max_a = -1000000000, max_b = -1000000000, min_a = 1000000000, min_b = 1000000000, avg_a = 0.0, avg_b = 0.0, scalar;

int main(int argc, char *argv[])
{
    if (configure_from_args(argc, argv))
    {
        return 1;
    }

    printf("N: %d BS: %d\n", matrix_size, block_size);

    double total_time, tick;
    int i, j, k, row, col;

    tick = dwalltime();

#pragma omp parallel private(i, j, k)
    {
        // computation of (MaxA x MaxB - MinA x MinB) / (AvgA x AvgB) into scalar
#pragma omp for schedule(static) nowait reduction(max : max_a) reduction(min : min_a) reduction(+ : avg_a)
        for (i = 0; i < matrix_elements; i++)
        {
            if (A[i] > max_a)
                max_a = A[i];
            if (A[i] < min_a)
                min_a = A[i];
            avg_a += A[i];
        }

#pragma omp for schedule(static) nowait reduction(max : max_b) reduction(min : min_b) reduction(+ : avg_b)
        for (i = 0; i < matrix_elements; i++)
        {
            if (B[i] > max_b)
                max_b = B[i];
            if (B[i] < min_b)
                min_b = B[i];
            avg_b += B[i];
        }

        // computation of R = [A x B]
#pragma omp for schedule(static) nowait private(i, j, k, row, col)
        for (i = 0; i < matrix_size; i += block_size)
        {
            row = i * matrix_size;
            for (j = 0; j < matrix_size; j += block_size)
            {
                col = j * matrix_size;
                for (k = 0; k < matrix_size; k += block_size)
                {
                    blkmul(&A[row + k], &B[col + k], &R[row + j], matrix_size, block_size);
                }
            }
        }

        // computation of CD = [C x D]
#pragma omp for schedule(static) nowait private(i, j, k, row, col)
        for (i = 0; i < matrix_size; i += block_size)
        {
            row = i * matrix_size;
            for (j = 0; j < matrix_size; j += block_size)
            {
                col = j * matrix_size;
                for (k = 0; k < matrix_size; k += block_size)
                {
                    blkmul(&C[row + k], &D[col + k], &CD[row + j], matrix_size, block_size);
                }
            }
        }

#pragma omp single
        {
            avg_a /= matrix_elements;
            avg_b /= matrix_elements;
            scalar = (max_a * max_b - min_a * min_b) / (avg_a * avg_b);
        }

        // computation of R = scalar * R + CD
#pragma omp for schedule(static) private(i)
        for (i = 0; i < matrix_elements; i++)
        {
            R[i] = scalar * R[i] + CD[i];
        }
    }

    total_time = dwalltime() - tick;

    printf("T: %f\n", total_time);

    // Result check
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

    return 0;
}

int configure_from_args(int argc, char *argv[])
{
    if (argc < 3)
    {
        printf("Usage: %s [matrix_size] [block_size]\n", argv[0]);
        if (argc < 2)
        {
            printf("Missing matrix_size, block_size\n");
        }
        else
        {
            printf("Missing block_size\n");
        }
        return 1;
    }
    matrix_size = atoi(argv[1]);
    block_size = atoi(argv[2]);

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

    if ((matrix_size % block_size) != 0)
    {
        printf("Usage: %s matrix_size block_size\n", argv[0]);
        printf("N must be a multiple of block_size\n");
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
void blkmul(double *ablk, double *bblk, double *cblk, int n, int block_size)
{
    int i, j, k, row, col;
    double sum;

    for (i = 0; i < block_size; i++)
    {
        row = i * n;
        for (j = 0; j < block_size; j++)
        {
            col = j * n;
            sum = 0;
            for (k = 0; k < block_size; k++)
            {
                sum += ablk[row + k] * bblk[col + k];
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
