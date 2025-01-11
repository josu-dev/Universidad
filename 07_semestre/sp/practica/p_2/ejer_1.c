/*
    P2 1)
    Desarrolle un algoritmo paralelo que compute una suma de vectores: 𝐴𝑖 =𝐵𝑖 +𝐶𝑖
    Mida el tiempo de ejecución para diferentes valores de N y T={2,4,8}. Analice el rendimiento.
*/

#include <stdio.h>
#include <pthread.h>
#include <sys/time.h>

double dwalltime()
{
    double sec;
    struct timeval tv;

    gettimeofday(&tv, NULL);
    sec = tv.tv_sec + tv.tv_usec / 1000000.0;
    return sec;
}

#define THREADS 1
#define VEC_SIZE 8 * 10 * 100 * 100 * 100

int A[VEC_SIZE], B[VEC_SIZE], C[VEC_SIZE];

int slice = VEC_SIZE / THREADS;

void *sum(void * arg)
{
    int id = *(int *)arg;
    int start = id * slice;
    int end = start + slice;
    for (int i = start; i < end; i++)
    {
        A[i] = B[i] + C[i];
    }

    pthread_exit(NULL);
}

int main()
{
    pthread_t threads[THREADS];
    for (int i = 0; i < VEC_SIZE; i++)
    {
        B[i] = i;
        C[i] = i;
    }

    int ids[THREADS];

    for (int i = 0; i < THREADS; i++)
    {
        ids[i] = i;
        pthread_create(&threads[i], NULL, sum, &ids[i]);
    }

    double timetick = dwalltime();

    for (int i = 0; i < THREADS; i++)
    {
        pthread_join(threads[i], NULL);
    }

    printf("Time: %f\n", dwalltime() - timetick);



    int check = 1;
    for (int i = 0; i < VEC_SIZE; i++)
    {
        check = check && (A[i] == (i * 2));
    }
    printf("Check: %s\n", check ? "OK" : "ERROR");

    return 0;
}
