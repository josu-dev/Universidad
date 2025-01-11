#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define TEST_SIZES_LENGTH 4
const int TEST_SIZES[TEST_SIZES_LENGTH] = {512, 1024, 2048, 4096};

/* Provided time measurement function */
double dwalltime();

int N = 512;

double *A, *B, *C, *D, *R;

int resolve()
{
    int *m_temp = (int *)malloc(sizeof(int) * N * N);

    double total_time, tick;
    int i, j, k;

    tick = dwalltime();

    // Computation of scalar = (MaxA x MaxB - MinA x MinB) / (AvgA x AvgB)
    
    double max_a, max_b, min_a, min_b, avg_a, avg_b, scalar, sum;
    max_a = max_b = -1.0;
    min_a = min_b = 1000000.0;
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

    // Computation of R = [C x D]

    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            m_temp[j * N + i] = D[i * N + j];
        }
    }

    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            sum = 0;
            for (k = 0; k < N; k++)
            {
                sum += C[i * N + k] * m_temp[j * N + k];
            }
            R[i * N + j] = sum;
        }
    }

    // computation of R = scalar * [A x B] + R

    for (i = 0; i< N; i++)
    {
        for (j = 0; j < N; j++)
        {
            m_temp[j * N + i] = B[i * N + j];
        }
    }

    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            sum = 0;
            for (k = 0; k < N; k++)
            {
                sum += A[i * N + k] * m_temp[j * N + k];
            }
            R[i * N + j] += scalar * sum;
        }
    }

    total_time = dwalltime() - tick;

    printf("Total time: %f\n", total_time);

    // Result check
    int check = 1;
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            check = check && (R[i * N + j] == N);
        }
    }

    printf("Result: %s\n", check ? "OK" : "ERROR");

    free(m_temp);

    return 0;
}

void init_matrix(double *matrix, double value)
{
    int i;
    for (i = 0; i < N*N; i++)
    {
        matrix[i] = value;
    }
}

int main(void)
{
    int i;
    for (i = 0; i < TEST_SIZES_LENGTH; i++)
    {
        N = TEST_SIZES[i];

        printf("Computing for N = %d\n", N);

        A = (double *)malloc(sizeof(double) * N * N);
        B = (double *)malloc(sizeof(double) * N * N);
        C = (double *)malloc(sizeof(double) * N * N);
        D = (double *)malloc(sizeof(double) * N * N);
        R = (double *)malloc(sizeof(double) * N * N);

        init_matrix(A, 1);
        init_matrix(B, 1);
        init_matrix(C, 1);
        init_matrix(D, 1);
        init_matrix(R, 0);

        resolve();

        free(A);
        free(B);
        free(C);
        free(D);
        free(R);
    }

    return 0;
}

double dwalltime()
{
    double sec;
    struct timeval tv;

    gettimeofday(&tv, NULL);
    sec = tv.tv_sec + tv.tv_usec / 1000000.0;
    return sec;
}
