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

void init_matrix(double *matrix, double value, int transpose);

int N = 512;
double *A, *B, *C, *D, *R;

int initilize(int argc, char *argv[]);

int main(int argc, char *argv[])
{
    if (initilize(argc, argv))
    {
        return 1;
    }

    printf("N: %d\n", N);

    double total_time, tick, sum;
    int i, j, k, fila, col;

    tick = dwalltime();

    // Computation of (MaxA x MaxB - MinA x MinB) / (AvgA x AvgB)
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

    // computation of scalar * [A x B]
    for (i = 0; i < N; i += 1)
    {
        fila = i * N;
        for (j = 0; j < N; j += 1)
        {
            col = j * N;
            sum = 0;
            for (k = 0; k < N; k += 1)
            {
                sum += A[fila + k] * B[col + k];
            }
            R[fila + j] = scalar * sum;
        }
    }

    // computation of R = R + [C x D]
    for (i = 0; i < N; i += 1)
    {
        fila = i * N;
        for (j = 0; j < N; j += 1)
        {
            col = j * N;
            sum = 0;
            for (k = 0; k < N; k += 1)
            {
                sum += C[fila + k] * D[col + k];
            }
            R[fila + j] += sum;
        }
    }

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
    if (argc < 2)
    {
        printf("Usage: %s N\n", argv[0]);
        printf("Missing N\n");
        return 1;
    }

    N = atoi(argv[1]);

    if (N <= 0)
    {
        printf("Usage: %s N\n", argv[0]);
        printf("N must be greater than 0\n");
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
