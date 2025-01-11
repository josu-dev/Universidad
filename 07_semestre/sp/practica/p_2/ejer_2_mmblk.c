/*
    P2 2) Paarte 2
*/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/time.h>

/* Multiply (block)submatrices */
void blkmul(double *ablk, double *bblk, double *cblk, int n, int bs);

double dwalltime();

int THREADS = 4;
int N = 512;
int slice = 0;
int BLOCK_SIZE = 16;

double *A, *B, *C;

void *matmulblks(void *arg)
{
    int i, j, k;
    int id = *(int *)arg;
    int start = id * slice;
    int end = start + slice;

    for (i = start; i < end; i += BLOCK_SIZE)
    {
        for (j = 0; j < N; j += BLOCK_SIZE)
        {
            for (k = 0; k < N; k += BLOCK_SIZE)
            {
                blkmul(&A[i * N + k], &B[j * N + k], &C[i * N + j], N, BLOCK_SIZE);
            }
        }
    }

    pthread_exit(NULL);
}

int main(int argc, char *argv[])
{
    if ((argc != 2) || ((N = atoi(argv[1])) <= 0))
    {
        printf("\nUsar: %s n\n  n: Dimension de la matriz (nxn X nxn)\n", argv[0]);
        exit(1);
    }
    slice = N / THREADS;

    // Free memory for matrices at the end
    A = (double *)malloc(sizeof(double) * N * N);
    B = (double *)malloc(sizeof(double) * N * N);
    C = (double *)malloc(sizeof(double) * N * N);

    int i, j;
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            A[i + j * N] = 1;
        }
    }
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            B[i + j * N] = 1;
        }
    }

    pthread_t threads[THREADS];
    int ids[THREADS];

    for (int i = 0; i < THREADS; i++)
    {
        ids[i] = i;
        pthread_create(&threads[i], NULL, matmulblks, &ids[i]);
    }

    double timetick = dwalltime();

    for (int i = 0; i < THREADS; i++)
    {
        pthread_join(threads[i], NULL);
    }

    printf("Time: %f\n", dwalltime() - timetick);

    int check = 1;
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            check = check && (C[i * N + j] == N);
        }
    }
    printf("Check: %s\n", check ? "OK" : "ERROR");

    free(A);
    free(B);
    free(C);
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

/*****************************************************************/

/* Multiply (block)submatrices */
void blkmul(double *ablk, double *bblk, double *cblk, int n, int bs)
{
    int i, j, k;

    for (i = 0; i < bs; i++)
    {
        for (j = 0; j < bs; j++)
        {
            for (k = 0; k < bs; k++)
            {
                cblk[i * n + j] += ablk[i * n + k] * bblk[j * n + k];
            }
        }
    }
}
