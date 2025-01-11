/*
    P2 5)
*/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <sys/time.h>
#include <limits.h>
#include <math.h> // For fabs

double dwalltime();

int double_equals(double a, double b, double tolerance)
{
    return fabs(a - b) <= tolerance;
}

int THREADS = 4;
int N = 2048 * 2 * 2 * 2 * 2 * 2;
int slice = 0;

struct Conjunto
{
    int *els;
    int size;
};

struct Conjunto *A, *B, *C;

sem_t sem_stats;

void *intersection(void *arg)
{
    int id = *(int *)arg;

    int i;
    int start = id * slice;
    int end = start + slice;

    struct Conjunto result = {
        .els = (int *)malloc(sizeof(int) * slice),
        .size = 0,
    };

    for (i = start; i < end; i++)
    {
        for (int j = 0; j < A->size; j++)
        {
            if (A->els[j] == B->els[i])
            {
                result.els[result.size] = A->els[i];
                result.size++;
                break;
            }
        }
    }

    sem_wait(&sem_stats);

    for (i = 0; i < result.size; i++)
    {
        C->els[C->size] = result.els[i];
        C->size++;
    }

    sem_post(&sem_stats);

    pthread_exit(NULL);
}

int main(int argc, char *argv[])
{
    if ((argc != 2) || ((N = N * atoi(argv[1])) <= 0))
    {
        printf("\nUsar: %s n\n  n: Dimension de la matriz (nxn X nxn)\n", argv[0]);
        exit(1);
    }
    slice = (N / 4) / THREADS;

    printf("Testing with THREADS = %d and N = %d\n", THREADS, N);

    // Free memory for matrices at the end
    A = (struct Conjunto *)malloc(sizeof(struct Conjunto));
    A->els = (int *)malloc(sizeof(int) * N);
    A->size = N;

    int i;
    for (i = 0; i < A->size; i++)
    {
        A->els[i] = i;
    }

    B = (struct Conjunto *)malloc(sizeof(struct Conjunto));
    B->els = (int *)malloc(sizeof(int) * (N / 4));
    B->size = N / 4;

    for (i = 0; i < B->size; i++)
    {
        B->els[i] = i;
    }

    C = (struct Conjunto *)malloc(sizeof(struct Conjunto));
    C->els = (int *)malloc(sizeof(int) * N);
    C->size = 0;

    pthread_t threads[THREADS];
    int ids[THREADS];

    // 0 for sharing between threads
    sem_init(&sem_stats, 0, 1);

    double timetick = dwalltime();

    for (int i = 0; i < THREADS; i++)
    {
        ids[i] = i;
        pthread_create(&threads[i], NULL, intersection, &ids[i]);
    }

    for (int i = 0; i < THREADS; i++)
    {
        pthread_join(threads[i], NULL);
    }

    printf("Time: %f\n", dwalltime() - timetick);

    printf("Intersection size: %d (expected %d) Check: %s\n", C->size, N / 4, C->size == N / 4 ? "OK" : "ERROR");

    free(A->els);
    free(A);
    free(B->els);
    free(B);
    free(C->els);
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
