/*
    P2 4)
*/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <sys/time.h>
#include <limits.h>
#include <math.h>  // For fabs

double dwalltime();

int double_equals(double a, double b, double tolerance) {
    return fabs(a - b) <= tolerance;
}

int THREADS = 4;
int N = 2048 * 2 * 2 * 2 * 2 * 2;
int slice = 0;

int *A;

int g_min = INT_MAX;
int g_max = INT_MIN;
double g_prom = 0;

sem_t sem_stats;

void *calc_prom_min_max(void *arg)
{
    int id = *(int *)arg;

    int i;
    int start = id * slice;
    int end = start + slice;
    double total = 0;
    int min = A[start];
    int max = A[start];

    for (i = start; i < end; i++)
    {
        if (A[i] < min)
        {
            min = A[i];
        }
        if (A[i] > max)
        {
            max = A[i];
        }
        total += A[i];
    }

    sem_wait(&sem_stats);

    if (min < g_min)
    {
        g_min = min;
    }
    if (max > g_max)
    {
        g_max = max;
    }
    g_prom += total / N;

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
    slice = N / THREADS;

    printf("Testing with THREADS = %d and N = %d\n", THREADS, N);

    // Free memory for matrices at the end
    A = (int *)malloc(sizeof(int) * N);

    int i;
    for (i = 0; i < N; i++)
    {
        A[i] = i;
    }

    pthread_t threads[THREADS];
    int ids[THREADS];

    // 0 for sharing between threads
    sem_init(&sem_stats, 0, 1);

    double timetick = dwalltime();

    for (int i = 0; i < THREADS; i++)
    {
        ids[i] = i;
        pthread_create(&threads[i], NULL, calc_prom_min_max, &ids[i]);
    }

    for (int i = 0; i < THREADS; i++)
    {
        pthread_join(threads[i], NULL);
    }

    printf("Time: %f\n", dwalltime() - timetick);

    printf("Min: %d check: %s\n", g_min, g_min == 0 ? "OK" : "ERROR");
    printf("Max: %d check: %s\n", g_max, g_max == (N - 1) ? "OK" : "ERROR");
    printf("Prom: %f check: %s\n", g_prom, double_equals(g_prom,(N * (N + 1) / 2), 2) ? "OK" : "ERROR");
    free(A);

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
