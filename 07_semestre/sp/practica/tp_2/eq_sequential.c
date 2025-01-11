#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <float.h>

/*
    Program to compute the following expression:

    ((MaxA x MaxB - MinA x MinB) / (AvgA x AvgB)) x [A x B] + [C x D]

    Where:
    - A, B, C, D are square matrices of size N x N
*/

double dwalltime();

void matmulblks(double *a, double *b, double *c, int n, int bs);

void blkmul(double *ablk, double *bblk, double *cblk, int n, int bs);

void init_matrix(double *matrix, double value, int transpose);

int N = 512;
int BS = 4;
double *A, *B, *C, *D, *R;

int initilize(int argc, char *argv[]);

int main(int argc, char *argv[])
{
    if (initilize(argc, argv))
    {
        return 1;
    }

    printf("N: %d BS: %d\n", N, BS);

    double total_time, tick;
    int i, j, k;

    tick = dwalltime();

    // computation of (MaxA x MaxB - MinA x MinB) / (AvgA x AvgB)
    double max_a, max_b, min_a, min_b, avg_a, avg_b, scalar;
    max_a = max_b = DBL_MIN;
    min_a = min_b = DBL_MAX;
    avg_a = avg_b = 0.0;

    for (i = 0; i < N * N; i++)
    {
        if (A[i] > max_a)
            max_a = A[i];
        if (A[i] < min_a)
            min_a = A[i];
        avg_a += A[i];
    }

    for (i = 0; i < N * N; i++)
    {
        if (B[i] > max_b)
            max_b = B[i];
        if (B[i] < min_b)
            min_b = B[i];
        avg_b += B[i];
    }

    avg_a /= N * N;
    avg_b /= N * N;
    scalar = (max_a * max_b - min_a * min_b) / (avg_a * avg_b);

    // computation of [A x B]
    matmulblks(A, B, R, N, BS);

    // computation of R = scalar * R
    for (i = 0; i < N * N; i++)
    {
        R[i] = scalar * R[i];
    }

    // computation of R = R + [C x D]
    matmulblks(C, D, R, N, BS);

    total_time = dwalltime() - tick;

    printf("T: %f\n", total_time);

    // Result check
    int check = 1;
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            check = check && (R[i * N + j] == N);
        }
    }

    printf("R: %s\n", check ? "OK" : "ERROR");

    free(A);
    free(B);
    free(C);
    free(D);
    free(R);

    return 0;
}

int initilize(int argc, char *argv[])
{
    if (argc < 3)
    {
        printf("Usage: %s N BS\n", argv[0]);
        if (argc < 2)
        {
            printf("Missing N and BS\n");
        }
        else
        {
            printf("Missing BS\n");
        }
        return 1;
    }

    N = atoi(argv[1]);
    BS = atoi(argv[2]);

    if (N <= 0 || BS <= 0)
    {
        printf("Usage: %s N BS\n", argv[0]);
        if (N <= 0)
        {
            printf("Invalid N\n");
        }
        if (BS <= 0)
        {
            printf("Invalid BS\n");
        }
        return 1;
    }

    if ((N % BS) != 0)
    {
        printf("Usage: %s N BS\n", argv[0]);
        printf("N must be a multiple of BS\n");
        return 1;
    }

    A = (double *)malloc(sizeof(double) * N * N);
    B = (double *)malloc(sizeof(double) * N * N);
    C = (double *)malloc(sizeof(double) * N * N);
    D = (double *)malloc(sizeof(double) * N * N);
    R = (double *)malloc(sizeof(double) * N * N);

    init_matrix(A, 1, 0);
    init_matrix(B, 1, 1);
    init_matrix(C, 1, 0);
    init_matrix(D, 1, 1);
    init_matrix(R, 0, 0);
    return 0;
}

/* Provided time measurement function */
double dwalltime()
{
    double sec;
    struct timeval tv;

    gettimeofday(&tv, NULL);
    sec = tv.tv_sec + tv.tv_usec / 1000000.0;
    return sec;
}

/* Provided block matrix multiplication functions */

/* Multiply square matrices, blocked version */
void matmulblks(double *a, double *b, double *c, int n, int bs)
{
    int i, j, k, fila, col;

    for (i = 0; i < n; i += bs)
    {
        fila = i * n;
        for (j = 0; j < n; j += bs)
        {
            col = j * n;
            for (k = 0; k < n; k += bs)
            {
                blkmul(&a[fila + k], &b[col + k], &c[fila + j], n, bs);
            }
        }
    }
}

void blkmul(double *ablk, double *bblk, double *cblk, int n, int bs)
{
    int i, j, k, fila, col;
    double sum;

    for (i = 0; i < bs; i++)
    {
        fila = i * n;
        for (j = 0; j < bs; j++)
        {
            col = j * n;
            sum = 0;
            for (k = 0; k < bs; k++)
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
        for (i = 0; i < N; i++)
        {
            for (j = 0; j < N; j++)
            {
                matrix[j * N + i] = value;
            }
        }
        return;
    }

    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            matrix[i * N + j] = value;
        }
    }
}
