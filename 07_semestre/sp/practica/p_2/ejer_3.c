/*
    P2 2)
*/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/time.h>

double dwalltime();

int THREADS = 8;
int N = 2048 * 2 * 2 * 2 * 2 * 2;
int slice = 0;

int *A;

int el_to_find = 0;
int el_ocurrences = 0;
pthread_mutex_t el_ocurrences_lock;

void *count(void *arg)
{
    int id = *(int *)arg;

    int i;
    int start = id * slice;
    int end = start + slice;
    int ocurrences = 0;

    double total;
    for (i = start; i < end; i++)
    {
        if (A[i] == el_to_find)
        {
            ocurrences++;
        }
    }

    pthread_mutex_lock(&el_ocurrences_lock);
    el_ocurrences += ocurrences;
    pthread_mutex_unlock(&el_ocurrences_lock);

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

    printf("Testing with N = %d\n", N);

    // Free memory for matrices at the end
    A = (int *)malloc(sizeof(int) * N);

    int i;
    for (i = 0; i < N; i++)
    {
        A[i] = i % 2;
    }

    pthread_t threads[THREADS];
    int ids[THREADS];

    pthread_mutex_init(&el_ocurrences_lock, NULL);

    double timetick = dwalltime();

    for (int i = 0; i < THREADS; i++)
    {
        ids[i] = i;
        pthread_create(&threads[i], NULL, count, &ids[i]);
    }

    for (int i = 0; i < THREADS; i++)
    {
        pthread_join(threads[i], NULL);
    }

    printf("Time: %f\n", dwalltime() - timetick);

    int check = el_ocurrences == (N / 2);

    printf("Check: %s\n", check ? "OK" : "ERROR");

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
